class HomeController < ApplicationController
  def index
    if !current_user
      redirect_to "/login"
    end      
  end
end