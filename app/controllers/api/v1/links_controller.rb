class Api::V1::LinksController < ApplicationController
  respond_to :json
  
  def index
    @links = Link.all
    respond_with @links
  end
end