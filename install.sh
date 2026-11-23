#!/bin/bash

echo "🚀 Installing 67 EXECUTER..."

# Check macOS version (FIXED: checks MAJOR version, not minor)
MACOS_MAJOR=$(sw_vers -productVersion | awk '{print $1}' | cut -d '.' -f 1)
if [ "$MACOS_MAJOR" -lt 11 ]; then
    echo "❌ This executer requires macOS 11.0 (Big Sur) or higher."
    exit 1
fi
echo "✅ macOS version detected: $(sw_vers -productVersion)"

# Create directory structure
mkdir -p 67Executer.app/Contents/MacOS
mkdir -p 67Executer.app/Contents/Resources
mkdir -p scripts

# Copy files (assuming they exist in repo root)
cp main.py 67Executer.app/Contents/Resources/main.py
cp lib67inject.dylib 67Executer.app/Contents/Resources/lib67inject.dylib
cp icon.png 67Executer.app/Contents/Resources/icon.png
cp info.plist 67Executer.app/Contents/Info.plist

# Make executable
chmod +x 67Executer.app/Contents/Resources/main.py
chmod +x lib67inject.dylib

# Generate curl command for terminal usage
curl_command='curl -fsSL https://raw.githubusercontent.com/ttmeticks-source/67-executer/main/install.sh | bash'
echo ""
echo "✅ Installation complete!"
echo ""
echo "📋 To install on another Mac, run this in Terminal:"
echo ""
echo "   $curl_command"
echo ""
echo "💡 To use: Open 67Executer.app from Applications folder."
