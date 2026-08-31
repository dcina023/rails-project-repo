class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)

    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back!"
    else
      flash.now[:alert] = "Invalid email or password combination." 
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully."
  end
end