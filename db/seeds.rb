# Генерируем базу граждан (8 граждан)
Citizen.create([
          { sex: 1, surname: 'Иванов',     first_name: 'Иван',     second_name: 'Иванович',    birth_date: '1978-05-17', passport: 1234567890 },
          { sex: 1, surname: 'Акимов',     first_name: 'Иван',     second_name: 'Васильевич',  birth_date: '1994-08-22', passport: 7628507273 },
          { sex: 1, surname: 'Ахмедов',    first_name: 'Эльман',   second_name: 'Дилгам оглы', birth_date: '2000-01-10', passport: 8532605686 },
          { sex: 1, surname: 'Ким',        first_name: 'Олег',     second_name: 'Васильевич',  birth_date: '1969-12-23', passport: 5412312342 },
          { sex: 1, surname: 'Ильина',     first_name: 'Ольга',    second_name: 'Олеговна',    birth_date: '1992-04-30', passport: 1232152312 },
          { sex: 2, surname: 'Ким',        first_name: 'Анна',     second_name: 'Витальевна',  birth_date: '1977-01-28', passport: 7859306572 },
          { sex: 2, surname: 'Филимонова', first_name: 'Марианна', second_name: '',            birth_date: '1964-03-27', passport: 3609539574 },
          { sex: 2, surname: 'Петреченко', first_name: 'Ксения',   second_name: 'Адамовна',    birth_date: '1980-12-31', passport: 9736406958 }
        ])

# Генерируем базу автомобилей (12 машин)
cit_first = Citizen.first.id
Car.create([
      { car_number: 'а358хо-70',  car_company: 'Лада',   car_model: 'Гранта',      citizen_id: "#{cit_first}" },
      { car_number: 'н100рм-70',  car_company: 'Toyota', car_model: 'Caldina',     citizen_id: "#{cit_first}" },
      { car_number: 'м982хх-54',  car_company: 'Ford',   car_model: 'Fiesta',      citizen_id: "#{cit_first + 1}" },
      { car_number: 'н250те-70',  car_company: 'Nissan', car_model: 'Sunny',       citizen_id: "#{cit_first + 2}" },
      { car_number: 'р666рр-777', car_company: 'Лада',   car_model: 'Веста',       citizen_id: "#{cit_first + 2}" },
      { car_number: 'р234нт-85',  car_company: 'BMW',    car_model: 'M5',          citizen_id: "#{cit_first + 2}" },
      { car_number: 'х213оо-34',  car_company: 'Toyota', car_model: 'Carina',      citizen_id: "#{cit_first + 3}" },
      { car_number: 'р345ан-70',  car_company: 'BMW',    car_model: 'X5',          citizen_id: "#{cit_first + 4}" },
      { car_number: 'о666рх-70',  car_company: 'Toyota', car_model: 'Fielder',     citizen_id: "#{cit_first + 5}" },
      { car_number: 'а222аа-52',  car_company: 'ГАЗ',    car_model: 'Газель 2016', citizen_id: "#{cit_first + 5}" },
      { car_number: 'р124ах-777', car_company: 'Nissan', car_model: 'Skyline',     citizen_id: "#{cit_first + 6}" },
      { car_number: 'х999ам-70',  car_company: 'Toyota', car_model: 'Corolla',     citizen_id: "#{cit_first + 7}" }
    ])

# Генерируем виды нарушений и размеры штрафов (6 видов)
TicketType.create([
            { ticket_name: 'Управление незарегистрированным ТС',     penalty_size: 800 },
            { ticket_name: 'Управление ТС c нечитаемыми знаками',    penalty_size: 500 },
            { ticket_name: 'Управление ТС без номерных знаков',      penalty_size: 5000 },
            { ticket_name: 'Нелегальная перевозка пассажиров',       penalty_size: 5000 },
            { ticket_name: 'Передача ТС лицу без документов',        penalty_size: 3000 },
            { ticket_name: 'Нарушение требований к перевозке детей', penalty_size: 3000 }
          ])

# Генерируем нарушения (23 штрафа)
tick_type_first = TicketType.first.id
Ticket.create([
        { ticket_number: '20200101999888', ticket_date: '2020-01-01', ticket_type_id: "#{tick_type_first}" },
        { ticket_number: '20200105777666', ticket_date: '2020-01-05', ticket_type_id: "#{tick_type_first + 1}" },
        { ticket_number: '20200129555444', ticket_date: '2020-01-29', ticket_type_id: "#{tick_type_first + 2}" },
        { ticket_number: '20200204333222', ticket_date: '2020-02-04', ticket_type_id: "#{tick_type_first + 3}" },
        { ticket_number: '20200206111000', ticket_date: '2020-02-06', ticket_type_id: "#{tick_type_first + 4}" },
        { ticket_number: '20200211999888', ticket_date: '2020-02-11', ticket_type_id: "#{tick_type_first}" },
        { ticket_number: '20200223777666', ticket_date: '2020-02-23', ticket_type_id: "#{tick_type_first + 1}" },
        { ticket_number: '20200228555444', ticket_date: '2020-02-28', ticket_type_id: "#{tick_type_first + 2}" },
        { ticket_number: '20200316333222', ticket_date: '2020-03-16', ticket_type_id: "#{tick_type_first + 3}" },
        { ticket_number: '20200322111000', ticket_date: '2020-03-22', ticket_type_id: "#{tick_type_first + 4}" },
        { ticket_number: '20200404999888', ticket_date: '2020-04-04', ticket_type_id: "#{tick_type_first + 5}" },
        { ticket_number: '20200413777666', ticket_date: '2020-04-13', ticket_type_id: "#{tick_type_first}" },
        { ticket_number: '20200415555444', ticket_date: '2020-04-15', ticket_type_id: "#{tick_type_first + 1}" },
        { ticket_number: '20200501333222', ticket_date: '2020-05-01', ticket_type_id: "#{tick_type_first + 2}" },
        { ticket_number: '20200502111000', ticket_date: '2020-05-02', ticket_type_id: "#{tick_type_first + 3}" },
        { ticket_number: '20200503999888', ticket_date: '2020-05-03', ticket_type_id: "#{tick_type_first + 4}" },
        { ticket_number: '20200509777666', ticket_date: '2020-05-09', ticket_type_id: "#{tick_type_first + 5}" },
        { ticket_number: '20200607555444', ticket_date: '2020-06-07', ticket_type_id: "#{tick_type_first}" },
        { ticket_number: '20200601333222', ticket_date: '2020-06-01', ticket_type_id: "#{tick_type_first + 1}" },
        { ticket_number: '20200612111000', ticket_date: '2020-06-12', ticket_type_id: "#{tick_type_first + 2}" },
        { ticket_number: '20200616999888', ticket_date: '2020-06-16', ticket_type_id: "#{tick_type_first + 3}" },
        { ticket_number: '20200701777666', ticket_date: '2020-07-01', ticket_type_id: "#{tick_type_first + 4}" },
        { ticket_number: '20200814555444', ticket_date: '2020-08-14', ticket_type_id: "#{tick_type_first + 5}" }
      ])

# Заполняем JOIN TABLE (связь автомобиль-нарушение)
connection = ActiveRecord::Base.connection()
connection.execute("INSERT INTO cars_tickets (car_id,ticket_id) VALUES
                    (1,1),
                    (3,2),
                    (3,3),
                    (3,4),
                    (5,5),
                    (6,6),
                    (1,7),
                    (3,8),
                    (7,9),
                    (8,10),
                    (4,11),
                    (10,12),
                    (10,13),
                    (11,14),
                    (12,15),
                    (1,16),
                    (2,17),
                    (4,18),
                    (1,19),
                    (2,20),
                    (1,21),
                    (2,22),
                    (2,23)"
                  )
puts 'seeding finished!!'
