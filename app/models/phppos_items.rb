class PhpposItems < ActiveRecord::Base
require 'net/https'
  establish_connection(
  :adapter  => "mysql2",
  :host     => "192.168.2.240",
  :username => "test",
  :pool => 5,
  :password => "testtest",
  :database => "bitnami_phppos",
  :encoding => 'utf8'
)

  searchable do
    text :search
	end

def self.items_like name
	return self.search { fulltext "'silicone'" }
end



end
