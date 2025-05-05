# FakeStore App

A cross-platform Flutter application built using Clean Architecture that consumes the FakeStore API to provide a smooth and structured product browsing experience. This app is designed for both Android and iOS platforms and showcases best practices in Flutter development.

---

## Features

* **Product Listing**

  * Fetches and displays products with image, title, price, category, and ratings using [FakeStore API](https://fakestoreapi.com/products).
* **Product Details**

  * Tapping a product shows full details: large image, description, and price with a dummy “Add to Cart” button.
* **Category Filter**

  * Filters products by category using [FakeStore API](https://fakestoreapi.com/products/categories).
* **Cart System**

  * Simple in-memory cart with add/remove items and total price calculation.
* **State Management**

  * Built using the Bloc pattern and `flutter_bloc`.

---

## Features Added as Bonus

* Pull-to-refresh
* Multi-language support (using `flutter_localizations` and `intl`)
* Error handling with loading indicators
* Clean Architecture
* SOLID principle

---

## Architecture

* **Clean Architecture**: Divided into `domain`, `data`, and `presentation` layers.
* **State Management**: Bloc (`flutter_bloc`)
* **Dependency Injection**: Using `get_it`
* **Functional Programming**: Using `dartz` for `Either` types and clean error handling

---

## Packages Used

| Package                | Purpose                               |
| ---------------------- | ------------------------------------- |
| `flutter_bloc`         | State management                      |
| `get_it`               | Dependency injection                  |
| `dartz`                | Functional error handling (Either)    |
| `logger`               | Logging utility                       |
| `go_router`            | Navigation and routing                |
| `go_transitions`       | Page transitions for `go_router`      |
| `flutter_dotenv`       | Environment variable support          |
| `hive_ce`              | Lightweight local storage             |
| `hive_ce_flutter`       | Lightweight local storage             |
| `intl`                 | Internationalization and localization |
| `flutter_easyloading`  | Customizable loading indicators       |
| `flutter_spinkit`      | Loading spinners                      |
| `flutter_svg`          | Rendering SVG images                  |
| `http`                 | Networking                            |
| `url_launcher`         | Launch URLs externally                |
| `solar_icon_pack`      | Custom icon set                       |
| `fluttertoast`         | Toast messages                        |
| `uuid`                 | Generate unique identifiers           |

---

## Run Instructions

1. **Clone the Repository**

```bash
git clone https://github.com/your-username/fakestore_app.git
cd fakestore_app
```

2. **Install Dependencies**

```bash
flutter pub get
```

3. **Run the App**

```bash
flutter run
```

4. **Generate Code (if needed)**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Assumptions

* The "Add to Cart" button is non-functional backend-wise.
* Cart data is temporary and held in memory.
* The app supports FakeStore API only.
* Network connectivity is expected to view HomePage.
* Local persistence is limited to `Hive`.

---
