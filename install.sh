./scripts/install_dev_env.sh
./scripts/create_kind_cluster.sh
./build.sh
helm install trainer services/trainer/helm-chart
helm install inference services/inference/helm-chart
helm install monitor services/monitor/helm-chart
kubectl get pods
kubectl get svc

kubectl port-forward svc/trainer 8081:80 &
kubectl port-forward svc/inference 8082:80 &
kubectl port-forward svc/monitor 8083:80 &

./scripts/test_apis.sh
