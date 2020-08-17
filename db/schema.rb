# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_16_123358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "car_number", null: false
    t.string "car_company", null: false
    t.string "car_model", null: false
    t.integer "citizen_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_company"], name: "index_cars_on_car_company"
    t.index ["car_model"], name: "index_cars_on_car_model"
    t.index ["car_number"], name: "index_unique_car_numbers", unique: true
  end

  create_table "cars_tickets", id: false, force: :cascade do |t|
    t.integer "car_id"
    t.integer "ticket_id"
  end

  create_table "citizens", force: :cascade do |t|
    t.string "passport", null: false
    t.integer "sex", default: 0, null: false
    t.string "surname", null: false
    t.string "first_name", null: false
    t.string "second_name"
    t.date "birth_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_name"], name: "index_citizens_on_first_name"
    t.index ["passport"], name: "index_unique_citizens_passports", unique: true
    t.index ["second_name"], name: "index_citizens_on_second_name"
    t.index ["surname"], name: "index_citizens_on_surname"
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string "ticket_name", null: false
    t.integer "penalty_size", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_name"], name: "index_ticket_types_on_ticket_name"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "ticket_number", null: false
    t.date "ticket_date", null: false
    t.integer "ticket_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
