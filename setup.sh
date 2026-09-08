#!/bin/bash
# SwastikAI – One-Command Setup

echo "🕉️  Setting up SwastikAI..."
echo ""

# Install Python if missing
if ! command -v python &> /dev/null; then
    pkg install python -y > /dev/null 2>&1
fi

# Check if llama-cli exists
if [ ! -f ~/llama.cpp/build/bin/llama-cli ]; then
    echo ">> Building SwastikAI engine (5-10 minutes)..."
    cd ~
    git clone https://github.com/ggerganov/llama.cpp.git
    cd llama.cpp
    mkdir -p build
    cd build
    cmake -S .. -B . -DCMAKE_BUILD_TYPE=Release -DGGML_CPU=ON
    make llama-cli -j2
    echo "✅ Engine built!"
fi

# Check if model exists
if [ ! -f ~/.ollama/models/blobs/sha256-29d8c98fa6b098e200069bfb88b9508dc3e85586d20cba59f8dda9a808165104 ]; then
    echo ">> Downloading base model..."
    curl -L -o ~/qwen.gguf https://huggingface.co/Qwen/Qwen2.5-3B-Instruct-GGUF/resolve/main/qwen2.5-3b-instruct-q4_k_m.gguf
    mkdir -p ~/.ollama/models/blobs/
    mv ~/qwen.gguf ~/.ollama/models/blobs/sha256-29d8c98fa6b098e200069bfb88b9508dc3e85586d20cba59f8dda9a808165104
    echo "✅ Model downloaded!"
fi

echo ""
echo "✅ SwastikAI is ready!"
echo ""
echo "Run: ./swastik"
