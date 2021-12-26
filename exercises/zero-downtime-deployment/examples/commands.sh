# Перезапуск подов приложения
kubectl -n service rollout restart deployment app

# Таким образом можно вывести все поды кластера
kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml get pods

# Применяем изменения к кластеру передавая kubectl файлы конфигурации
kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml apply -f k8s/app-deployment.yaml,k8s/app-service.yaml,k8s/env-configmap.yaml,secret.yml

# Вывести все поды кластера с подробностями
kubectl get pods -o wide

# Вывести все сервисы кластера
kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml get services

# Таким образом можно зашифровать значение hexlet в переменную the_secret
# с помощью пароля в файле vault-password
ansible-vault encrypt_string --vault-password-file vault-password 'hexlet' --name 'the_secret'

# Чтобы расшифровать зашифрованные с помощью Ansible Vault переменные
# если пароль хранится в файле, используется флаг --vault-password-file
ansible-playbook -v --vault-password-file vault-password ansible/monitoring.yml

# Устанавливаем коллекции определённые в файле requirements.yml
ansible-galaxy collection install -r ansible/requirements.yml

# Деплоим приложение
ansible-playbook -v ansible/monitoring.yml

# Подключаемся по ssh к хосту с IP 192.168.0.2
ssh username@192.168.0.2
