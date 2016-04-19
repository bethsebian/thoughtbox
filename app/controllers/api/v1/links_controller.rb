class Api::V1::LinksController < ApplicationController
  respond_to :json

  def index
    @links = current_user.links
    respond_with @links
  end
end