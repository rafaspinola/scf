# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150212014648) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "cnpj"
    t.string   "county_subscription"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "responsible_name"
    t.string   "responsible_email"
    t.string   "responsible_job_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_class_dates", force: true do |t|
    t.integer  "course_class_id"
    t.date     "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_class_dates", ["course_class_id"], name: "index_course_class_dates_on_course_class_id", using: :btree

  create_table "course_classes", force: true do |t|
    t.integer  "course_id"
    t.string   "city"
    t.string   "address"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_classes", ["course_id"], name: "index_course_classes_on_course_id", using: :btree

  create_table "course_classes_trainers", force: true do |t|
    t.integer  "course_class_id"
    t.integer  "trainer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_classes_trainers", ["course_class_id"], name: "index_course_classes_trainers_on_course_class_id", using: :btree
  add_index "course_classes_trainers", ["trainer_id"], name: "index_course_classes_trainers_on_trainer_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.decimal  "price6",     precision: 10, scale: 0
    t.decimal  "price5",     precision: 10, scale: 0
    t.decimal  "price4",     precision: 10, scale: 0
    t.decimal  "price3",     precision: 10, scale: 0
    t.decimal  "price2",     precision: 10, scale: 0
    t.decimal  "price",      precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.string   "name"
    t.string   "cpf"
    t.date     "birthday"
    t.string   "marital_state"
    t.string   "address"
    t.string   "neighborhood"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "email"
    t.string   "profession"
    t.string   "job_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salesmen", force: true do |t|
    t.string   "name"
    t.string   "bank"
    t.integer  "agency"
    t.string   "account"
    t.string   "operation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "participant_id"
    t.integer  "course_class_id"
    t.integer  "company_id"
    t.integer  "salesman_id"
    t.decimal  "amount",             precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "retains_iss"
    t.boolean  "charge_company"
    t.date     "first_payment_date"
    t.text     "observations"
    t.string   "payment_method"
  end

  add_index "subscriptions", ["company_id"], name: "index_subscriptions_on_company_id", using: :btree
  add_index "subscriptions", ["course_class_id"], name: "index_subscriptions_on_course_class_id", using: :btree
  add_index "subscriptions", ["participant_id"], name: "index_subscriptions_on_participant_id", using: :btree
  add_index "subscriptions", ["salesman_id"], name: "index_subscriptions_on_salesman_id", using: :btree

  create_table "trainers", force: true do |t|
    t.string   "name"
    t.string   "bank"
    t.integer  "agency"
    t.string   "account"
    t.string   "operation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
