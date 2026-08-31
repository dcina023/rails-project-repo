class SignUpsController < ApplicationController
  before_action :redirect_if_logged_in

  rate_limit to: 10,
             within: 3.minutes,
             only: :create,
             with: -> { redirect_to new_sign_up_path, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: "Welcome! Your account was successfully created."
    else

      render :new, status: :unprocessable_entity
    end
  end

private

  def redirect_if_logged_in
    redirect_to plans_path if logged_in?
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
