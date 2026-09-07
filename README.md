## 🧠 Official Trained Model

The official, fine-tuned SwastikAI model is now available on Hugging Face:

👉 **[https://huggingface.co/akshatpopat/SwastikAI](https://huggingface.co/akshatpopat/SwastikAI)**

### Download and Use (Python)
```python
from transformers import AutoModelForCausalLM, AutoTokenizer

model = AutoModelForCausalLM.from_pretrained("akshatpopat/SwastikAI")
tokenizer = AutoTokenizer.from_pretrained("akshatpopat/SwastikAI")

inputs = tokenizer("Who are you?", return_tensors="pt")
outputs = model.generate(**inputs)
print(tokenizer.decode(outputs[0]))
