class CreateAdultDvdMarketplaces < ActiveRecord::Migration
  def change
    create_table :adult_dvd_marketplaces do |t|
      t.string :link	
      t.timestamps
    end
  end
end
