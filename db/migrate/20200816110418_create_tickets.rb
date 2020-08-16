class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :ticket_number, null: false
      t.date :ticket_date, null: false
      t.integer :ticket_type_id, null: false
      t.timestamps
    end
  end
end
