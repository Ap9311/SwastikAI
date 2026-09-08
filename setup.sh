#!/bin/bash
# SwastikAI Setup – No model download required

echo "🕉️  SwastikAI Setup"
echo "==================="
echo ""

# Check Ollama
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama is not installed."
    echo ""
    echo "Please install Ollama first:"
    echo "  curl -fsSL https://ollama.com/install.sh | sh"
    echo ""
    echo "After installing, come back and run:"
    echo "  ./setup.sh"
    exit 1
fi

echo "✅ Ollama found."

# Check model
if ollama list 2>/dev/null | grep -q "swastik-ai"; then
    echo "✅ SwastikAI model already exists."
else
    echo "🔄 Creating SwastikAI from Modelfile..."
    ollama create swastik-ai -f Modelfile
    echo "✅ SwastikAI created!"
fi

echo ""
echo "🚀 All done! Run: ./swastik"
