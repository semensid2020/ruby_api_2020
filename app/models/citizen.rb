# frozen_string_literal: true

class Citizen < ApplicationRecord
  has_many :cars

  validates :passport, presence: true, uniqueness: true, length: { is: 10 }
  validates :first_name, :surname, presence: true, length: { minimum: 1 }
  validates :sex, :birth_date, presence: true

  validates_format_of :passport, :with => /\A\d+\z/
  validates_format_of :birth_date, :with => /\A[1-2]\d{3}\-\d{2}-\d{2}\z/
  validates_format_of :first_name, :surname, :with => /\A[А-яЁё\s\-]+\z/
  validates_format_of :second_name, :with => /\A[А-яЁё\s\-]+\z/, unless: -> {second_name.blank?}

  enum sex: { неизвестно: 0, муж: 1, жен: 2 }

  def self.searchable_attributes
    %i[first_name second_name surname passport]
  end

  def presented_as_json
    self.as_json(except: %i[created_at updated_at id])
  end
end
