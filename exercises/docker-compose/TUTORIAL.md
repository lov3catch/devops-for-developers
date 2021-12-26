# Домашние задания по DevOps

Этот туториал раскрывает основные темы, необходимые для комфортного обучения на Хекслете:

* [Как учиться эффективно](#как-учиться-эффективно)
* [Настройка окружения](#настройка-окружения)
* [Структура домашних заданий](#структура-домашних-заданий)
* [Пример решения домашнего задания](#решаем-vagrant)
* [Как отправить на проверку](#отправляем-на-проверку)

## Как учиться эффективно

Учебные материалы на Хекслете построены таким образом, чтобы студентам не понадобилось ничего гуглить, а темы для самостоятельного изучения даются дополнительными ссылками в теории или практике. Домашние задания также основаны на предыдущих уроках, поэтому если пройденного ранее материала недостаточно для решения задачи — это наша вина. Напишите об этом в канале группы и оповестите куратора. Он передаст это в методический отдел, а мы улучшим описание задачи и расширим теорию.

### Текст домашнего задания

Текст домашнего задания всегда описывает задачу и несколько требований по её решению. Каждая практика - это закрепление пройденной темы теми подходами, которые уже знакомы студенту. В тексте домашнего задания обычно есть *основное* задание и *дополнительное*.

*Дополнительные задания* необходимы, чтобы глубже погрузиться в тему и ориентированы в первую очередь на тех, кому основное задание показалось слишком простым. Старайтесь выполнять основное задание вовремя, а к дополнительным можно возвращаться позже, когда будет время.

### Если вы не знаете что дальше делать

При решении задач нормально испытывать сложности в поиске решения, экспериментировать отлаживать. Этот чек-лист поможет лучше понять задачу:

* Изучите все файлы упражнения. Они дадут представление об архитектуре кода и способах его запуска.
* При наличии тестов, запустите их. Текст ошибки покажет, что ожидалось и что получилось.
* При наличии кода, используйте [отладочную печать](https://help.hexlet.io/ru/articles/111500-kak-nayti-oshibki-v-kode). Она поможет увидеть результаты выполнения кода по шагам.

Когда вы застряли и **в течение часа** не можете сдвинуться с места, не видите вариантов решения или не можете справиться с ошибкой, поищите в чате вопросы других студентов или создайте напишите вопрос в чат сами. Если вопросы касаются кода, прикрепляйте в тред ссылки, а не куски кода. При составлении вопроса опирайтесь на наш гайд ["Как правильно задавать вопросы"](https://help.hexlet.io/ru/articles/111495-kak-pravilno-zadavat-voprosy).

### Статьи об обучении на Хекслете

* Статья [«Как учиться и справляться с негативными мыслями»](https://guides.hexlet.io/learning)
* Статья [«Ловушки обучения»](https://ru.hexlet.io/blog/posts/traps-learning)
* Статья [«Сложные простые задачи по программированию»](https://ru.hexlet.io/blog/posts/slozhnye-prostye-zadachi-po-programmirovaniyu)
* Урок [«Как эффективно учиться на Хекслете»](https://ru.hexlet.io/courses/introduction_to_programming/lessons/hexlet-flow/theory_unit)
* Вебинар [«Как самостоятельно учиться»](https://www.youtube.com/watch?v=dCYZppVgGww)

## Домашнее задание

### Настройка окружения

Для решения домашних заданий на компьютере должно быть подготовлено рабочее окружения исходя из темы урока.
Для скачивания и отправки домашних заданий используется утилита [hexlet/cli](https://github.com/Hexlet/cli).

### Структура домашних заданий

Изучим структуру каталога *exercises* с домашним заданием *Vagrant*:

```text
vagrant
├── Makefile
├── presentation.pdf
├── README.md
└── TUTORIAL.md <-- мы здесь
```

* На верхнем уровне README содержит текст задачи. Здесь описывается что нужно сделать
* *Makefile* содержит некоторые команды запуска, которые можно добавить, а также тесты
* *presentation.pdf* - файл с презентацией, которая была на вебинаре. Иногда презентации обновляются, повторная загрузка упражнения позволит получить свежую версию.

### Решаем "Vagrant"

Для выполнения задания требуется установленный [Vagrant](https://www.vagrantup.com/).

#### Шаг 1: Запустим тесты без готового решения

Используйте Make для запуска тестов:

```sh
make test
```

Эта команда запустит проверку решения и выдаст ошибку, подобную такой:

```sh
$ make test
# Makefile:2: recipe for target 'test' failed
# make: *** [test] Error 1
```

#### Шаг 2: Пишем решение

В зависимости от домашнего задания нам может потребоваться создать определенные файлы или записать решение в виде кода.

Если необходимо написать какой-то код, то его нужно размещать между маркерами *BEGIN* и *END*. Например:


# END
up:
	vagrant up
```

Но в нашем упражнении требуется создать файл с именем _Vagrantfile_

```sh
touch Vagrantfile
# Записываем текст внутрь файла
echo "
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provision 'setup', type: 'shell', path: 'setup.sh'
end
" > Vagrantfile
```

Запустим тесты еще раз

```sh
$ make test
# Makefile:2: recipe for target 'test' failed
# make: *** [test] Error 1
```

#### Шаг 3: Изучим тесты

Содержимое команды `make test` говорит о том, что запускается проверка версии Vagrant и проверяется наличие файла *Vagrantfile*

```makefile
test:
	vagrant -v
	test -e Vagrantfile || exit
```

Поправим имя файла и запустим тесты повторно на проверку.

```sh
mv Vagrantfile Vagrantfile
make test
# vagrant -v
# Vagrant 2.2.15
# test -e Vagrantfile || exit
```

Готово, тесты пройдены! Теперь можно сдавать домашнюю работу.

### Отправляем на проверку

Используя команду *submit* из [hexlet/cli](https://github.com/Hexlet/cli), отправляем своё решение в Gitlab. Там оно пройдёт проверку автоматической системой. При её успешно завершении можно запрашивать проверку у своего наставника.

Подробнее этот процесс описан в [статье в Notion](https://www.notion.so/hexlet/780f724542b14ecb883a6ebf8ea6e54e#041a70d9e70243d3b4773fa751c3c0fa).