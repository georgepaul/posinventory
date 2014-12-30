class PhpposSuppliers < ActiveRecord::Base
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
 :class_name => "PhpposItems",
 :foreign_key => :supplier_id,
 :primary_key => :person_id

end
