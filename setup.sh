#!/bin/bash
# SwastikAI – Fast Setup (Pre-built Binary)

echo "🕉️  Setting up SwastikAI..."
echo ""

# Install Python if missing
if ! command -v python &> /dev/null; then
    pkg install python -y > /dev/null 2>&1
fi

# Install pip if missing
if ! command -v pip &> /dev/null; then
    pkg install python-pip -y > /dev/null 2>&1
fi

# Install Python dependencies
echo ">> Installing dependencies..."
pip install requests > /dev/null 2>&1

# Create directory for llama-server
mkdir -p ~/llama.cpp/build/bin

# Download pre-built llama-server
if [ ! -f ~/llama.cpp/build/bin/llama-server ]; then
    echo ">> Downloading SwastikAI engine..."
    curl -L -o ~/llama.cpp/build/bin/llama-server https://github.com/ggerganov/llama.cpp/releases/download/b4584/llama-server
    chmod +x ~/llama.cpp/build/bin/llama-server
    echo "✅ Engine downloaded!"
fi

echo ""
echo "✅ SwastikAI is ready!"
echo ""
echo "Run: ./swastik"
