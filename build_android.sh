#!/bin/bash

echo "🧹 Cleaning Flutter project..."
flutter clean

echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "🏗️ Building Android App Bundle..."
flutter build appbundle --dart-define-from-file=dart_defines/prod.json

echo "✅ Build process completed!" 