class PhpposSalesItems < ActiveRecord::Base
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


  belongs_to :item,
             :class_name => "PhpposItems",
             :foreign_key => "item_id"


def sales

  PhpposSales.where(["sale_id = ?",self.sale_id])

end


end
