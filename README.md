# Ecommerce Flutter Application

## Overview
This project is a comprehensive ecommerce application built with Flutter. It includes robust features such as a wishlist, product browsing, cart management, and user authentication. The application ensures a seamless shopping experience with local data persistence using `shared_preferences` and is structured following a clean, modular architecture.

---
##Watch Demo
https://www.loom.com/share/7dc2cffbfc844a66a3a01f806e28a9d1?sid=94e107ed-66c9-464e-9cea-208ef6c53484

## Architecture

The project follows **Clean Architecture**, separating responsibilities into three main layers:

### Domain Layer
- Defines core business logic and entities:
  - `ProductEntity`, `CartEntity`, `UserEntity`
- Repository interfaces:
  - `WishlistRepository`, `CartRepository`, `UserRepository`

### Data Layer
Responsible for all data operations:

- **Local Data Sources:**
  - `WishlistLocalDataSource`
  - `CartLocalDataSource`
  - `UserLocalDataSource` (stores user profile and cart data locally)

- **Remote Data Sources:**
  - `ProductRemoteDataSource` (can be extended for remote cart/user APIs)

- **Models:**
  - `ProductModel`, `CartModel`, `UserModel`

- **Repository Implementations:**
  - `WishlistRepositoryImpl`
  - `CartRepositoryImpl`
  - `UserRepositoryImpl`

### Presentation Layer
Manages UI and state using BLoC pattern:

- **BLoCs:**
  - `WishlistBloc`
  - `CartBloc`
  - `UserBloc`
  - `ProductBloc`

- **UI Screens:**
  - `WishlistScreen`
  - `CartScreen`
  - `HomePage`
  - `ProductDetailPage`
  - `Dashboard`
  - `ProfileScreen`

---

## Features

### Wishlist
- Add, remove, and view items
- Prevents duplicate entries
- Locally persisted for offline access

### Cart Management
- Add/update products
- Stores recent cart locally for offline use
- Restores cart state on app relaunch

### User Info
- Secure login
- Enables quick app launch and personalization

### Product Browsing
=- Detailed product view

---
## State Management

Utilizes the **BLoC pattern** for all features, with each BLoC handling events (e.g., `AddToCartEvent`, `LoadUserEvent`) and mapping them to appropriate states while interacting with repositories and data sources.

---

## Testing

Includes unit tests for:

- BLoC state transitions
- Repository logic
- Local data handling

Testing utilities used:

- `SharedPreferences.setMockInitialValues({})` for mocking user/cart info and preferences
- `mockito` package for component isolation

### How to Run Tests

```bash
flutter pub get
flutter pub run build_runner build
flutter test


# Notes
User profile and last used cart data are persisted locally for faster access and offline functionality.

Default widget_test.dart can be removed if unused.

SharedPreferences is used to persist:

Wishlist

Cart items

User token/info


## Folder Structure
ecommerce/
├── lib/
│   ├── core/
│   │   └── error/
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   │   ├── wishlist_local_datasource.dart
│   │   │   │   ├── cart_local_datasource.dart
│   │   │   │   └── user_local_datasource.dart
│   │   │   └── remote/
│   │   │       └── product_remote_datasource.dart
│   │   ├── models/
│   │   │   ├── product_model.dart
│   │   │   ├── cart_model.dart
│   │   │   └── user_model.dart
│   │   └── repositories/
│   │       ├── wishlist_repository_impl.dart
│   │       ├── cart_repository_impl.dart
│   │       └── user_repository_impl.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── product.dart
│   │   │   ├── cart.dart
│   │   │   └── user.dart
│   │   └── repositories/
│   │       ├── wishlist_repository.dart
│   │       ├── cart_repository.dart
│   │       └── user_repository.dart
│   └── presentation/
│       ├── bloc/
│       │   ├── wishlist_bloc.dart
│       │   ├── cart_bloc.dart
│       │   ├── user_bloc.dart
│       │   └── product_bloc.dart
│       └── screen/
│           ├── wishlist_screen.dart
│           ├── cart_screen.dart
│           ├── profile_screen.dart
│           ├── home_page.dart
│           ├── product_detail_page.dart
│           └── dashboard.dart
├── test/
│   ├── data/
│   │   ├── datasources/
│   │   │   ├── wishlist_local_datasource_test.dart
│   │   │   └── user_local_datasource_test.dart
│   │   └── repositories/
│   │       ├── wishlist_repository_test.dart
│   │       └── user_repository_test.dart
│   └── presentation/
│       └── bloc/
│           ├── wishlist_bloc_test.dart
│           └── user_bloc_test.dart
└── pubspec.yaml
```
## Screenshoots
![Image](https://github.com/user-attachments/assets/2d8a0221-e998-4d25-badd-3dff286340cd)
![Image](https://github.com/user-attachments/assets/3ee6bd78-4c57-40a4-bfd0-6b52dbc9ad75)
![Image](https://github.com/user-attachments/assets/c3772af2-e5e9-407e-890c-c7bd427f142c)
![Image](https://github.com/user-attachments/assets/980ed909-0a4d-45cc-b7c9-c42372de5567)
