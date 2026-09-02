class PlansController < ApplicationController
  before_action :require_user
  load_and_authorize_resource through: :current_user

  def show
    @user = User.find(params[:user_id])
    @plan = @user.plans.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @plan = @user.plans.new
    @activities = Activity.all
  end

  def create
    @user = User.find(params[:user_id])
    @plan = @user.plans.new(plan_params)

    if @plan.save
      @plan.add_random_activities(3)
      redirect_to user_plan_path(@user, @plan)
    else
      @activities = Activity.all
      render :new, status: :unprocessable_entity
    end
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
