#!/bin/bash
# SwastikAI – Complete Silent Setup

echo "🕉️  Setting up SwastikAI..."
echo ""

# Check and install Python silently if missing
if ! command -v python &> /dev/null; then
    echo ">> Installing Python..."
    pkg install python -y > /dev/null 2>&1
fi

# Check and install Ollama silently
if ! command -v ollama &> /dev/null; then
    echo ">> Installing SwastikAI engine..."
    curl -s -L -o $PREFIX/bin/ollama https://github.com/ollama/ollama/releases/download/v0.3.14/ollama-linux-arm64
    chmod +x $PREFIX/bin/ollama > /dev/null 2>&1
fi

# Check if llama-server exists, build it if missing
if ! command -v llama-server &> /dev/null; then
    echo ">> Building llama-server (this may take a moment)..."
    
    # Create directory for llama-server
    mkdir -p $PREFIX/lib/ollama
    
    # Try to install llama-cpp via pkg first (fastest)
    pkg install llama-cpp -y > /dev/null 2>&1
    
    # If still not found, download pre-built binary
    if ! command -v llama-server &> /dev/null; then
        curl -s -L -o $PREFIX/bin/llama-server https://github.com/ggerganov/llama.cpp/releases/download/b4584/llama-server
        chmod +x $PREFIX/bin/llama-server > /dev/null 2>&1
    fi
    
    # Create symlink in the expected location
    ln -sf $PREFIX/bin/llama-server $PREFIX/lib/ollama/llama-server 2>/dev/null || true
fi

# Start server silently
ollama serve > /dev/null 2>&1 &
sleep 3

# Create model silently
if ! ollama list 2>/dev/null | grep -q "swastik-ai"; then
    echo ">> Creating SwastikAI..."
    ollama create swastik-ai -f Modelfile > /dev/null 2>&1
fi

echo ""
echo "✅ SwastikAI is ready!"
echo ""
echo "Run: ./swastik"
