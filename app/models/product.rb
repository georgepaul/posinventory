class Product < ActiveRecord::Base

	has_one :inventory
	attr_accessor :images

 searchable do
    text :search
    text :category_3
    end



def self.update_images
=begin
	@products = Product.all
	@products.each do | product |
		suckr = ImageSuckr::GoogleSuckr.new
		@products.collect! { |product|
		@url = suckr.get_image_url({"q" => product.title})
		product.images = @url
	end
=end
end






end
