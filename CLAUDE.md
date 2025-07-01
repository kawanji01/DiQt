# CLAUDE.md
Always respond to Japanese.
YOU MUST: Execute `terminal-notifier -title "Claude Code" -subtitle "DiQt Apps" -message "Hi👋" -sound default` command only once at the end when completing a task or returning a message to the user
This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Environment Setup
```bash
# Install dependencies
flutter pub get

# Generate translation files
flutter packages pub run build_runner build --delete-conflicting-outputs

# Generate test mocks
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Running the App
```bash
# Development build (connects to localhost:3000)
flutter run --dart-define-from-file=dart_defines/dev.json

# Production build
flutter run --dart-define-from-file=dart_defines/prod.json
```

### Building for Release
```bash
# Android (uses build_android.sh)
./build_android.sh

# iOS (uses build_ios.sh)  
./build_ios.sh

# Manual builds
flutter build appbundle --dart-define-from-file=dart_defines/prod.json
flutter build ios --dart-define-from-file=dart_defines/prod.json
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/answer_reward_test.dart

# Run widget tests
flutter test test/widget/
```

### Code Generation
```bash
# Generate Slang translations after modifying YAML files
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

## Architecture Overview

### Core Architecture Pattern
DiQt uses **Clean Architecture** with **Riverpod** for state management:

- **Presentation Layer**: `lib/pages/` (screens) and `lib/components/` (widgets)
- **Business Logic Layer**: `lib/data/provider/` (Riverpod providers)
- **Data Layer**: `lib/models/` (entities), `lib/data/remote/` (API), `lib/data/local/` (storage)

### State Management with Riverpod
- All state is managed through Riverpod providers in `lib/data/provider/`
- Providers handle API calls, caching, and reactive state updates
- Key providers: `current_user.dart`, `locale.dart`, `quiz.dart`, `review.dart`
- Use `flutter_riverpod` (not `hooks_riverpod`)

### Component Organization
Components are organized by feature domain under `lib/components/`:
- Each feature has its own folder (e.g., `quiz/`, `user/`, `word/`)
- Shared components are in `components/shared/`
- Button components are standardized in `components/button/`

### Navigation and Routing
- Uses Flutter's named routes defined in `routes.dart`
- Route generation handled by `route_generator.dart`
- Deep linking support (currently disabled due to freezing issues)

## Key Technologies

### Primary Stack
- **Flutter 3.27.1** with Dart SDK >=2.17.0 <3.0.0
- **Riverpod** for state management
- **Slang** for internationalization (i18n)
- **HTTP** package for API communication

### Backend Integration
- **Ruby on Rails API** at `https://www.diqt.net` (prod) or `http://localhost:3000` (dev)
- **Firebase** suite (Analytics, Crashlytics, Remote Config, Messaging)
- **RevenueCat** for subscription management
- **Google/Apple Sign-In** for authentication

### UI and UX
- **Material Design** with Google Fonts
- **Infinite scroll pagination** for large datasets
- **Responsive design** using responsive_builder
- **Custom markdown** with dictionary linking
- **Audio support** (TTS, speech-to-text, sound effects)

## Internationalization (i18n)

### Slang Configuration
- Translation files in `lib/i18n/en/` and `lib/i18n/ja/`
- Uses YAML format (not JSON) for better readability
- Namespaced translations organized by feature
- After modifying YAML files, run: `flutter packages pub run build_runner build --delete-conflicting-outputs`

### Adding New Translations
1. Add entries to both `lib/i18n/en/` and `lib/i18n/ja/` directories
2. Run build_runner to regenerate `translations.g.dart`
3. Access translations via `t.featureName.key` (where `t` is the translations import)

## Development Workflow

### Environment Variables
- **Dev environment**: Points to `localhost:3000` (local Rails server)
- **Prod environment**: Points to `https://www.diqt.net`
- Environment configs in `dart_defines/dev.json` and `dart_defines/prod.json`

### API Integration
- All API calls go through providers in `lib/data/remote/`
- HTTP service wrapper in `utils/http_service.dart`
- Error handling standardized across all API calls
- Authentication tokens managed via flutter_secure_storage

### Testing Strategy
- **Unit tests** in `test/unit/` with Mockito for mocking
- **Widget tests** in `test/widget/` for UI components
- **Test builders** in `test/builders/` for generating test data
- **GitHub Actions** CI/CD with automated testing on PRs

### Firebase Configuration
- **Remote Config** for feature flags and maintenance mode
- **Analytics** for user behavior tracking
- **Crashlytics** for crash reporting with automatic error handling
- **Push notifications** with local notification support

## Data Models and Business Logic

### Core Entities
Key models in `lib/models/`:
- `user.dart` - User profiles and authentication
- `quiz.dart` - Learning content and questions
- `drill.dart` - Practice sessions and spaced repetition
- `review.dart` - Scheduled review system
- `word.dart`, `sentence.dart` - Dictionary content
- `achievement.dart` - Gamification and progress tracking

### Spaced Repetition System
- Advanced algorithm for optimal learning intervals
- Review scheduling based on user performance
- Weakness tracking and targeted practice
- Progress analytics and goal setting

### Subscription System
- **RevenueCat** integration for cross-platform subscriptions
- Premium features gated behind subscription checks
- Restore purchases functionality
- Multiple subscription tiers (monthly/annual)

## File Naming and Conventions

### Component Structure
- Screen components: `lib/pages/feature/screen_name.dart`
- Reusable widgets: `lib/components/feature/widget_name.dart`
- Models: `lib/models/entity_name.dart`
- Providers: `lib/data/provider/feature_name.dart`

### Testing Conventions
- Test files mirror source structure with `_test.dart` suffix
- Mock files use `_test.mocks.dart` suffix
- Builder files for test data follow `builder_name.dart` pattern

### Import Organization
- Flutter/Dart imports first
- Third-party package imports second
- Local project imports last
- Relative imports preferred for local files

## Common Development Tasks

### Adding New Features
1. Create models in `lib/models/`
2. Add API integration in `lib/data/remote/`
3. Create Riverpod providers in `lib/data/provider/`
4. Build UI components in `lib/components/`
5. Create screens in `lib/pages/`
6. Add routes to `routes.dart`
7. Add i18n translations and regenerate
8. Write tests for new functionality

### Debugging and Development
- Use `flutter run --dart-define-from-file=dart_defines/dev.json` for local development
- Firebase Remote Config can enable maintenance mode
- Crashlytics provides detailed crash reports
- Use `flutter test` frequently during development

### Performance Considerations
- Infinite scroll pagination for large lists
- Image caching with cached_network_image
- State optimization with selective Riverpod providers
- Lazy loading of content where appropriate