# Перезапуск подов приложения
kubectl -n service rollout restart deployment app

# Таким образом можно вывести все поды кластера
kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml get pods

# Применяем изменения к кластеру передавая kubectl файлы конфигурации
kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml apply -f app-deployment.yaml,app-service.yaml,env-configmap.yaml,secret.yml

# Вывести все поды кластера с подробностями
kubectl get pods -o wide

# Вывести все сервисы кластера
kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml get services