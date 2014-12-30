class PhpposReceivings < ActiveRecord::Base

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

	has_many :received_items,
	:class_name => "PhpposReceivingsItems",
	:foreign_key => "receiving_id"
end
