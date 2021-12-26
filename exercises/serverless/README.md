# Serverless

Lambda — сервис Amazon, который позволяет создавать простые бессерверные приложения. Особенности и преимущества Lambda описаны [на странице](https://aws.amazon.com/ru/lambda/) продукта.

В данном задании используется Serverless.com — фреймворк, который позволяет создавать serverless-приложения не только на Amazon, но и на других облачных провайдерах. В данном задании задеплоим на AWS Lambda бота Telegram, который возвращает сообщение, введённое пользователем. Подобная задача — это лишь пример того, что можно сделать, например среди предлагаемых функций "из коробки" Amazon Lambda предлагает обработку изображений (сжатие, создание превью).

## Ссылки

* [AWS — Lambda](https://aws.amazon.com/ru/lambda/)
* [http://serverless.com](http://serverless.com/) — фреймворк для создания serverless-приложений
* [Serverless — credentials for AWS](https://www.serverless.com/framework/docs/providers/aws/guide/credentials/)
* [Telegram](https://telegram.org/)
* [Telegram — @BotFather](https://t.me/botFather)

## Задачи

* Создайте аккаунт в AWS, если у вас его ещё нет
* Зарегистрируйтесь в Telegram, если у вас нет аккаунта
* Подготовьте окружение для работы с Serverless. Вам потребуется NodeJS 12+ версии, глобально установленная утилита

  ```sh
  npm install -g serverless
  ```

* Создайте IAM пользователя в AWS

  * Войдите в IAM https://console.aws.amazon.com/iam/home#/home
  * AWS access type —  **Programmatic access**
  * Выберите *Attach existing policies directly*, permissions - *AdministratorAccess*
  * Теги по желанию
  * Сохраните Access key ID и Secret access key, они требуются для доступа к AWS через утилиту

* Создайте бота в Telegram. Отправьте боту `@BotFather` сообщение `/newbot`, чтобы начать создание бота. После ответов на несколько вопросов бот пришлет токен, который используется для бота

* В директории *echobot* выполните установку зависимостей командой `make install`
* Для деплоя нам потребуются созданные ключи. Их можно экспортировать или использовать в команде деплоя

  ```sh
  export AWS_ACCESS_KEY_ID=<key_id>
  export AWS_SECRET_ACCESS_KEY=<access_key>
  cd echobot
  make deploy
  ```

* Если все выполнено корректно, наше приложение будет задеплоено в [AWS Lambda](https://console.aws.amazon.com/lambda/home), и оно будет отображаться в интерфейсе (в каждом регионе отображаются свои приложения). Вывод сообщит информацию о приложении, пример:

  ```sh
  Serverless: Stack update finished...
  Service Information
  service: hexlet-telegram-echo-bot
  stage: dev
  region: us-east-1
  stack: hexlet-telegram-echo-bot-dev
  resources: 11
  api keys:
    None
  endpoints:
    POST - https://ogarnze2r3.execute-api.us-east-1.amazonaws.com/dev/webhook
  functions:
    webhook: hexlet-telegram-echo-bot-dev-webhook
  layers:
    None
  ```

* Чтобы бот отправлял запросы на наш бекенд, необходимо изменить вебхук бота. Выполните команду:

  ```sh
  make set-webhook BOT_TOKEN=<token> URL=<webhook_endpoint>

* В AWS Lambda используется переменная окружения для подключения к Telegram. Необходимо указать эту переменную. Войдите в AWS Lambda, на вкладке Applications найдите приложение. На вкладке будут созданные ресурсы для этого приложения. Код исполняется с помощью *function*. Откройте ресурс *WebhookLambdaFunction* на вкладке *Configuration* откройте раздел *Environment variables* и добавьте переменную `BOT_TOKEN`

* Отправьте сообщение вашему боту. Если все сделано правильно, то он будет возвращать сообщение, которое ему отправили

  Serverless.com — это обёртка над другими сервисами. Код бота, который был сформирован и задеплоен попал на AWS. Serverless создал несколько ресурсов используя сервисы Amazon:

  * Lambda Function для выполнения кода
  * S3 Bucket для деплоя исходного кода
  * ApiGateway для получения запросов от Telegram по HTTP
  * CloudWatch для выполнения логирования

* Зайдите в AWS Lambda и измените код. Например, в *handler.js* на 13 строке заменить `text` на любую другую строку (по умолчанию бот возвращает ту строку, которую ему передали)

Когда будете отправлять задание на проверку, то укажите в issue ссылку на webhook приложения, ник бота и ссылку на директорию с домашним заданием.
