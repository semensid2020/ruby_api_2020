# frozen_string_literal: true

class TicketType < ApplicationRecord
  has_many :tickets

  validates :penalty_size, presence: true
  validates_format_of :ticket_name, :with => /\A[0-9А-яЁё\s\-]+\z/, allow_blank: false

  def self.searchable_attributes
    %i[ticket_name]
  end
end
