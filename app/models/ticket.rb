# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_and_belongs_to_many :cars
  belongs_to :ticket_type

  validates :ticket_date, :ticket_type_id, presence: true

  def presented_as_json
    self.as_json(except: %i[created_at updated_at ticket_type_id])
  end
end
