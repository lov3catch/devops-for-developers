# 12 факторов

Методология двенадцати факторов может быть применена для приложений, написанных на любом языке программирования и использующих любые комбинации сторонних служб (backing services) (базы данных, очереди сообщений, кэш-памяти, и т.д.).

Если разработчики придерживаются принципами 12 факторов, то разрабатываемые приложения проще разворачивать, масштабировать и мониторить.

В этом задании необходимо будет научиться запускать приложение на разных окружения. В качестве приложения будет использоваться
[strapi](https://github.com/strapi/strapi). В качестве продакшен-окружения - [Heroku](https://heroku.com/). Само приложение будет конфигурироваться переменными окружения в соответствии с методологией 12 факторов.

## Ссылки

* [The Twelve-Factor App](https://12factor.net/)
* [Strapi](https://github.com/strapi/strapi)
* [Quick Start Guide](https://strapi.io/documentation/developer-docs/latest/getting-started/quick-start.html)
* [Getting Started on Heroku with Node.js](https://devcenter.heroku.com/articles/getting-started-with-nodejs)
* [Конфигурация Strapi](https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html)
* [Deployment Strapi app to Heroku](https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/deployment/hosting-guides/heroku.html)

## Задачи

* Создайте в директории *app* приложение Strapi согласно [документации](https://strapi.io/documentation/developer-docs/latest/getting-started/quick-start.html#_1-install-strapi-and-create-a-new-project)
* Установите [Heroku Cli](https://devcenter.heroku.com/articles/heroku-cli)
* Задеплойте приложение с помощью heroku cli. Убедитесь, что приложение конфигурируется с помощью переменных окружения
* Когда будете отправлять задание на проверку, то укажите в issue ссылку на задеплоенное приложение
