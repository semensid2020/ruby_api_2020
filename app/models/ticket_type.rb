# frozen_string_literal: true

class TicketType < ApplicationRecord
  include Downcasing
  has_many :tickets

  validates :penalty_size, presence: true
  validates_format_of :ticket_name, :with => /[0-9A-zА-яЁё\s\-]+/, allow_blank: false

  def self.searchable_attributes
    %i[ticket_name]
  end
end
