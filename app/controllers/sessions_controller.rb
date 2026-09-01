class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:login][:email].downcase)

    if user&.authenticate(params[:login][:password])
      session[:user_id] = user.id
      redirect_to user_path(current_user), notice: "Welcome back!"
    else
      flash.now[:alert] = "Invalid email or password combination."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end
end

## remember - authenticate is a Rails method added to the model by has_secure_password
## It uses BCrypt to compare the submitted password with the hashed password stored in the user password_digest column
## It returns the User object when the password matches
# Or false when the password does not match
