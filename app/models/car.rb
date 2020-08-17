# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :citizen
  has_and_belongs_to_many :tickets

  validates_uniqueness_of :car_number
  validates :car_number, :car_company, :car_model, presence: true
  validates_format_of :car_number, :with => /\A[авекмнорстух]\d{3}[авекмнорстух]{2}\-\d{2,3}\z/i
  validates_format_of :car_company, :car_model, :with => /\A[0-9A-zА-яЁё\s\-]+\z/

  def self.searchable_attributes
    %i[car_number car_company car_model]
  end

  def presented_as_json
    self.as_json(except: %i[created_at updated_at id citizen_id])
  end
end
