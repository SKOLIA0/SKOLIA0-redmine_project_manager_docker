# Плагин "RedmineProjectManager"

## Версия: 1.0.0
**Автор:** Николай Слепченко  
**Описание:** Этот плагин позволяет назначать менеджеров проекта из определенной группы пользователей (`GROUP_PROJECT_MANAGERS`) в Redmine.

---

## Возможности

- **Назначение менеджера проекта**  
  Позволяет назначать менеджера проекта из группы пользователей (`GROUP_PROJECT_MANAGERS`).

- **Управление ролью менеджера проекта**  
  Автоматически присваивает роль `ProjectManager` выбранному менеджеру и понижает предыдущего менеджера до роли `Member`.

- **Проверка на наличие менеджера проекта**  
  Проверяет, чтобы у каждого проекта был назначен менеджер.

- **Управление разрешениями**  
  Добавляет специальное разрешение для контроля того, кто может назначать или изменять менеджера проекта.

- **Поддержка локализации**  
  Плагин поддерживает несколько языков, включая английский и русский.

---

## Настройка перед установкой

Перед установкой плагина выполните следующие действия:

1. **Создайте группу пользователей**

    - Перейдите в **Администрирование** > **Группы** и создайте новую группу с именем `GROUP_PROJECT_MANAGERS`.
    - Добавьте менеджеров проекта в эту группу.

2. **Создайте роли**

   Перейдите в **Администрирование** > **Роли и разрешения**.
   Необходимо создать и настроить следующие роли **строго в этом порядке**:
   
   
   1. Создайте роль `Member`.
        - **Member**: Эта роль назначается пользователям, которые участвуют в проекте, но не являются менеджерами.
        - Убедитесь, что роль `Member` существует в разделе **Администрирование** > **Роли и разрешения**.
        - Предыдущий менеджер будет автоматически понижен до этой роли при изменении менеджера проекта.
   
   
   2. Создайте роль `ProjectManager`.
       - **ProjectManager**: Эта роль будет автоматически назначена пользователю, выбранному в качестве менеджера проекта.
       - **Строго** Управление участниками > Все роли > Только эти роли: > Member
       - **Строго** С текущими условиями нельзя давать права на создание проектов (новый проект создает Администратор Redmine)
       
       


   3. Создайте роль `ConsultingDirector`.
       - В разделе **Разрешения** включите разрешение `Назначение менеджера проекта` для этой роли.(если плагин уже установлен)
       - **Строго** Управление участниками > Все роли > Только эти роли: > Member
       - **Строго** С текущими условиями нельзя давать права на создание проектов (новый проект создает Администратор Redmine)
       - Назначьте эту роль пользователям, которые ,elen назначать или изменять менеджера проекта.


---

## Установка

### Требования

- Версия Redmine 5.x (протестированно на версиях 5.0.0 и 5.1.3)
- PostgreSQL 13

### Шаги

1. **Клонируйте репозиторий в папку с плагинами Redmine**:

    ```bash
    cd redmine/plugins
    git clone https://github.com/SKOLIA0/redmine_project_manager
    ```

2. **Запустите миграции**:

    ```bash
    bundle exec rake redmine:plugins:migrate rails_env=production
    ```

3. **Перезапустите Redmine**(может меняеться в зависимости от настроек окружения):

    ```bash
    sudo systemctl restart redmine
    ```

4. **Проверьте установку**:

   Перейдите в панель **Администрирования** в Redmine и откройте раздел **Плагины**, чтобы убедиться, что "Redmine Project Manager plugin" установлен.

---

## Конфигурация

### 1. **Назначение роли менеджера проекта**

Чтобы настроить плагин для управления менеджерами проектов:

- Создайте группу пользователей с именем `GROUP_PROJECT_MANAGERS` в панели администрирования.
- Добавьте пользователей в эту группу, чтобы они могли быть выбраны в качестве менеджеров проектов.


### 2. **Настройка разрешений**

Чтобы настроить, кто может назначать менеджеров проектов:

- Перейдите в **Администрирование** > **Роли и разрешения**.
- Включите разрешение `Назначение менеджера проекта` для роли `ConsultingDirector`.
- В форме редактирования проекта появится выпадающий список для выбора менеджера проекта, работает для пользвателя в роли `ConsultingDirector`.

---

## Использование

### 1. **Назначение менеджера проекта**

- При создании или редактировании проекта вы увидите выпадающее поле с названием `Менеджер проекта`. В этом поле будут отображаться только пользователи из группы `GROUP_PROJECT_MANAGERS`.
- Выберите менеджера и сохраните проект.
- Если менеджер проекта изменяется, предыдущий менеджер будет автоматически понижен до роли `Member`.
- Если группы `GROUP_PROJECT_MANAGERS` не существует, то плагин будет не функционален(отключено поле менеджер проекта и требование к его наличию). 

### 2. **Автоматическое назначение роли**

- После сохранения проекта выбранному менеджеру проекта будет автоматически назначена роль `ProjectManager`.
- Предыдущий менеджер (если он был) будет автоматически переведен на роль `Member`.

---

## Тестирование

Чтобы запустить тесты для плагина:

1. Перейдите в корневую директорию установки Redmine.
2. Выполните следующую команду для запуска юнит-тестов плагина:

    ```bash
   bundle exec rake redmine:plugins:migrate rails_env=test
    ```
    ```bash
    bundle exec rake redmine:plugins:test name=redmine_project_manager rails_env=test
    ```

---

## Локализация

Плагин поддерживает английский и русский языки. Чтобы добавить другие языки, добавьте файлы перевода, в папку `config/locales/`.

- Файл для английского: `config/locales/en.yml`
- Файл для русского: `config/locales/ru.yml`

---

## Вклад

Вы можете внести вклад в этот плагин, отправив пулреквесты или сообщив о проблемах в репозитории GitHub.

---

## Лицензия

Этот плагин распространяется под лицензией GNU General Public License v2.
