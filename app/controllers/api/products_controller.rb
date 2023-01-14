module Api
  class ProductsController < ApplicationController
    #before_action :authenticate_user!
    before_action :set_product, only: %i[show]
    ##before_action -> {check_user_roles(Security::RoleModule.only_admin_and_superadmin)}, only: %i[update create destroy]
    ##before_action -> {check_user_roles(Security::RoleModule.all_roles)}

    before_action :read_cache, only: %i[index show get_by_name]
    after_action -> {write_cache(@product)}, only: %i[index show get_by_name], if: -> {@is_cached == false}
    after_action -> {remove_cache}, only: %i[create update destroy]
    after_action :log_file


    def create
      @product = Product.create(product_params)
      authorize(@product)
      if @product.valid?
        @product.save
        render :create, status: :ok
      elsif render :error, status: :bad_request
      end
    end

    def update
      authorize(@product)
      if @product.update(product_params)
        render :update, status: :ok
      else
        @message = "update ederken hata oldu."
        handler_error
      end
    end

    def show
      unless @product.blank?
        render :show, status: :ok
      else
        @message = "urun bulunamadi"
        handler_error
      end
    end

    def get_by_name
      @product = Product.where(name: params[:name])
      if !@product.blank?
        render 'index.json.jbuilder', status: :ok
      end
      render json: { "data": @product.error }, status: :bad_request
    end

    def index
      @product = Product.order(created_at: :desc)
      if @product.blank?
        @message = "urun bulunamadi"
        handler_error
      else
        @message = "urunler listelendi."
        render :index, status: :ok
      end
    end

    def destroy
      authorize(@product)
      if @product.destroy
      render json: "silindi.", status: :ok
      else
        @message = "silinirken hata oldu."
        handler_error
      end
    end

    def handler_error
      render :error, status: :bad_request
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.permit(:name, :description, :quantity, :price, :product_image, :category_id)
    end
  end
end
