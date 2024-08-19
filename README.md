
# RedmineProjectManager + Docker

## Настройка переменных окружения и запуск проекта

1. Создайте файл `.env` в корневой директории проекта (если отсутствует).

2. Вставьте в `.env` файл один пароль для двух переменных, начиная с латинского символа:
   ```bash
   REDMINE_DB_PASSWORD=your_password_here
   POSTGRES_PASSWORD=your_password_here
   ```

3. Соберите Docker-образ:
   ```bash
   docker-compose build
   ```

4. Запустите контейнеры:
   ```bash
   docker-compose up -d
   ```

5. Сгенерируйте `SECRET_KEY_BASE` для приложения:
   ```bash
   docker-compose run redmine bundle exec rake secret
   ```

6. Скопируйте сгенерированный `SECRET_KEY_BASE` и вставьте его в файл `.env`:
   ```bash
   SECRET_KEY_BASE=your_generated_secret_key
   ```

   Образец записи значений в `.env` файлеtwo:
   ```bash
   SECRET_KEY_BASE=a00cae6be448b29e7799b08979bca616c376b57c3531ae347ff7bbf1168f72f02c0537e7491f40567adf57c2215053fb56e118c2bd20378a891ee11ee48c66aa
   REDMINE_DB_PASSWORD=Z555kkdddeeeerr
   POSTGRES_PASSWORD=Z555kkdddeeeerr
   ```

7. Перезапустите контейнеры для применения изменений:
   ```bash
   docker-compose down
   docker-compose up -d
   ```


8. Откройте браузер для использования локально и введите адрес:
   ```bash
   http://127.0.0.1:3000/
   ```

   
9. Подробная инструкция к плагину (без докера) :
   ```bash
   https://github.com/SKOLIA0/redmine_project_manager/blob/main/README.md
   ```
