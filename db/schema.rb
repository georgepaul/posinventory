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

ActiveRecord::Schema.define(version: 20141203164135) do

  create_table "inventories", force: true do |t|
    t.integer  "product_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "handle"
    t.string   "title"
    t.string   "body_html"
    t.string   "vendor"
    t.string   "manufacturer"
    t.string   "type_b"
    t.string   "sub_type"
    t.string   "category_3"
    t.string   "tags"
    t.string   "published"
    t.string   "option1_name"
    t.string   "option1_value"
    t.string   "option2_name"
    t.string   "option2_value"
    t.string   "option3_name"
    t.string   "option3_value"
    t.string   "variant_sku"
    t.string   "variant_grams"
    t.string   "variant_inventory_tracker"
    t.string   "variant_inventory_quantity"
    t.string   "variant_inventory_policy"
    t.string   "variant_fulfullment_service"
    t.string   "variant_price"
    t.string   "variant_compare_at_price"
    t.integer  "variant_requires_shipping"
    t.integer  "variant_tax"
    t.integer  "variant_barcode"
    t.string   "image_src"
    t.string   "thumbnail"
    t.string   "image_2"
    t.string   "image_3"
    t.string   "image_4"
    t.string   "image_alt_text"
    t.string   "collection"
    t.string   "length"
    t.string   "insertable"
    t.string   "width"
    t.string   "inner_diameter"
    t.integer  "quantity"
    t.string   "brand"
    t.string   "related_items"
    t.string   "alternate_product"
    t.string   "prohibited"
    t.string   "color"
    t.string   "material"
    t.string   "shape"
    t.string   "feature"
    t.string   "function"
    t.string   "powered_by"
    t.string   "batteries_required"
    t.string   "pornstar"
    t.string   "doctor_name"
    t.string   "fragrance"
    t.string   "flavor"
    t.string   "clothing_size"
    t.string   "bra_size"
    t.string   "shoe_size"
    t.string   "heel_size"
    t.string   "texture"
    t.string   "genre"
    t.string   "studio"
    t.string   "dvd_feature"
    t.string   "director"
    t.string   "dvd_genres"
    t.string   "other"
    t.string   "cast"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productsd", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
