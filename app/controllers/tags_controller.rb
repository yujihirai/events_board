class TagsController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @tag = Tag.friendly.find(params[:id])
    @categories = Category.order(:name)
  end
end
