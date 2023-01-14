module Api
  class CategoriesController < ApplicationController
    before_action :authenticate_user!

    before_action :read_cache, only: %i[index show]
    before_action :set_category, only: %i[update show destroy]

    after_action -> {write_cache(@product)},only: %i[index show], if: -> {@is_cached == false}
    after_action -> {remove_cache  },only: %i[create update destroy]
    after_action :log_file
    def create
      @category = Category.create(category_params)
      authorize(@category)

      unless @category.save
        render json: "category kaydedilmedi.", status: :bad_request
      else
        render :create, status: :ok
      end
    end

    def update
      @category.update(category_params)
      authorize(@category)

      unless @category.save
        render json: "category kaydedilmedi.", status: :bad_request
      else
        render :update, status: :ok
      end
    end

    def show
      if @category.blank?
        render json: "Bulunamadi.", status: :bad_request
      else
        render :show, status: :ok
      end
    end

    def get_by_name
      @category = Category.where(name: params[:name])
      if @category.blank?
        render json: "Bulunamadi.", status: :bad_request
      else
        handler_error
      end
    end

    def index
      @categories = Category.order(created_at: :desc)
      unless @categories.blank?
        render :index, status: :ok
      else
        handler_error
      end
    end

    def destroy
      authorize(@category)

      unless @category.destroy
        render :destroy, status: :ok
      else
        @message = "silerken hata oldu"
        handler_error
      end
    end

    def handler_error
      render :error, status: :bad_request
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.permit(:name)
    end


  end
end
