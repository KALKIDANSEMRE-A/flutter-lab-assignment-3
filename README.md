# Album App

A Flutter application that displays albums and photos from the JSONPlaceholder API. The app follows the MVVM architecture pattern and uses BLoC for state management.

## Features

- Display a list of albums
- View photos for each album
- Error handling and loading states
- Clean architecture with MVVM pattern
- State management using BLoC
- Navigation using GoRouter

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:

```bash
git clone <repository-url>
```

2. Navigate to the project directory:

```bash
cd album_app
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model**: Data models and repositories
- **View**: UI components (pages and widgets)
- **ViewModel**: BLoC for state management

### Project Structure

```
lib/
├── features/
│   └── albums/
│       ├── data/
│       │   └── datasources/
│       │       └── albums_remote_data_source.dart
│       ├── domain/
│       │   ├── models/
│       │   │   ├── album.dart
│       │   │   └── photo.dart
│       │   └── repositories/
│       │       └── albums_repository.dart
│       └── presentation/
│           ├── bloc/
│           │   └── albums_bloc.dart
│           └── pages/
│               ├── albums_page.dart
│               └── album_detail_page.dart
└── main.dart
```

## Dependencies

- flutter_bloc: State management
- go_router: Navigation
- http: Network requests
- cached_network_image: Image caching
- equatable: Value equality

## API

The app uses the JSONPlaceholder API:

- Albums: https://jsonplaceholder.typicode.com/albums
- Photos: https://jsonplaceholder.typicode.com/photos
