# Bookify Architecture Guide

This document is the single source of truth for how we structure code, wire dependencies, and ship work (stories) end-to-end. It is intentionally comprehensive so any contributor can create or evolve features consistently.

Audience: iOS engineers, designers, product, QA, and DevOps.

Platform baseline
- Apple platforms: iOS 15+
- Language: Swift 5.9+ (prefer Swift Concurrency)
- UI: SwiftUI-first, UIKit only when required
- Package manager: Swift Package Manager (SPM)

1) Package topology

Application packages (domain and UI)
- BookifyDesignSystem
  - Design tokens bridge, primitives (AText, ASurface, chips, rating, cards), theming via Environment.
- BookifyDomainKit
  - Use cases, domain entities, mappers; the only package that talks to NetworkClient.
- BookifyModelKit
  - Codable models/configs: ThemeConfig, Money, FeatureFlags, ExperimentsConfig, etc.
- BookifySharedSystem
  - Cross-cutting helpers/utilities/extensions that are UI-agnostic.
- DevToolKit
  - Local developer tools, preview providers, scaffolding scripts, diagnostics.
- BookifyLoggerSystem
  - Logging façade and sinks (OSLog, file, remote). Do not log PII.
- BookifyTelemetryKit
  - Metrics/traces/events. Expose a stable API; route to chosen backend.
- BookifyAuthentication
  - Auth config, token models, sign-in/out, secure storage.

Global packages (shared infra)
- DependencyContainer
  - DI container. Provide protocols + default/live/test registrations.
- NavigatorKit
  - Navigation abstractions and route coordination for SwiftUI.
- NetworkClient
  - HTTP client used only by BookifyDomainKit. Never import it from UI packages or app targets.

Dependency rules
- App target can import any app package and globals.
- BookifyDesignSystem can import BookifyModelKit (tokens) but not Domain or Network.
- BookifyDomainKit can import BookifyModelKit, DependencyContainer, NetworkClient, Logger, Telemetry.
- BookifyAuthentication can import NetworkClient, ModelKit, Logger, Telemetry.
- SharedSystem can import nothing app-specific; only Foundation/Swift/SwiftUI (if needed).
- Cycles are forbidden. UI never imports NetworkClient directly.

2) Modules and feature template

Top-level modules
- Bookings
- Hotels

SwiftPM file layout (example: Hotels)
- Package
- Sources/Hotels
  - Features/
    - HotelsDashBoard/
      - Presentation/
        - View/
          - HotelsDashboardView.swift
        - ViewModel/
          - HotelsDashboardViewModel.swift
      - Domain/ (optional if module-specific)
      - Data/ (optional if module-specific)
    - HotelsList/
    - HotelDetailsPage/
  - Routes/
    - HotelRouteSource.swift
  - Setup/
    - HotelRoutes.swift
    - HotelsSetup.swift

Feature design pattern (MVVM + Coordinator + UseCases)
- Presentation
  - View (SwiftUI): declarative UI, no business logic.
  - ViewModel (ObservableObject, @MainActor): orchestrates use cases, maps domain models to view props, manages LoadState.
- Domain (optional per module): feature-scoped use cases if not part of BookifyDomainKit.
- Data (optional per module): feature-scoped repositories/adapters; otherwise live in BookifyDomainKit.
- Routes: strongly-typed route sources; use NavigatorKit for push/present/sheet.
- Setup: dependency registrations for this module (DI), route wiring, environment configuration.

Naming conventions
- Feature folder: <FeatureName> (PascalCase)
- View: <FeatureName>View
- ViewModel: <FeatureName>ViewModel
- Props structs: Suffix Props; Identifiable and Equatable
- Use cases: VerbNounUseCase (e.g., FetchHotelsUseCase)

3) Design system usage

Tokens and theme
- ThemeConfig (BookifyModelKit) defines brand, radius, colors (solid/dynamic).
- BookifyDesignSystem exposes BookifyTheme via Environment:
  - Colors: primary, onPrimary, background, onBackground, surface, onSurface, accent, success, warning, error.
  - Corner radius: fixed or scale.
- Views read @Environment(\.bookifyTheme) and avoid hard-coded colors/radii.
- Typography: prefer AText or system fonts via a centralized style enum.

Primitives and organisms
- Use ASurface for cards/containers.
- Compose organisms (e.g., HotelCard) from primitives and read theme.

Accessibility
- Support Dynamic Type, VoiceOver labels/hints, and sufficient contrast.

4) Dependency injection

- All services are resolved via DependencyContainer.
- Provide three registrations per service where applicable:
  - live: production implementation
  - mock: deterministic for previews/tests
  - failing: explicit crash for missing dependencies in tests
- ViewModels request only protocol abstractions.

Example
- HotelsSetup registers Hotels routes and any module-specific services.
- Domain-level services like HotelsRepository are registered in BookifyDomainKit.

5) Networking

- NetworkClient is only used by BookifyDomainKit (and Auth).
- Use async/await.
- Map transport DTOs to domain entities in DomainKit.
- Enforce request/response logging via BookifyLoggerSystem (redact PII).
- Add telemetry spans for critical calls in BookifyTelemetryKit.

6) Navigation

- Use NavigatorKit coordinators.
- Define RouteSource per module; centralize routes in Setup.
- No direct NavigationLinks scattered in views; use injected coordinator.

7) State management

- Use @State, @StateObject, @EnvironmentObject in SwiftUI.
- ViewModels are @MainActor and ObservableObject.
- LoadState enum: idle, loading, loaded(T), failed. Never block main thread.

8) Testing

- Use Swift Testing framework (Swift 5.9+) with async tests.
- Structure tests parallel to Sources.
- Provide mocks in DevToolKit or dedicated TestSupport target.
- Snapshot tests for DS components when valuable.
- Contract tests for UseCases/Repositories.

Example
@Suite("Hotels: Fetch and map to card props")
struct HotelsDashboardTests {
    @Test
    func mapsHotelsToCards() async throws {
        // Arrange domain mocks and dependencies
        // Act: call VM.fetchHotels()
        // Assert: #expect(state == .loaded(expected))
    }
}

9) Story workflow (JIRA → PR → CI/CD → Release)

Branching
- Branch name: feature/<JIRAKEY>-kebab-title or bugfix/<JIRAKEY>-kebab-title
- One JIRA ticket per PR when feasible.

Commit messages
- Conventional commits: feat:, fix:, refactor:, chore:, docs:, test:, perf:
- Include JIRA key in the subject: feat(Hotels): HJ-123 add dashboard skeleton

Pull requests
- Title: [HJ-123] Hotels dashboard: load and display cards
- Link JIRA via smart commits or PR body.
- Include screenshots, accessibility notes, and risk assessment.
- Add labels: module:hotels, type:feature, needs-review, etc.

CI (GitHub Actions suggested)
- Workflows:
  - ci.yml: build, test, lint, swiftformat check, unit + snapshot tests.
  - pr.yml: runs on pull_request; required checks must pass.
  - release.yml: tag-based release builds and TestFlight (if applicable).
- Secrets: JIRA_TOKEN, FIGMA_TOKEN, GITHUB_TOKEN (default), TELEMETRY_API_KEY.
- Caching: DerivedData and SPM.

Gates
- Build success for all targets
- Tests green
- Lint/format passes
- Bundle identifiers and provisioning validated for release jobs

Release notes
- Generated from conventional commits and PR labels; attach to GitHub releases.

10) Telemetry and logging

- BookifyLoggerSystem
  - OSLog categories per module, privacy annotations, redaction.
- BookifyTelemetryKit
  - Spans for navigation transitions, network calls, and critical UI interactions.
  - Metrics: cold start, TTI, error rates, network latency.

11) Security and privacy

- Secrets via GitHub Actions Environments/Secrets; never commit.
- Keychain for tokens (BookifyAuthentication).
- Do not log PII; mark as .private in OSLog.

12) MCP integrations (placeholders)

Figma (MCP server)
- Endpoint: https://mcp.figma.example.com (placeholder)
- Token env var: FIGMA_TOKEN
- Usage:
  - Designers attach node IDs in JIRA tickets.
  - Devs fetch specs via DevToolKit scripts: devtools/figma pull --node <id> --out Docs/Design

JIRA (MCP server)
- Endpoint: https://mcp.jira.example.com (placeholder)
- Token env var: JIRA_TOKEN
- Usage:
  - devtools/jira transition HJ-123 "In Review" --comment "PR #456 opened"
  - devtools/jira attach HJ-123 --file Docs/Design/HJ-123-spec.pdf

GitHub (PR/CI/CD)
- Actions workflows in .github/workflows
- PR templates at .github/pull_request_template.md
- CODEOWNERS enforced for modules
- Required checks: build, tests, lint, snapshot

13) Story-to-code checklist

Before you code
- Read this document and the ticket acceptance criteria.
- Confirm design node IDs and tokens (ThemeConfig deltas if any).
- Identify affected packages and modules; verify dependency rules.

Scaffold
- Create feature folder: Sources/<Module>/Features/<Feature>/{Presentation/{View,ViewModel}, Domain?, Data?}
- Add routes in Sources/<Module>/Routes and wire in Setup.
- Register dependencies in Setup.

Implement
- Use ViewModel with async/await, DI use cases, and LoadState.
- Use BookifyDesignSystem components; read theme via Environment.
- Add previews with mock dependencies (DevToolKit).
- Add telemetry events and logs.

Validate
- Unit tests for ViewModel, snapshot tests for DS components.
- Accessibility pass (VoiceOver, Dynamic Type).
- Update Docs/Stories/<JIRAKEY>.md with screenshots and decisions.

Ship
- Open PR with JIRA link; ensure CI green.
- Transition JIRA to “In Review”.
- After merge, “Done” with release notes link.

14) Example: creating HotelsList feature

- Create folders:
  - Sources/Hotels/Features/HotelsList/Presentation/View/HotelsListView.swift
  - Sources/Hotels/Features/HotelsList/Presentation/ViewModel/HotelsListViewModel.swift
- ViewModel:
  - Inject FetchHotelsUseCase from BookifyDomainKit via DependencyContainer.
  - Expose @Published state: LoadState<[HotelCardProps]>.
- View:
  - Render state; use HotelCard and DS components.
  - Use NavigatorKit for navigation to HotelDetailsPage.
- Routes:
  - Add HotelsListRoute in HotelRouteSource.swift; update HotelRoutes.swift.
- Setup:
  - Register feature routes in HotelsSetup.swift.
- Tests:
  - Add HotelsListViewModelTests with mocks.
- Docs:
  - Docs/Stories/HJ-456-hotels-list.md with screenshots and decisions.

15) Coding conventions

- Swift Concurrency over GCD/Combine unless interop needed.
- Avoid singletons except for immutable constants.
- Protocol-first design for services.
- Keep Views pure; move logic to ViewModels and UseCases.
- Prefer small, composable views and modifiers.
- No hard-coded strings; localize with .strings when user-facing.

16) Linting & formatting

- SwiftFormat and SwiftLint run in CI.
- Pre-commit hook optional via DevToolKit.

17) Documentation

- This file governs architecture decisions.
- Each story adds Docs/Stories/<JIRAKEY>-slug.md
- Public types should have doc comments in frameworks.

18) Open questions / placeholders to configure

- Fill actual JIRA cloud domain and project keys.
- Fill Figma MCP server endpoint and token management.
- Confirm CI provider and distribution strategy.
- Define telemetry backend (e.g., OpenTelemetry endpoint) and sampling.
- Decide on SwiftGen or SPM resources for localized strings and assets.

Appendix: Dependency diagram (summary)
- App → {DesignSystem, DomainKit, ModelKit, SharedSystem, Logger, Telemetry, Authentication}
- DomainKit → {NetworkClient, ModelKit, Logger, Telemetry, DependencyContainer}
- DesignSystem → {ModelKit}
- Authentication → {NetworkClient, ModelKit, Logger, Telemetry}
- Global: {DependencyContainer, NavigatorKit} referenced by app and modules
