# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_01_164143) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_activities_on_park_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "postalCode"
    t.string "city"
    t.string "stateCode"
    t.string "countryCode"
    t.string "provinceTerritoryCode"
    t.string "line1"
    t.string "line2"
    t.string "line3"
    t.string "addressType"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_addresses_on_park_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.text "phoneNumbers"
    t.text "emailAddresses"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_contacts_on_park_id"
  end

  create_table "entrance_fees", force: :cascade do |t|
    t.string "cost"
    t.text "description"
    t.string "title"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_entrance_fees_on_park_id"
  end

  create_table "entrance_passes", force: :cascade do |t|
    t.string "cost"
    t.text "description"
    t.string "title"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_entrance_passes_on_park_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "credit"
    t.string "altText"
    t.string "title"
    t.text "caption"
    t.string "url"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_id"
    t.index ["park_id"], name: "index_images_on_park_id"
  end

  create_table "operating_hours", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "standardHours"
    t.text "exceptions"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_operating_hours_on_park_id"
  end

  create_table "parks", force: :cascade do |t|
    t.string "fullName"
    t.text "description"
    t.string "designation"
    t.text "directionsInfo"
    t.string "directionsUrl"
    t.string "latLong"
    t.string "latitude"
    t.string "longitude"
    t.string "name"
    t.string "parkCode"
    t.float "relevanceScore"
    t.string "states"
    t.string "url"
    t.text "weatherInfo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.bigint "park_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_topics_on_park_id"
  end

  add_foreign_key "activities", "parks"
  add_foreign_key "addresses", "parks"
  add_foreign_key "contacts", "parks"
  add_foreign_key "entrance_fees", "parks"
  add_foreign_key "entrance_passes", "parks"
  add_foreign_key "images", "parks"
  add_foreign_key "operating_hours", "parks"
  add_foreign_key "topics", "parks"
end
