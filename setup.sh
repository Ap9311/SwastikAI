#!/bin/bash
# SwastikAI – Complete Silent Setup

echo "🕉️  Setting up SwastikAI..."
echo ""

# Check and install Python silently
if ! command -v python &> /dev/null; then
    pkg install python -y > /dev/null 2>&1
fi

# Check and install Ollama silently
if ! command -v ollama &> /dev/null; then
    curl -s -L -o $PREFIX/bin/ollama https://github.com/ollama/ollama/releases/download/v0.3.14/ollama-linux-arm64
    chmod +x $PREFIX/bin/ollama > /dev/null 2>&1
fi

# Check if llama-server exists, build it silently
if ! command -v llama-server &> /dev/null; then
    mkdir -p $PREFIX/lib/ollama
    
    # Try to install via pkg
    pkg install llama-cpp -y > /dev/null 2>&1
    
    # If still missing, download pre-built
    if ! command -v llama-server &> /dev/null; then
        curl -s -L -o $PREFIX/bin/llama-server https://github.com/ggerganov/llama.cpp/releases/download/b4584/llama-server
        chmod +x $PREFIX/bin/llama-server > /dev/null 2>&1
    fi
    
    # Create symlink
    ln -sf $PREFIX/bin/llama-server $PREFIX/lib/ollama/llama-server 2>/dev/null || true
fi

# Start server silently
ollama serve > /dev/null 2>&1 &
sleep 3

# Create model silently
if ! ollama list 2>/dev/null | grep -q "swastik-ai"; then
    ollama create swastik-ai -f Modelfile > /dev/null 2>&1
fi

echo ""
echo "✅ SwastikAI is ready!"
echo ""
echo "Run: ./swastik"
