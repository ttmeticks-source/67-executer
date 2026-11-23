#!/bin/bash

echo "🚀 Installing 67 EXECUTER..."

# Check macOS version
MACOS_VERSION=$(sw_vers -productVersion | cut -d '.' -f 2)
if [ "$MACOS_VERSION" -lt 11 ]; then
    echo "❌ This executer requires macOS 11.0 or higher."
    exit 1
fi

# Create directory structure
mkdir -p 67Executer.app/Contents/MacOS
mkdir -p 67Executer.app/Contents/Resources
mkdir -p scripts

# Copy files (assuming they exist in repo root)
cp main.py 67Executer.app/Contents/Resources/main.py
cp lib67inject.dylib 67Executer.app/Contents/Resources/lib67inject.dylib
cp icon.png 67Executer.app/Contents/Resources/icon.png
cp Info.plist 67Executer.app/Contents/Info.plist

# Make executable
chmod +x 67Executer.app/Contents/Resources/main.py
chmod +x lib67inject.dylib

# Generate curl command for terminal usage
curl_command='curl -fsSL https://raw.githubusercontent.com/yourusername/67-executer/main/install.sh | bash'
echo ""
echo "✅ Installation complete!"
echo ""
echo "📋 To install on another Mac, run this in Terminal:"
echo ""
echo "   $curl_command"
echo ""
echo "💡 To use: Open 67Executer.app from Applications folder."
