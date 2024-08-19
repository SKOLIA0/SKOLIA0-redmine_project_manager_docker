FROM redmine:5.1

# Устанавливаем необходимые инструменты для выполнения ожидания базы данных
RUN apt-get update && apt-get install -y netcat-openbsd

# Устанавливаем рабочую директорию как Redmine
WORKDIR /usr/src/redmine

# Копируем скрипт ожидания базы данных
COPY wait-for-db.sh /usr/src/redmine/wait-for-db.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/src/redmine/wait-for-db.sh

# Копируем плагин из локальной директории в папку plugins
COPY ./plugins/redmine_project_manager /usr/src/redmine/plugins/redmine_project_manager

# Выполняем миграции основной базы данных, а затем плагинов, создаем database.yml на этапе выполнения, затем запускаем сервер
CMD ./wait-for-db.sh && \
    echo "production:" > config/database.yml && \
    echo "  adapter: postgresql" >> config/database.yml && \
    echo "  database: redmine" >> config/database.yml && \
    echo "  host: db" >> config/database.yml && \
    echo "  username: redmine" >> config/database.yml && \
    echo "  password: ${REDMINE_DB_PASSWORD}" >> config/database.yml && \
    echo "  encoding: utf8" >> config/database.yml && \
    echo "" >> config/database.yml && \
    echo "development:" >> config/database.yml && \
    echo "  adapter: postgresql" >> config/database.yml && \
    echo "  database: redmine_dev" >> config/database.yml && \
    echo "  host: db" >> config/database.yml && \
    echo "  username: redmine" >> config/database.yml && \
    echo "  password: ${REDMINE_DB_PASSWORD}" >> config/database.yml && \
    echo "  encoding: utf8" >> config/database.yml && \
    echo "" >> config/database.yml && \
    echo "test:" >> config/database.yml && \
    echo "  adapter: postgresql" >> config/database.yml && \
    echo "  database: redmine_test" >> config/database.yml && \
    echo "  host: db" >> config/database.yml && \
    echo "  username: redmine" >> config/database.yml && \
    echo "  password: ${REDMINE_DB_PASSWORD}" >> config/database.yml && \
    echo "  encoding: utf8" >> config/database.yml && \
    bundle exec rake db:migrate RAILS_ENV=production && \
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production && \
    rails server -b 0.0.0.0
