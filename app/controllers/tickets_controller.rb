# frozen_string_literal: true

class TicketsController < ApplicationController

  def index
    search_results = []

    # Делаем выборку id машин по данным о нём (регистрационный номер, марка и модель ТС)
    searched_cars_ids = filter_collection(Car)
    render json: {} and return if searched_cars_ids.blank?

    # Делаем выборку id граждан по данным о владельце (ФИО, номер паспорта)
    searched_citizens_ids = filter_collection(Citizen)
    render json: {} and return if searched_citizens_ids.blank?

    # Делаем выборку id типов штрафов по названию штрафа
    searched_ticket_types_ids = filter_collection(TicketType)
    render json: {} and return if searched_ticket_types_ids.blank?

    # Формируем итоговый ответ
    Ticket.eager_load(:cars).includes([:ticket_type])
          .where(tickets: { ticket_type_id: searched_ticket_types_ids })
          .where(cars: { citizen_id: searched_citizens_ids })
          .where(cars: { id: searched_cars_ids }).each do |t|
            item = {
              :ticket => t.presented_as_json.merge({
                                                    ticket_name: "#{t.ticket_type.ticket_name}",
                                                    penalty: t.ticket_type.penalty_size
                                                  }),
              :car => t.cars.first.presented_as_json,
              :citizen => t.cars.first.citizen.presented_as_json
            }
            search_results << item
          end

    # Добавляем пагинацию: делим ответ на страницы и отображаем нужную часть ответа (на основании переданного параметра page)
    paginatable_results = Kaminari.paginate_array(search_results).page(params[:page]).per(10)

    render json: paginatable_results
  end

  private

  def filter_collection(classname)
    return [] unless classname.respond_to?(:searchable_attributes)

    collection = classname.all
    classname.searchable_attributes.each do |sa|
      collection = collection.where("#{sa} LIKE ?", '%' + classname.sanitize_sql_like(params[sa]) + '%') if params[sa]
    end

    return [] if collection.blank?
    ids_filtered = []
    collection.each { |item| ids_filtered << item.id }

    ids_filtered
  end
end
