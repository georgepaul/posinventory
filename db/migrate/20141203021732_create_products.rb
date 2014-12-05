class CreateProducts < ActiveRecord::Migration
  def change
    create_table :productsd do |t|
    t.timestamps
   end
  end
end
