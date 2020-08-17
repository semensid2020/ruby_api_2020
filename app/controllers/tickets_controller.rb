# frozen_string_literal: true

class TicketsController < ApplicationController

  def index
    search_results = []

    # Делаем выборку id машин по данным о нём (регистрационный номер, марка и модель ТС)
    cars = Car.all
    Car.searchable_attributes.each do |sa|
      cars = cars.where("#{sa} LIKE ?", "%" + Car.sanitize_sql_like(params[sa].downcase) + "%") if params[sa]
    end
    render json: {} and return if cars.blank?

    searched_cars_ids = []
    cars.each { |car| searched_cars_ids << car.id }

    # Делаем выборку id граждан по данным о владельце (ФИО, номер паспорта)
    citizens = Citizen.all
    Citizen.searchable_attributes.each do |sa|
      citizens = citizens.where("#{sa} LIKE ?", "%" + Citizen.sanitize_sql_like(params[sa].downcase) + "%") if params[sa]
    end
    render json: {} and return if citizens.blank?

    searched_citizens_ids = []
    citizens.each { |citizen| searched_citizens_ids << citizen.id }

    # Делаем выборку id типов штрафов по названию штрафа
    ticket_types = TicketType.all
    TicketType.searchable_attributes.each do |sa|
      ticket_types = ticket_types.where("#{sa} LIKE ?", "%" + TicketType.sanitize_sql_like(params[sa].downcase) + "%") if params[sa]
    end
    render json: {} and return if ticket_types.blank?

    searched_ticket_types_ids = []
    ticket_types.each { |ticket_type| searched_ticket_types_ids << ticket_type.id }

    # Формируем итоговый ответ
    Ticket.eager_load(:cars)
          .where(tickets: { ticket_type_id: searched_ticket_types_ids })
          .where(cars: { citizen_id: searched_citizens_ids })
          .where(cars: { id: searched_cars_ids }).each do |t|
            item = {
              :ticket => t.as_json(except: %i[created_at updated_at ticket_type_id]).merge({
                                                    ticket_name: "#{t.ticket_type.ticket_name}",
                                                    penalty: t.ticket_type.penalty_size
                                                  }),
              :car => t.cars.first.as_json(except: %i[created_at updated_at id citizen_id]),
              :citizen => t.cars.first.citizen.as_json(except: %i[created_at updated_at id])
            }
            search_results << item
          end

    render json: search_results
  end
end
