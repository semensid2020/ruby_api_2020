# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_and_belongs_to_many :cars
  belongs_to :ticket_type

  validates :ticket_date, :ticket_type_id, presence: true
end
