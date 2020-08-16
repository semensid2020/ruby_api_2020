class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :car_number, null: false, unique: true
      t.string :car_company, null: false
      t.string :car_model, null: false
      t.integer :citizen_id, null: false
      t.timestamps
    end

    add_index :cars, :car_number, unique: true, name: 'index_unique_car_numbers'
    add_index :cars, :car_company
    add_index :cars, :car_model
  end
end
