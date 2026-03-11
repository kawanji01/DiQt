#!/bin/bash

set -euo pipefail

echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "🏗️ Building iOS app..."
flutter build ios --dart-define-from-file=dart_defines/prod.json

echo "✅ Build process completed!" 
