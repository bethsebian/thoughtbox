class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to links_path, success: "Welcome!"
    else
      flash[:notice] = "The username or password is invalid. Please try again."
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to login_path, success: "You have been logged out."
  end

end