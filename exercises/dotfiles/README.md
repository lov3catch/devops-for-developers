# Dotfiles

В этом задании мы добавим плагины в командную оболочку [zsh](https://www.zsh.org/), автодополнение для asdf и красивый вывод логов для команды `git log`.

## Ссылки

* [Что такое Makefile](https://guides.hexlet.io/makefile-as-task-runner/)
* [dotfiles]( https://github.com/mokevnin/dotfiles)
* [ansible/ansible-runner](https://github.com/ansible/ansible-runner)
* [asdf](https://guides.hexlet.io/version_managers/#%D1%83%D0%BD%D0%B8%D0%B2%D0%B5%D1%80%D1%81%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9-%D0%BC%D0%B5%D0%BD%D0%B5%D0%B4%D0%B6%D0%B5%D1%80)
* [ohmyz.sh](https://ohmyz.sh/)
* [ansible.builtin.lineinfile](https://docs.ansible.com/ansible/2.4/lineinfile_module.html) — модуль с помощью которого можно дописать строку в файл
* [ansible.builtin.blockinfile](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/blockinfile_module.html) — модуль с помощью которого можно блок текста в файл

## Задачи

Настройте личные dotfiles с установкой zsh, включением плагинов для git и docker (с помощью o-my-zsh), а также добавлением asdf. Изменение файлов конфигурации должно происходить через Ansible, который запускается в докере.

* Установите make, zsh, git, asdf и o-my-zsh
* Ansible: Добавьте подгрузку [asdf и asdf completions](https://asdf-vm.com/#/core-manage-asdf?id=add-to-your-shell) в *.zshrc*
* Ansible: Активируйте в *.zshrc* [плагины](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) для git и docker
* Ansible: Добавьте в *.gitconfig* красивый вывод для `git log`:

    ```sh
    [pretty]
        my = format:%C(yellow)%h%C(reset) | %C(dim green)%cd%C(reset) | %C(green)%cr%C(reset) | %C(cyan)%s%C(red)%d%C(red)%C(reset) %C(blue)[%an]%C(reset)
    [format]
        pretty = my
    ```

В итоге у вас должен быть *Makefile* с командами для установки zsh, o-my-zsh, git и asdf. И командой запуска Ansible, который изменяет файлы конфигурации в соответствии с заданием.

## Подсказки

* [Команда запуска Ansible](https://github.com/mokevnin/dotfiles/blob/5f49da4921bb70a4e806dcf12cdc9f12d6eae5bd/Makefile#L14), с её помощью можно запустить Ansible в контейнере
