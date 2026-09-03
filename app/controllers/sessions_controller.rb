class SessionsController < ApplicationController
  def home; end

  def login; end

  def create
    user = User.find_by(email: params[:email].downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(current_user), notice: "Welcome back!"
    else
      flash.now[:alert] = "Invalid email or password combination."
      render :home, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end
end