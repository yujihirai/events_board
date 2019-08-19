class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  skip_after_action :verify_authorized

  def show
    @categories = Category.order(:name)
    @category_events = @category.events.order('created_at DESC')
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The category you were looking for could not be found."
    redirect_to(request.referrer || events_url)
  end
end
