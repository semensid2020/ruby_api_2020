namespace :seeding do
  desc 'Создает рандомные сиды. Может быть выполнена не единожды'
  task more_random_seeds: :environment do
    class SeedGen
      extend SeedGenerator
    end

    # Генерируем 100 случайных граждан
    100.times do
      cit = Citizen.new({
                          sex: sex = rand(1..2),
                          surname: SeedGen.surname(sex),
                          first_name: SeedGen.first_name(sex),
                          second_name: SeedGen.second_name(sex),
                          birth_date: SeedGen.birth_date,
                          passport: rand(1000000000..9999999999)}
                        )
      cit.save || next
    end

    # Генерируем 100 случайных автомобилей
    citizens_number = Citizen.count
    100.times do
      car = Car.new({
                          car_number: SeedGen.car_number,
                          car_company: company_gen = SeedGen.car_company,
                          car_model: SeedGen.car_model(company_gen),
                          citizen_id: rand(1..citizens_number)
                      })
      car.save || next
    end

    # Генерируем виды нарушений и размеры штрафов (6 видов), если не созданы ранее
    if TicketType.count == 0
      TicketType.create([
                          { ticket_name: 'Управление незарегистрированным ТС', penalty_size: 800 },
                          { ticket_name: 'Управление ТС с нечитаемыми знаками', penalty_size: 500 },
                          { ticket_name: 'Управление ТС без номерных знаков', penalty_size: 5000 },
                          { ticket_name: 'Нелегальная перевозка пассажиров', penalty_size: 5000 },
                          { ticket_name: 'Передача ТС лицу без документов', penalty_size: 3000 },
                          { ticket_name: 'Нарушение требований к перевозке детей', penalty_size: 3000 }
                        ])
    end

    # Генерируем нарушения (100 штрафов)
    cars_number = Car.count
    ticket_types_number = TicketType.count

    100.times do
      ticket = Ticket.new({
                          ticket_date: date_gen = SeedGen.ticket_date,
                          ticket_number: SeedGen.ticket_number(date_gen),
                          ticket_type_id: rand(1..ticket_types_number),
                      })
      ticket.cars << Car.find(rand(1..cars_number))
      ticket.save || next
    end

    puts "rake task 'more_random_seeds' finished!!"
  end
end