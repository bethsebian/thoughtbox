class Api::V1::LinksController < ApplicationController
  respond_to :json

  def show
    @link = Link.find(params[:id])
    respond_with @link
  end

  def index
    @links = current_user.links
    respond_with @links
  end

  def update
    link = Link.find(params[:id])
    link.read_status = params[:change_type]
    link.save
    respond_to do |format|
      format.json { render json: link }
    end
  end
end