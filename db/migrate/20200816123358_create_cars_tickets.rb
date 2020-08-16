class CreateCarsTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :cars_tickets, id: false do |t|
      t.integer :car_id
      t.integer :ticket_id
    end
  end
end
