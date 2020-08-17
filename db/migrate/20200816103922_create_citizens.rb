class CreateCitizens < ActiveRecord::Migration[6.0]
  def change
    create_table :citizens do |t|
      t.string :passport, null: false, unique: true
      t.integer :sex, null: false, default: 0
      t.string :surname, null: false
      t.string :first_name, null: false
      t.string :second_name
      t.date :birth_date, null: false
      t.timestamps
    end

    add_index :citizens, :surname
    add_index :citizens, :first_name
    add_index :citizens, :second_name
    add_index :citizens, :passport, unique: true, name: 'index_unique_citizens_passports'
  end
end
