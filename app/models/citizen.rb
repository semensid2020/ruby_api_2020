# frozen_string_literal: true

class Citizen < ApplicationRecord
  include Downcasing
  has_many :cars

  validates_uniqueness_of :passport
  validates :first_name, :surname, :passport, :sex, :birth_date, presence: true
  validates_format_of :first_name, :surname, :with => /[А-яЁё]+/
  validates_format_of :second_name, :with => /[А-яЁё]+/, unless: -> {second_name.blank?}

  enum sex: { неизвестно: 0, муж: 1, жен: 2 }

  def self.searchable_attributes
    %i[first_name second_name surname passport]
  end
end
