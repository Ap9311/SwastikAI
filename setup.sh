#!/bin/bash
# SwastikAI Setup – Fully Automatic

echo "🕉️  SwastikAI Setup"
echo "==================="
echo ""

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo ">> Installing SwastikAI Engine..."
    cd ~
    pkg update
    pkg install golang git cmake -y
    git clone https://github.com/ollama/ollama.git
    cd ollama
    go generate ./...
    go build .
    mv ollama $PREFIX/bin/
    cd ~/SwastikAI
    echo "✅ SwastikAI Engine installed!"
fi

# Check if model exists
if ollama list 2>/dev/null | grep -q "swastik-ai"; then
    echo "✅ SwastikAI model ready."
else
    echo ">> Creating SwastikAI..."
    ollama create swastik-ai -f Modelfile
    echo "✅ SwastikAI created!"
fi

echo ""
echo "🚀 Ready! Run: ./swastik"
