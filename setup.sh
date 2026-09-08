#!/bin/bash
# SwastikAI – Simple Setup

echo "🕉️  Setting up SwastikAI..."
echo ""

# Install Python if missing
if ! command -v python &> /dev/null; then
    pkg install python -y > /dev/null 2>&1
fi

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo ">> Installing Ollama..."
    pkg install ollama -y
fi

# Create SwastikAI model
echo ">> Creating SwastikAI model..."
ollama create swastik-ai -f Modelfile

echo ""
echo "✅ SwastikAI is ready!"
echo ""
echo "Run: ./swastik"
