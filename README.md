# Bookify App – Modular Travel Platform

Bookify is a unified, modular, server‑driven travel and convenience app supporting Hotels, Flights, Buses, Trains, Events, Wallet, and Loyalty.  
The entire system is built on top of a clean, scalable, domain‑oriented, multi‑module architecture.

---

## 🧱 Architecture Overview

Bookify follows a **Modular Monolith + SPM Packages** approach:

```
Bookify (iOS App)
│
├── App
│   ├── BookifyApp (@main)
│   │   - SwiftUI entry point.
│   │   - Creates AppNavigator + NavigationCoordinator.
│   │   - Hosts NavigationHost / RouteSwitchHost.
│   │   - Kicks off appNav.start() on launch.
│   │
│   ├── AppNavigator
│   │   - Owns AppRoute: .splash, .shell, .launchError(String).
│   │   - On start():
│   │       • Shows splash for a minimum delay.
│   │       • Calls BookifySetup.bootstrap().
│   │       • On success → routes to .shell (RootShellView).
│   │       • On failure → routes to .launchError.
│   │
│   ├── BookifySetup (Composition Root)
│   │   - Loads AppConfig from AppConfiguration.json.
│   │   - Seeds DIContainer with:
│   │       • AppConfig (singleton)
│   │       • EventBusType (singleton EventBus)
│   │   - Registers feature modules:
│   │       • HotelsSetup.register()
│   │       • BookingsSetup.register()
│   │       • (later) FlightsSetup, BusesSetup, TrainsSetup, EventsSetup…
│   │   - Wraps failures as SetupError (e.g. hotelsRegistrationFailed).
│   │
│   └── RootShellView
│       - Main tabbed shell after setup succeeds.
│       - Uses MainTab enum to host feature entry views.
│       - Uses AppTabBar + appTopBar (from BookifyDesignSystem).
│       - Injects NavigationCoordinator into feature roots.
│
├── Packages
│   ├── BookifyDesignSystem      # UI components, theming, typography
│   ├── BookifyModelKit          # Core domain models (Hotels, Flights, etc.)
│   ├── BookifyDomainKit         # Use cases, business rules, domain services
│   ├── BookifySharedSystem      # Shared utilities, config, logging, analytics
│   ├── NavigatorKit             # Navigation abstractions, deep links, flows
│   ├── NetworkClient            # API client, HTTP layer, interceptors
│   └── BookifyAuthentication    # Auth flows, tokens, session management
│
└── FeatureModules
    ├── Hotels                   # Hotels feature (screens, view models, wiring)
    │   └── HotelsSetup.register()
    │       - Registers routes in NavigatorKit.
    │       - Binds Hotels use cases + repositories into DIContainer.
    │       - Wires Hotels entry view into MainTab.hotels.resolvedView().
    │
    ├── Flights                  # (future) Flights feature + FlightsSetup.register()
    ├── Buses                    # (future) Buses feature + BusesSetup.register()
    ├── Trains                   # (future) Trains feature + TrainsSetup.register()
    └── Events                   # (future) Events feature + EventsSetup.register()

```

Each feature is isolated with:
- Its own models  
- Use cases  
- Coordinators & routes  
- UI templates & organisms (SDUI ready)

---

## 📦 Package Breakdown

### **1. BookifyDesignSystem**
Reusable UI components:
- Atoms → Icons, Typography, Buttons  
- Molecules → Cards, Pills, Inputs  
- Organisms → HotelCard, Carousel, Filters  
- Templates → HotelListTemplate, DashboardTemplate  
- ThemeConfig, Colors, Spacing Tokens  
- Custom AsyncImage, RatingStars, PriceBlock  

---

### **2. BookifyModelKit**
Contains **pure models only**:
- Hotels  
- Rooms  
- Flights  
- Cities  
- AppConfig  
- ThemeConfig, ServicesConfig  
- Codable structures shared across features  

---

### **3. BookifyDomainKit**
Domain logic + Use Cases:
- FetchHotelsUseCase  
- SearchFlightsUseCase  
- WalletBalanceUseCase  
- Review parsing  
- JSON loaders and caching  
- Error handling model (NetworkError, AppError)

Uses:
- Repository interfaces  
- DI-based implementations  

---

### **4. BookifySharedSystem**
Cross-cutting system modules:
- Logger  
- Cache  
- Storage (Keychain + FileManager utilities)  
- Localization / Font Loader  
- SDUI Runtime Parser  
- Reachability + AppLifeCycle  

---

### **5. NetworkClient**
Internal networking engine:
- Request building  
- Adapters (URLSession-backed)  
- Interceptors (Auth, Logging)  
- Retry / Circuit breaker  
- Decoders + Error mapping  
- Mockable using protocols  

---

### **6. NavigatorKit**
Feature‑independent navigation framework:
- `NavigationCoordinator`  
- `NavigationHost`  
- Deep links  
- Routing registry  
- Presenter modes (push, sheet, full screen)  

Used by all modules but **does not depend on features**.

---

### **7. Authentication Module**
Handles:
- Login / OTP  
- Token refresh  
- Secure storage  
- User profile context  
- Middleware for requests  

---

## 🧩 Feature Example – Hotels Module

Structure:
```
Hotels/
 ├── Models
 ├── ViewModels
 ├── UseCases (from DomainKit)
 ├── Templates (from DesignSystem)
 ├── HotelList
 ├── HotelDetail
 └── Routing (NavigatorKit)
```

Includes:
- HotelsDashboard  
- HotelCardProps  
- HotelListTemplate  
- Filters + Selection Organisms  
- Async remote loading with LoadState  

---

## 🏗 SDUI – Server Driven UI

Bookify supports backend‑driven configuration:
- Page templates  
- Sections (carousel, list, filter)  
- UI configs (colors, themes, spacing)  
- Dynamic copy (localized JSON packs)  
- Dynamic font loading  

All handled via:
- `SDUIConfig`  
- `AppConfig`  
- Atomic UI components  

---

## 🧪 Testing Strategy

- Snapshot tests for UI components (DesignSystem)  
- Unit tests for UseCases (DomainKit)  
- Integration tests for NetworkClient  
- Simulator UI tests for navigation + SDUI  

---

## 🚀 Build & Run

1. Clone repository  
2. Open `Bookify.xcodeproj`  
3. Select **iOS scheme**  
4. Ensure SPM dependencies resolve  
5. Run on iPhone simulator (15+)  

---

## 🗺 Roadmap

- AI Travel Assistant  
- Push promotion engine  
- Multi‑city trip planner  
- Complete SDUI form rendering  
- Offline caching & sync  
- Performance metrics overlay  

---

## 🧑‍💻 Author  

**Ch. Radhachandan**  
Mobile Architect | iOS | Flutter | Clean Architecture Enthusiast  
📍 Hyderabad, India.
