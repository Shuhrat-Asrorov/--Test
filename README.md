# Test МТС/ФПМИ

## GO - Profile CLI (mk)

Простая утилита командной строки для управления профилями (пользователь + проект).  
Профили хранятся в текущей папке в виде YAML‑файлов.

Требования:

- Go 1.16 или выше
- Зависимость: `gopkg.in/yaml.v3` (автоматически подтягивается при сборке)

Сборка и запуск:

1. Клонируйте репозиторий:

```bash
    git clone <url-вашего-репозитория>
    cd profile-cli
```

2. Подтяните зависимости:

```bash
    go mod tidy
```

3. Соберите исполняемый файл:

```bash
    go build -o mk
```

Теперь в папке появится бинарный файл mk (или mk.exe на Windows).

4. Использование:

profile create – создать новый профиль

```bash
    ./mk profile create --name <имя> --user <пользователь> --project <проект>
```

--name – имя профиля (обязательно)
--user – имя пользователя (обязательно)
--project – название проекта (обязательно)

profile get – просмотреть профиль

```bash
    ./mk profile get --name <имя>
```

profile list – показать все существующие профили

```bash
    ./mk profile list
```

profile delete – удалить профиль

```bash
    ./mk profile delete --name <имя>
```

help – справка

```bash
    ./mk help
```

## Kotlin Foo Bar Starter

Автоконфигурация Spring Boot, добавляющая HTTP-заголовок `Foo: Bar` во все ответы.

## Требования

- Java 17 или выше (рекомендуется использование Java 23)
- Gradle (обёртка уже в проекте)

Сборка и запуск:

1. Клонируйте репозиторий:

```bash
    git clone <url>
    cd kotlin-foo-bar-starter
```

2. Соберите проект:

```bash
    ./gradlew clean build
```

3. Запустите приложение:

```bash
    ./gradlew bootRun
```

4. Использование:
   После запуска откройте новый терминал и выполните

```bash
    curl -v http://localhost:8080/test
```

В ответе вы должны увидеть заголовок:
< Foo: Bar

Это означает, что автоконфигурация работает.

# DevOps – Автоматизация развёртывания K3s и Chaos-эксперименты с Istio

Автоматизация (Ansible) развёртывания однонодового Kubernetes-кластера (K3s), установки Istio, Harbor и тестового приложения, а также сценарии Chaos-экспериментов с использованием Istio (задержки и ошибки HTTP 500).

## Требования

- **Управляющая машина:** установлен Ansible (2.9+), SSH-клиент.
- **Целевая ВМ:** Ubuntu 22.04 LTS (amd64), доступ по SSH с пользователем в группе `sudoers`.
- Для локального запуска на macOS можно использовать **Multipass**:

```bash
    brew install multipass
    multipass launch -n k3s-vm --memory 4G --disk 10G --cpus 2 22.04
    multipass info k3s-vm   # запомните IPv4
    multipass transfer ~/.ssh/id_rsa.pub k3s-vm:/home/ubuntu/.ssh/authorized_keys
```

Сборка и запуск:

1. Заполните inventory.ini реальными данными вашей ВМ:

```ini
    [k3s-cluster]
    <IP-вашей-ВМ> ansible_user=ubuntu ansible_ssh_private_key_file=/путь/к/вашему/ключу
```

2. Проверьте доступность:

```bash
    ansible -i inventory.ini k3s-cluster -m ping
```

Должен вернуться pong.

Запуск автоматизации
Одной командой установите K3s, Helm, Istio, Harbor и тестовое приложение:

```bash
    ansible-playbook -i inventory.ini ansible/playbook.yml
```

Плейбук выполнит все шаги (установка зависимостей, K3s, настройка kubectl, установка Istio и Harbor). Процесс займёт 5–7 минут.
