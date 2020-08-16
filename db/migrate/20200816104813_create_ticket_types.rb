class CreateTicketTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_types do |t|
      t.string :ticket_name, null: false, unique: true
      t.integer :penalty_size, null: false
      t.timestamps
    end

    add_index :ticket_types, :ticket_name
  end
end
