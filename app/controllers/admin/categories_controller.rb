class Admin::CategoriesController < Admin::ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.order(:name)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category has been created."
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Category has not been created."
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category has been updated."
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Category has not updated."
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = "Category has been deleted."
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :summary)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
