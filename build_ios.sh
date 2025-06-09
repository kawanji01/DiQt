#!/bin/bash

echo "🧹 Cleaning Flutter project..."
flutter clean

echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "🏗️ Building iOS app..."
flutter build ios --dart-define-from-file=dart_defines/prod.json

echo "✅ Build process completed!" 