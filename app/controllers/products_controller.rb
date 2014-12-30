class ProductsController < ApplicationController
require 'uri'
before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
def index

#client = Google::APIClient.new

@products = Product.paginate(:page => params[:page], :per_page => 30)
@manufacturers = Product.uniq.pluck(:manufacturer)
@categories = Product.uniq.pluck(:type_b)
@sub_categories = Product.uniq.pluck(:sub_type)

end

def category

  if params[:manufacturer] == "all"
    @products = Product.where(:type_b => params[:category]).paginate(:page => params[:page], :per_page => 30)
  else
    @products = Product.where(:type_b => params[:category], :manufacturer => params[:manufacturer]).paginate(:page => params[:page], :per_page => 30)
  end

  if params[:manufacturer] == "all"
    @sub_categories = Product.select("distinct sub_type").where( "type_b = ?", params[:category] ).collect! {|x| x.sub_type }
  else
    @sub_categories = Product.select("distinct sub_type").where( :type_b => params[:category] , :manufacturer => params[:manufacturer] ).collect! {|x| x.sub_type }

  end
  respond_to do |format|
    format.html 
    format.js
    format.json
  end
  
end

def save_image 
@posproduct = PhpposItems.where(["item_id= ?",params[:item_id]]);
@item_id = params[:item_id]
logger.warn("SRC")
logger.warn(params[:src])
@src=params[:src]
@posproduct[0].image_src = params[:src]
!@posproduct[0].save
respond_to do |format|
    format.html 
    format.js
    format.json
  end
end

def cameraicon

queryparts = params[:query].split(" ");
newword = []
queryparts.each do |qp|
newword.push(qp) unless qp =~ /\d/ 
end

params[:query] = newword.join(" ")

@googleimages = []

@posproduct = PhpposItems.where(["item_id = ?",params[:item_id]])[0];
suckr = ImageSuckr::GoogleSuckr.new

logger.warn("Google Image")
@googleimage = suckr.get_image_url({"q" => @posproduct.name}) 
logger.warn(@googleimage)

@products_by_item_number = Product.where(["phppos_item_item_number = ?",params[:item_number]])
@products_by_search = Product.search do
  fulltext params[:query]
  paginate :page => params[:page], :per_page => 30
end

@products_by_like = Product.where(["title LIKE ?","%"+params[:query]+"%"])

logger.warn(@products_by_item_number.inspect)
logger.warn(@products_by_search.inspect)
logger.warn(@products_by_like.inspect)



 respond_to do |format|
    format.html 
    format.js
    format.json
  end
end

def location

  if params[:location] == "all"
    @products = PhpposItems.paginate(:page => params[:page], :per_page => 30).order("quantity")
  else
    @products = PhpposItems.where(:location => params[:location]).paginate(:page => params[:page], :per_page => 30)
  end

  respond_to do |format|
    format.html 
    format.js
    format.json
  end
  
end

def poscategory
  orderby = params[:orderby].blank? || params[:orderby] == "all" ? "quantity" : params[:orderby] 
  if params[:poscategory] == "all"
    @products = PhpposItems.paginate(:page => params[:page], :per_page => 30).order(orderby)
   else
   @products = PhpposItems.where(:category => params[:poscategory]).paginate(:page => params[:page], :per_page => 30).order(orderby)
  end
 respond_to do |format|
    format.html 
    format.js
    format.json
  end
  
end


def poslocation
  orderby = params[:orderby].blank? || params[:orderby] == "all"  ? "quantity" : params[:orderby] 

  if params[:poslocation] == "all"
    @products = PhpposItems.paginate(:page => params[:page], :per_page => 30).order(orderby)
  else
    @products = PhpposItems.where(:location => params[:poslocation]).paginate(:page => params[:page], :per_page => 30).order(orderby)
   end


  respond_to do |format|
    format.html 
    format.js
    format.json
  end
  
end


def subcategory

  if params[:category] == "all" && params[:manufacturer] == "all"
    @products = Product.where(:sub_type => params[:subcategory]).paginate(:page => params[:page], :per_page => 30)
  elsif params[:category] == "all"
    @products = Product.where(:sub_type => params[:subcategory], :manufacturer => params[:manufacturer]).paginate(:page => params[:page], :per_page => 30)
  elsif params[:subcategory] != "all"
    @products = Product.where(:sub_type => params[:subcategory], :manufacturer => params[:manufacturer], :type_b => params[:category]).paginate(:page => params[:page], :per_page => 30)
  else
    @products = Product.where(:type_b => params[:category], :manufacturer => params[:manufacturer]).paginate(:page => params[:page], :per_page => 30)
  end

  respond_to do |format|
    format.html 
    format.js
    format.json
  end
  
end

def manufacturer
  @products = Product.where(:manufacturer => params[:manufacturer]).paginate(:page => params[:page], :per_page => 30)
  @categories = Product.select("distinct type_b").where( "manufacturer = ?", params[:manufacturer] ).collect! {|x| x.type_b }
  @sub_categories = Product.select("distinct sub_type").where( "manufacturer = ?", params[:subcategory] ).collect! {|x| x.sub_type }

  respond_to do |format|
    format.html 
    format.js
    format.json
  end

end

# GET /products/1
# GET /products/1.json
def show
end

def search 
@products = Product.search do
  fulltext params[:query]
  paginate :page => params[:page], :per_page => 30
end

@products = @products.results 
    respond_to do |format|
      format.html 
      format.js
      format.json
    end

  end

def possearch
@products = PhpposItems.search do
  fulltext params[:query]
  paginate :page => params[:page], :per_page => 30
  with(:category,params[:poscategory]) unless params[:poscategory] == "all" || params[:poscategory].blank?
end

@products = @products.results

 respond_to do |format|
      format.html 
      format.js
      format.json
 end
end


  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

def posinfo
   @product = Product.find(params[:product_id])
   @relatedproducts = PhpposItems.items_like @product.title

   respond_to do |format|
    format.html 
    format.js
    format.json
  end
end

def positemsonly

  if params[:filter] == "outofstock"
    @products = PhpposItems.where("quantity < reorder_level").paginate(:page => params[:page], :per_page => 30).order("reorder_level DESC")
  else 
    @products = PhpposItems.paginate(:page => params[:page], :per_page => 30).order("quantity DESC")
  end 

  @locations = PhpposItems.uniq.pluck(:location)
  @pos_categories = PhpposItems.uniq.pluck(:category)
  logger.warn(@products.size)
  respond_to do |format|
    format.html 
    format.js
    format.json
  end

end

def item_sales

  @item = PhpposSalesItems.find_by_item_id(params[:item_id])
  @sales = @item.sales

 respond_to do |format|
    format.html 
    format.js
    format.json
  end

end

def sale_items

logger.warn(params)

  @sale = PhpposSales.find_by_sale_id(params[:sale_id])
 
logger.warn(@sale.items.inspect)
  @items = @sale.items 


 respond_to do |format|
    format.html 
    format.js
    format.json
  end



end


  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params[:product]
    end



  end
