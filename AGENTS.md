# Repository Guidelines

## Project Structure & Module Organization
- Source: `lib/` (features, models, utils, pages, notifications). Entry: `lib/main.dart`.
- Tests: `test/unit/` (logic) and `test/widget/` (widgets, mocks).
- Assets: `assets/images/`, `assets/sounds/`; web shell in `web/`.
- Platform: `ios/`, `macos/`, `windows/`, `linux/` as platform projects.
- Config: lints in `analysis_options.yaml`; localization config in `slang.yaml`; CI in `.github/workflows/testing.yaml`.
- Env/secrets: `.env` is required at runtime (not committed). Request keys from maintainers.

## Build, Test, and Development Commands
- Install deps: `flutter pub get`
- Analyze code: `flutter analyze`
- Format code: `dart format .`
- Run tests: `flutter test`
- Coverage (HTML): `./test_coverage.sh` (opens report at `coverage/html/index.html`).
- Run app (device/emulator): `flutter run -d <device-id>`
- Build Android bundle: `./build_android.sh` (uses `dart_defines/prod.json`).
- Build iOS: `./build_ios.sh` (uses `dart_defines/prod.json`).
- Codegen (when needed): `dart run build_runner build --delete-conflicting-outputs`

## Coding Style & Naming Conventions
- Lints: Uses `flutter_lints` via `analysis_options.yaml`.
- Indentation: 2 spaces; avoid trailing whitespace.
- Files: `lower_snake_case.dart` (e.g., `answer_history.dart`).
- Classes/Enums: `UpperCamelCase`; methods/vars: `lowerCamelCase`.
- Keep widgets small; prefer pure functions in `lib/utils/`; share types in `lib/models/`.

## Testing Guidelines
- Framework: `flutter_test` with Mockito for mocks.
- Locations: unit tests in `test/unit/`, widget tests in `test/widget/`.
- Naming: mirror source and end with `_test.dart` (e.g., `word_test.dart`).
- Run locally: `flutter test` (CI runs on PRs and `main`). Aim to cover business logic in models/utils.

## Commit & Pull Request Guidelines
- Commits: short, imperative mood (e.g., “Fix android build”, “Introduce SentryService”); reference issues `#123` when relevant.
- PRs: include description, linked issues, before/after screenshots for UI, and test notes. Ensure `flutter analyze` and `flutter test` pass.
- Avoid committing secrets; `.env` and platform service files are ignored. Use `dart_defines/dev.json` for local dev when applicable.

