class HomeController < ApplicationController
  def index
    if current_user.nil?
      redirect_to "/login"
    end
  end
end