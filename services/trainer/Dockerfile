# Simple Dockerfile for trainer microservice

FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt

COPY mnist_model.py /app
COPY app.py /app

EXPOSE 80

CMD ["python", "app.py"]
