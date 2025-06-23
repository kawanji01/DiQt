#!/bin/bash

echo "🧪 Running Flutter tests with coverage..."
flutter test --coverage

if [ $? -eq 0 ]; then
    echo "✅ Tests completed successfully"
    echo "📊 Generating HTML coverage report..."
    genhtml coverage/lcov.info -o coverage/html
    
    if [ $? -eq 0 ]; then
        echo "✅ HTML report generated successfully"
        echo "🌐 Opening coverage report in browser..."
        open coverage/html/index.html
        echo "📁 Coverage files:"
        echo "  - coverage/lcov.info (LCOV format)"
        echo "  - coverage/html/index.html (HTML report)"
    else
        echo "❌ Failed to generate HTML report"
        exit 1
    fi
else
    echo "❌ Tests failed"
    exit 1
fi