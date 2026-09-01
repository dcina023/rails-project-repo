class SignUpsController < ApplicationController
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
      redirect_to root_path,
                  notice: "Welcome! Your account was successfully created. Please log in."
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def sign_up_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
## remember - setting a rate specificially with the create action is setting the number of requests
## that are allowed with a specific time -- 3 mins. Additional attempts are redirected with an alert.
## doesn't replace validations, authentication, or authorization.
