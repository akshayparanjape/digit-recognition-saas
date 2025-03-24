# Kubernetes-based SaaS with MNIST Microservices

This repository demonstrates three Kubernetes microservices deployed using Helm on a local Kind cluster:

1. **Trainer**: Trains an MNIST digit classifier using TensorFlow, saving the trained model to a Persistent Volume.
2. **Inference**: Hosts the model (loaded from the shared volume) and provides a REST API for digit classification.
3. **Monitor**: Monitors the predictions and suggests if re-training is needed (based on a simple threshold).

## Prerequisites

- Git
- Docker (tested with 20+)
- [Kind](https://kind.sigs.k8s.io/) (optional if you use the provided scripts)
- Kubectl
- [Helm](https://helm.sh)
- Bash shell (for running the scripts)
- Python 3.8+ (only if you want to run local client scripts; the containers embed Python for the services)

## Usage

1. **Install Developer Environment Tools (optional)**:
   ```bash
   cd k8s-microservices-mnist
   ./scripts/install_dev_env.sh
