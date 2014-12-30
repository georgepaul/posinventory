class PhpposSales < ActiveRecord::Base
require 'net/https'

 establish_connection(
    :adapter  => "mysql2",
    :host     => "localhost",
    :username => "root",
    :pool => 5,
    :password => "root",
    :database => "bitnami_phppos",
    :encoding => 'utf8'
  )
 

	has_many :items,
		:class_name => "PhpposSalesItems",
		:foreign_key => "sale_id"



def items

  PhpposSalesItems.where(["sale_id = ?",self.sale_id]).joins(:item)

end


end
