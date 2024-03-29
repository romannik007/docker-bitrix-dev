Выполнять в следующей последовательности:

Все настройки окружения произведены со страницы *https://dev.1c-bitrix.ru/learning/course/index.php?COURSE_ID=32&CHAPTER_ID=05360&LESSON_PATH=3903.4862.20866.5360*

Файлы конфигурации взяты отсюда *https://dev.1c-bitrix.ru/docs/chm_files/redhat8.zip* (можно взять отсюда https://dev.1c-bitrix.ru/docs/chm_files/debian.zip)

Перед запуском выполним:

- `cp .env.example .env` Это необходимо для внесения изменений в переменные, такие, как версия php, mysql и тп (не обязятельная процедура, так как все переменные определены в compose файлах).
- можно сгенерировать свои сертификаты с помощью файла services/web/nginx/proxy/gen_ssl.sh (дефолтые сертификаты в репозитории уже имеются)


Проект поддерживает весрии php 7.3 - 8.1, для этого в файле .env изменяем перменную PHP_VER и выполняем 

   `docker-compose up -d --build`

- phpmyadmin доступен на 33333 порту

- также можно сменить версию mysql в файле .env, после этого выполнить

   `docker-compose up -d --build mysql`

Переход на версию mysql желательно осуществлять через бэкап-восстановление

1. **Чтобы** был доступ на редактирование файлов в проекте и на хосте и в контейнере:
   
   выполним на своей системе 
   
   *`id -u`* - USER_ID
   
   *`id -g`* - USER_GID
   

   свой результат вставим в переменную в файл .env
            
   
   **При ошибке установки пакетов необходимо выполнить**
   https://sylabs.io/guides/3.8/admin-guide/user_namespace.html#user-namespace-requirements

Debian   

```bash
sudo sh -c 'echo kernel.unprivileged_userns_clone=1 \
    >/etc/sysctl.d/90-unprivileged_userns.conf'
sudo sysctl -p /etc/sysctl.d /etc/sysctl.d/90-unprivileged_userns.conf
```

   RHEL/CentOS 7

From 7.4, kernel support is included but must be enabled with:


```bash
sudo sh -c 'echo user.max_user_namespaces=15000 \
    >/etc/sysctl.d/90-max_net_namespaces.conf'
sudo sysctl -p /etc/sysctl.d /etc/sysctl.d/90-max_net_namespaces.conf
```




2. размещаем в user/ папку .ssh для использования ssh ключей. Ключи пробрасываются пользователю www-data в домашнюю папку /var/www
3. deleted

4. ***`docker-compose up -d --build`***

      
5. Вэб доступен по http://IP:BITRIX_PORT или https://IP:BITRIX_SSL_PORT
   
   

6. в файле .settings.php в проекте прописываем данные для соединения с БД и вставляем ключ:

      ***'signature_key' => 'bVQdNsrRsulOnj9lkI0sPim292jMtrnji0zzEl5MzCBeHT7w1E5HL3aihFb6aiFJfNEIDxmcFrowS3PTLZFDxAfuNNuCN5EcFRaveaUaRZHSThtWKV7Vp5vGbz9kb3cN'***

      ***'path_to_publish' => 'http://web:8895/bitrix/pub/'***

      пример .settings.php в папке services/bitrix-set/
      
      **или кидаем services/bitrix-set/.settings_extra.php в www/bitrix**

      **Если push&pull не работает, необходимо пересохранить настройки в модуле push&pull выбрав 2 пункт  и потом 4-й**
      **для прохождения теста с сокетами в /etc/hosts прописать**

      **`<IP сетевой карты> <домен>`**

      **либо использовать сайт по внешнему адресу сетевой карты**

     **далее заходить по домену**



**Дополнительно**:
- в файле .env содержатся данные для подключения к mysql,
  логин и пароль пользователя bitrix из env используем только при чистой установке битрикс.

  REDIS_SOCK можно не менять, он работает по сети
- в папках **services/web/httpd, services/web/nginx, services/web/php** содержатся файлы для кастомных настроек
- services/bitrix-set
- логи nginx, php, push/pull в папке **services/<сервис>/logs**, логи apache смотрим `docker compose logs -t web`
- адрес сервера БД - **mysql** (указываем для подключения)

- ***`docker exec -ti <сервис> /bin/bash`*** - подключиться к контенеру в баш )
- 
Setting boundaries for WSL2
We need to set some reasonable resource constraints on what WSL2 can actually use. Fortunately, that’s as simple as going to c:\users\*your your profile name* and creating a .wslconfig file. On my setup, a MSI Prestige 15 with a 10710u 6-core processor and 16GB of RAM, mine looks like this:

```
[wsl2]
memory=4GB # Limits VM memory in WSL 2 to 4 GB
processors=5 # Makes the WSL 2 VM use two virtual processors
```

