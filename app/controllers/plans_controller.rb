class PlansController < ApplicationController
  before_action :require_user
  load_and_authorize_resource through: :current_user

  def index
    @plans = Plan.all
  end

  def show
    @user = User.find(params[:user_id])
    @plan = @user.plans.find(params[:id])
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
  end

private

  def plan_params
    params.require(:plan).permit(
      :title,
      :location,
      :budget,
      :vibe,
      :user_id
    )
  end
end

## remember - load_and_authorize_resource is a method provided from cancancan gem
## load a controller's resource and checks it against rules definied in Ability.rb
## through: :current_user - is a way to scope Plan records used by the controller actions through current_user
## can*3 - the users plans are loaded through the association - current_user.plans
## then can*3 checks the loaded plan against the rules in Ability.rb
