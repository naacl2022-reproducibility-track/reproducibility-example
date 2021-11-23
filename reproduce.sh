python src/summarize.py \
  --model-dir /app/bart.large.cnn \
  --model-file model.pt \
  --src data/documents.txt \
  --out data/predictions.txt

python src/evaluate.py \
  --reference-file data/references.txt \
  --prediction-file data/predictions.txt
