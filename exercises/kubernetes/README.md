# Kubernetes

В предыдущих заданиях мы использовали наше [приложение](https://github.com/hexlet-components/devops-example-app/) с Docker Compose. Цель этого задания - перенести деплой приложения из Docker в Kubernetes с помощью [kompose](http://kompose.io/).

## Ссылки

* [Что такое Kubernetes (Официальная документация)](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)
* [Установка и настройка kubectl](https://kubernetes.io/docs/tasks/tools/)

## Задачи

* Установите на компьютер [https://kubernetes.io/docs/tasks/tools/](kubectl). Проверьте, что установлена последняя версия утилиты

  ```sh
  kubectl version --client

  Client Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.1", GitCommit:"5e58841cce77d4bc13713ad2b91fa0d961e69192", GitTreeState:"clean", BuildDate:"2021-05-12T14:18:45Z", GoVersion:"go1.16.4", Compiler:"gc", Platform:"linux/amd64"}
  ```

* Установите последнюю версию [kompose](https://github.com/kubernetes/kompose/releases)

  ```sh
  kompose version

  1.21.0 (992df58d8)
  ```

* Создайте *docker-compose.yml*. Создайте сервис `app` со следующими значениями:
  * Образ - `hexletcomponents/devops-example-app`
  * restart - `always`
  * Переменные окружения `SERVER_MESSAGE`, `ROLLBAR_TOKEN` берутся [из окружения](https://docs.docker.com/compose/environment-variables/#set-environment-variables-in-containers). Мы будем использовать секреты Kubernetes
  * Внешний порт - 80, внутренний 5000
  * env_file - `.env`

* Создайте *.env* файл, запишите в него следующие переменные окружения

  ```env
  SERVER_MESSAGE="Hello from Kubernetes"
  ```

* Сгенерируйте конфигурационные файлы для Kubernetes командой

  ```sh
  kompose convert

  INFO Kubernetes file "app-service.yaml" created
  INFO Kubernetes file "app-deployment.yaml" created
  INFO Kubernetes file "env-configmap.yaml" created
  ```

* Создайте файл *secret.yaml*. Этот файл может содержать в себе секретные данные, например логины, пароли, токены. Добавьте его в *.gitignore*. Значения добавлются закодированными в base64. Значение можно закодировать с помощью утилиты или через [сервис](https://www.base64encode.org/)

  ```shell
  echo "rollbar_token" | base64
  cm9sbGJhcl90b2tlbgo=
  ```

  ```yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: app-secret
  data:
    ROLLBAR_TOKEN: <ваш_токен>
  ```

* Измените сгенерированный *app-deployment.yaml*. Для переменной окружения `ROLLBAR_TOKEN` добавьте в настройки, чтобы переменная бралась из секретов

  ```yaml
  ...
  valueFrom:
    secretKeyRef:
      key: ROLLBAR_TOKEN
      name: app-secret
  ...
  ```

  При изменении секретов необходимо перезапустить поды приложения

  ```shell
  kubectl -n service rollout restart deployment app
  ```

* В *app-deployment.yaml* установите количество реплик - 2.

* *app-service.yaml* - добавьте в `spec` тип балансера

  ```yaml
  apiVersion: v1
  kind: Service
  ...
  spec:
    type: LoadBalancer
    ports:
  ...
  ```

* Зайдите на Digital Ocean и создайте Kubernetes кластер. Выберите самый дешёвый план и 1 ноду. Скачайте конфигурационный файл от кластера. Чтобы управлять кластером, необходимо использовать `kubectl` и передавать путь до конфига от кластера.

  ```sh
  # kubectl --kubeconfig /path/to/config COMMAND
  kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml get pods
  ```

* Примените изменения к кластеру

  ```sh
  kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml apply -f app-deployment.yaml,app-service.yaml,env-configmap.yaml,secret.yml
  ```

  После применения изменений Digital Ocean начнет создание Балансера для того, чтобы приложение внутри Kubernetes было доступно внутри. Команда `kubectl get pods -o wide` позволяет получить информацию

  ```sh
  NAME                   READY   STATUS    RESTARTS   AGE    IP             NODE                        NOMINATED NODE   READINESS GATES
  app-66899795fc-b87vk   1/1     Running   0          174m   10.244.0.188   hexlet-k8s-homework-8gc81   <none>           <none>
  app-66899795fc-k6hsl   1/1     Running   0          174m   10.244.0.214   hexlet-k8s-homework-8gc81   <none>           <none>
  ```

  Сервис получит IP адрес балансера, который будет доступен во внешней сети. По этому IP Адресу приложение будет доступно снаружи.

  ```sh
  kubectl --kubeconfig ~/hexlet-k8s-homework-kubeconfig.yaml get services

  NAME         TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)        AGE
  app          LoadBalancer   10.245.251.2   188.166.200.229   80:31086/TCP   177m
  kubernetes   ClusterIP      10.245.0.1     <none>            443/TCP        3h5m
  ```

* Проверьте работоспособность приложения. Откройте страницу *http://<адрес>/error* и проверьте отправку логов в Rollbar

* В файле *solution* добавьте ссылку на задеплоенное приложение: http://<адрес>
