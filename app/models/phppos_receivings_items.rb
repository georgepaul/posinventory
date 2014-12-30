class PhpposReceivingsItems < ActiveRecord::Base

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

	belongs_to :receiving,
	:class_name => "PhpposReceivings",
	:foreign_key => "receiving_id"
end
