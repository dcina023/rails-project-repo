class UsersController < ApplicationController
  before_action :require_user
  load_and_authorize_resource
  def show
    @user = User.find(params[:id])
    @plans = @user.plans
  end
end
