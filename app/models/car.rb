# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :citizen
  has_and_belongs_to_many :tickets

  validates_uniqueness_of :car_number
  validates :car_number, :car_company, :car_model, presence: true
  validates_format_of :car_number, :car_company, :car_model, :with => /[0-9A-zА-яЁё\s\-]+/

  def self.searchable_attributes
    %i[car_number car_company car_model]
  end

  def presented_as_json
    self.as_json(except: %i[created_at updated_at id citizen_id])
  end
end
