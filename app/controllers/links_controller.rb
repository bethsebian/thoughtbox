class LinksController < ApplicationController
  def index
    @link = Link.new
    user = User.find(current_user.id) if current_user
    @links = user.links if current_user
  end

  def create
    @link = Link.new(link_params)
    if !current_user
      flash[:notice] = "Please log in to view links."
      redirect_to links_path
    elsif @link.save && current_user
      redirect_to links_path
    else
      flash[:notice] = "The url is invalid. Please try again."
      redirect_to links_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end
end