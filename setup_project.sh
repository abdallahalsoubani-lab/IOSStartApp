#!/bin/bash

set -e

echo "🔧 Enterprise iOS Starter Template - Setup Script"
echo "=================================================="
echo ""

# Check if Ruby is available
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby is not installed. Please install Ruby first."
    exit 1
fi

echo "✅ Ruby found"
echo ""

# Check if Xcodeproj gem is installed
echo "📦 Checking for Xcodeproj gem..."
if ! gem list xcodeproj | grep -q xcodeproj; then
    echo "📥 Installing Xcodeproj gem..."
    sudo gem install xcodeproj --quiet
    echo "✅ Xcodeproj gem installed"
else
    echo "✅ Xcodeproj gem already installed"
fi

echo ""
echo "🚀 Creating Xcode project..."
ruby setup_xcode_project.rb

echo ""
echo "📦 Installing CocoaPods dependencies..."
if [ ! -d "Pods" ]; then
    pod install
    echo "✅ Pods installed"
else
    echo "✅ Pods already installed"
fi

echo ""
echo "✨ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "   1. open IOSStartApp.xcworkspace"
echo "   2. Select scheme YGB-Debug or DEMO-Debug"
echo "   3. Build and run!"
echo ""
echo "💡 Tips:"
echo "   - Check SETUP_GUIDE.md for detailed configuration"
echo "   - See AppGuideView in the app for component examples"
echo "   - Update xcconfig files for your flavor"
echo ""
