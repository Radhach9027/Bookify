# Bookify App – Modular Travel Platform

Bookify is a unified, modular, server‑driven travel and convenience app supporting Hotels, Flights, Buses, Trains, Events, Wallet, and Loyalty.  
The entire system is built on top of a clean, scalable, domain‑oriented, multi‑module architecture.

---

## 🧱 Architecture Overview

Bookify follows a **Modular Monolith + SPM Packages** approach:

```
App (Bookify)
│
├── BookifyDesignSystem
├── BookifyModelKit
├── BookifyDomainKit
├── BookifySharedSystem
├── NavigatorKit
├── NetworkClient
├── BookifyAuthentication
└── Feature Modules
      ├── Hotels
      ├── Flights
      ├── Buses
      ├── Trains
      └── Events
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
