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

  def subcategory

    if params[:category] == "all" && params[:manufacturer] == "all"
      @products = Product.where(:sub_type => params[:subcategory]).paginate(:page => params[:page], :per_page => 30)
    logger.warn("dd")
    elsif params[:category] == "all"
      @products = Product.where(:sub_type => params[:subcategory], :manufacturer => params[:manufacturer]).paginate(:page => params[:page], :per_page => 30)
        logger.warn("ee")
    elsif params[:subcategory] != "all"
      @products = Product.where(:sub_type => params[:subcategory], :manufacturer => params[:manufacturer], :type_b => params[:category]).paginate(:page => params[:page], :per_page => 30)
    logger.warn("dddeee")
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
    @products = Product.search(params[:query])

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
