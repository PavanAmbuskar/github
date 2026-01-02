FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system deps (if needed later)
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy & install dependencies FIRST (best practice)
COPY requirements.txt .
RUN python -m pip install --upgrade pip \
 && python -m pip install --no-cache-dir -r requirements.txt

# Copy application
COPY app.py .

EXPOSE 8000

CMD ["gunicorn", "--bind=0.0.0.0:8000", "app:app"]
