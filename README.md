# Тестовое задание:
разработать API для веб-формы параметризованного поиска штрафов по владельцу и госномеру по базе ("информация о штрафах": госномер, марка автомобиля, модель автомобиля, владелец, тип начисленного штрафа). Одному владельцу может принадлежать несколько автомобилей. Справочник типов штрафов и пошлины по его оплате размещается в отдельной таблице-справочнике. В качестве БД для хранения данных можно использовать любую БД, при этом, для создания базы и справочника, и заполнения их данными нужно использовать встроенные средства фреймворка Ruby on Rails. Необходимо снабдить результат инструкцией по развертыванию и настройке, а так же коллекцией запросов для Postman с примерами использования разработанного API.


## Итоговый результат:
Разработан сервис, отвечающий указанным требованиям. Было реализовано:
- API для полнотекстового поиска по записям в БД (поиск по точному вводимому слову, либо по его части, т.е. при неполном вводе слова).
Поиск является регистронезависимым - поиск по фамилии "Ким" и "ким" даст одинаковый результат
- Нарушения выводятся по 10 на страницу (номер запрашиваемой страницы необходимо передавать в параметре page)
- Разработан модуль для генерации случайных данных (см. примечание ниже).

### Особенности реализации и системные требования:
ruby - 2.7.1<br />
Rails - версия >= 6.0.2.1, но < 6.1<br />
БД - PostgreSQL<br />
Пагинация - гем 'kaminari'<br />
Генерация данных:
  - гем 'realistic-russian-names' (для генерации случайных ФИО граждан)
  - собственные методы для генерации прочих данных.

__Основные сущности:__
- Ticket - нарушение (штраф)
- TicketType - тип нарушения
- Citizen - гражданин
- Car - автомобиль, ТС (транспортное средство). Формат гос.номера: р125ах-77(7).

Поля в таблицах БД - см. файл [db/schema.rb](https://github.com/semensid2020/ruby_api_2020/blob/develop/db/schema.rb)

### Установка необходимых пакетов и утилит:
<pre>
rvm install 2.7.1 && rvm use 2.7.1                   - обновляем информацию о доступных пакетах
sudo apt-get -y install bundler                      - установка менеджера управления гемами Bundler
sudo apt -y install postgresql postgresql-contrib    - установка PostgreSQL
sudo systemctl start postgresql.service              - удостоверимся, что Postgres запущен
</pre>

### Настройка PG:
<pre>
sudo -i -u postgres                                       - переключаемся на учетную запись postgres
  psql                                                    - получаем доступ к командной строке Postgres
    CREATE ROLE api2020 WITH LOGIN PASSWORD 'api2020';    - создаём юзера api2020
    ALTER USER api2020 CREATEDB;                          - предоставляем юзеру api2020 право на создание БД
  exit                                                    - выход из командной строки Postgres
exit                                                      - переключаемся обратно на текущего пользователя
</pre>

### Развертывание приложения:
Для скачивания на компьютер необходимо выполнить команду:<br />
git clone https://github.com/semensid2020/ruby_api_2020.git <br />

Далее выполняем команды:<br />
<pre>
cd ruby_api_2020
bundle install
yarn install --check-files
rails db:create         - создание БД
rails db:migrate        - изменение структуры БД (создание таблиц)
rails db:seed           - заполнение таблиц данными
puma                    - запуск приложения
</pre>

__Опционально:__<br />
<pre>
mkdir tmp && mkdir tmp/pids	  (возможно потребуется создать данные папки в папке приложения)
</pre>

### Тестирование API из браузера:
В браузере параметры запроса можно передавать с помощью адресной строки.<br />
Например:<br />
<pre>
http://localhost:7777/tickets                             - вывод первой страницы выдачи данных о штрафах
http://localhost:7777/tickets?page=3                      - вывод третьей страницы выдачи данных о штрафах
http://localhost:7777/tickets?car_number=2                - поиск по штрафам с учетом госномера авто (включающего цифру 2)
http://localhost:7777/tickets?surname=ким&first_name=а    - поиск по штрафам с ФИО гражданина (фамилия содержит строку 'ким', имя содержит букву 'а')
</pre>

При тестировании можно сверяться с содержимым соответствующих таблиц в БД,<br />
либо с содержимым файла [db/seeds.rb](https://github.com/semensid2020/ruby_api_2020/blob/develop/db/seeds.rb), в котором генерируемые данные прописаны в явном виде (хардкод).<br />


### Тестирование API с помощью утилиты curl (выполняется в терминале):
Аналогично запросы можно выполнять с помощью командной строки (терминала) - используя curl:<br />
curl -X GET "http://localhost:7777/tickets?page=3"

Результат:
<pre><font color="#009917"><b>➜  </b></font><font color="#2AA198"><b>ruby_api_2020</b></font> <font color="#337CAF"><b>git:(</b></font><font color="#DC322F"><b>develop</b></font><font color="#337CAF"><b>) </b></font><font color="#6DB500"><b>✗</b></font> curl -X GET &quot;http://localhost:7777/tickets?page=3&quot;
[{&quot;ticket&quot;:{&quot;id&quot;:21,&quot;ticket_number&quot;:&quot;20200616999888&quot;,&quot;ticket_date&quot;:&quot;2020-06-16&quot;,&quot;ticket_name&quot;:&quot;Нелегальная перевозка пассажиров&quot;,&quot;penalty&quot;:5000},&quot;car&quot;:{&quot;car_number&quot;:&quot;а358хо-70&quot;,&quot;car_company&quot;:&quot;Лада&quot;,&quot;car_model&quot;:&quot;Гранта&quot;},&quot;citizen&quot;:{&quot;passport&quot;:&quot;1234567890&quot;,&quot;sex&quot;:&quot;муж&quot;,&quot;surname&quot;:&quot;Иванов&quot;,&quot;first_name&quot;:&quot;Иван&quot;,&quot;second_name&quot;:&quot;Иванович&quot;,&quot;birth_date&quot;:&quot;1978-05-17&quot;}},{&quot;ticket&quot;:{&quot;id&quot;:22,&quot;ticket_number&quot;:&quot;20200701777666&quot;,&quot;ticket_date&quot;:&quot;2020-07-01&quot;,&quot;ticket_name&quot;:&quot;Передача ТС лицу без документов&quot;,&quot;penalty&quot;:3000},&quot;car&quot;:{&quot;car_number&quot;:&quot;н100рм-70&quot;,&quot;car_company&quot;:&quot;Toyota&quot;,&quot;car_model&quot;:&quot;Caldina&quot;},&quot;citizen&quot;:{&quot;passport&quot;:&quot;1234567890&quot;,&quot;sex&quot;:&quot;муж&quot;,&quot;surname&quot;:&quot;Иванов&quot;,&quot;first_name&quot;:&quot;Иван&quot;,&quot;second_name&quot;:&quot;Иванович&quot;,&quot;birth_date&quot;:&quot;1978-05-17&quot;}},{&quot;ticket&quot;:{&quot;id&quot;:23,&quot;ticket_number&quot;:&quot;20200814555444&quot;,&quot;ticket_date&quot;:&quot;2020-08-14&quot;,&quot;ticket_name&quot;:&quot;Нарушение требований к перевозке детей&quot;,&quot;penalty&quot;:3000},&quot;car&quot;:{&quot;car_number&quot;:&quot;н100рм-70&quot;,&quot;car_company&quot;:&quot;Toyota&quot;,&quot;car_model&quot;:&quot;Caldina&quot;},&quot;citizen&quot;:{&quot;passport&quot;:&quot;1234567890&quot;,&quot;sex&quot;:&quot;муж&quot;,&quot;surname&quot;:&quot;Иванов&quot;,&quot;first_name&quot;:&quot;Иван&quot;,&quot;second_name&quot;:&quot;Иванович&quot;,&quot;birth_date&quot;:&quot;1978-05-17&quot;}}]<span style="background-color:#31A9AC"><font color="#252D2D"><b>%</b></font></span> </pre>
<br />


### Тестирование API с помощью POSTMAN:
В корне проекта есть [файл](https://github.com/semensid2020/ruby_api_2020/blob/develop/TICKETS_API_RUBY.postman_collection.json) коллекции запросов POSTMAN, необходимый для тестирования и демонстрации работы созданного API.


## Примечание:
Был создан модуль [SeedGenerator](https://github.com/semensid2020/ruby_api_2020/blob/develop/app/lib/seed_generator.rb) `app/lib/seed_generator.rb`, предоставляющий методы для генерации случайных данных:<br />
  - ФИО граждан, дату рождения
  - Данные об автомобилях: фирму-производитель, модель, гос.номер (с учетом государственного стандарта регистрационных номеров ТС)
  - Данные о нарушениях (штрафах): дата нарушения, номер штрафа

Также добавлена [rake-таск](https://github.com/semensid2020/ruby_api_2020/blob/develop/lib/tasks/more_random_seeds.rake) для множественной генерации записей в БД (`lib/tasks/more_random_seeds.rake`), генерирующая 100 записей каждого вида (кроме видов нарушений - ввиду их специфичности):
  - 100 граждан
  - 100 автомобилей
  - 100 штрафов

Для запуска rake-таск необходимо выполнить команду:<br />
`rails seeding:more_random_seeds`

<br />Данная rake-таск может быть выполнена неограниченное количество раз.<br />


## Благодарю за внимание!