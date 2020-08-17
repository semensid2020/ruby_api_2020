module SeedGenerator
  require 'realistic_russian_names'

  def surname(sex)
    sex == 1 ? realistic_russian_male_last_names.sample : realistic_russian_female_last_names.sample
  end

  def first_name(sex)
    sex == 1 ? realistic_russian_male_first_names.sample : realistic_russian_female_first_names.sample
  end

  def second_name(sex)
    sex == 1 ? realistic_russian_male_patronymics.sample : realistic_russian_female_patronymics.sample
  end

  def birth_date
    date = 18.years.ago.to_date - rand(365 * 50)
    date.strftime('%Y-%m-%d')
  end

  def car_number
    chars_avail = ['а', 'в', 'е', 'к', 'м', 'н', 'о', 'р', 'с', 'т', 'у', 'х']  # 12 букв - только кириллица!
    regions_avail = [10, 11, 12, 14, 15, 20, 21, 22, 33, 44, 55, 77, 777]
    number = "#{chars_avail[rand(chars_avail.size)]}"
             .concat "#{rand(0..9)}".concat "#{rand(0..9)}".concat "#{rand(0..9)}"
             .concat "#{chars_avail[rand(chars_avail.size)]}"
             .concat "#{chars_avail[rand(chars_avail.size)]}"
             .concat "-"
             .concat "#{regions_avail[rand(regions_avail.size)]}"
    number.upcase
  end

  def car_company
    companies_avail = ['Лада', 'Toyota', 'Ford', 'Mazda', 'Kia', 'Volkswagen', 'Mercedes-Benz', 'BMW']
    companies_avail[rand(companies_avail.size)]
  end

  def car_model(company)
    case company
    when 'Лада'
      models_available = ['2107', 'Калина', 'Приора', 'Гранта']
    when 'Toyota'
      models_available = ['Corolla', 'Carina', 'Camry', 'Tundra', 'Rav-4', 'Crown']
    when 'Ford'
      models_available = ['Fiesta', 'Fortuner', 'Focus', 'Expedition', 'Galaxy']
    when 'Mazda'
      models_available = ['3', '6', 'CX-5', 'MX-5 RF', 'CX-90']
    when 'Kia'
      models_available = ['Ceed', 'Cerato', 'Rio', 'Sorento', 'Sportage']
    when 'Volkswagen'
      models_available = ['Polo', 'Golf', 'Passat', 'Tiguan']
    when 'Mercedes-Benz'
      models_available = ['E-class', 'C-class', 'GLE-class', 'S-class']
    when 'BMW'
      models_available = ['M3', 'M4', 'X3', 'X4', 'X5', 'Z4', 'i4', 'i5']
    end

    models_available[rand(models_available.size)]
  end

  def ticket_date
    date = Date.today - rand(365)
    date.strftime('%Y-%m-%d')
  end

  def ticket_number(date)
    # Hack to get the following format: "20200817552854"
    date.delete('-').concat(rand.to_s[2..7])
  end
end