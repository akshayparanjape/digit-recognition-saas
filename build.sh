# Trainer
docker build -t trainer:latest services/trainer/.
kind load docker-image trainer:latest --name mnist-cluster

# Inference
docker build -t inference:latest services/inference/.
kind load docker-image inference:latest --name mnist-cluster

# Monitor
docker build -t monitor:latest services/monitor/.
kind load docker-image monitor:latest --name mnist-cluster
