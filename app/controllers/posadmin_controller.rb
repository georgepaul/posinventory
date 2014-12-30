class PosadminController < ApplicationController

layout "admin"
skip_before_action :verify_authenticity_token

def images
@image = PhpposItems.where("image_src IS NULL").paginate(:page => params[:page], :per_page => 1).order("quantity DESC")
@potential_images = []
  (0..8).each do | img |
  	 suckr = ImageSuckr::GoogleSuckr.new
  	 logger.warn(@image.inspect)
     #@potential_images.push(suckr.get_image_url({"q" => @image[0].name}))
end
respond_to do |format|
      format.html 
      format.js
      format.json
end
end

def save_image
@image = PhpposItems.where("item_id=?",params[:item_id])
logger.warn(@image);
@image[0].image_src = params[:image_src]
@image[0].save

@potential_images = []
  (0..8).each do | img |
     suckr = ImageSuckr::GoogleSuckr.new
     @potential_images.push(suckr.get_image_url({"q" => @image[0].name}))
end

redirect_to "/posadmin/images", :page => params[:page]


end

end
