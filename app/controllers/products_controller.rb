class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
		
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
=begin
		@file_extension = File.extname("#{product_params[:avatar_file_name]}") 
		@file_name = product_params[:avatar_file_name]
		
		@tmp = File.basename("#{product_params[:avatar_file_name]}",'.*')
		@tmp1 = @tmp.inspect + ".png"
		@product.avatar_file_name = @tmp1 
=end			 
			
		#@product.avatar_file_name =	processors: [:custom]

			if @product.save!	
				redirect_to action: 'index', notice: 'User was successfully created.'
			else
      	render action: 'new', alert: 'User could not be created' 
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
      params.require(:product).permit(:name, :avatar, :resume)
    end
end
