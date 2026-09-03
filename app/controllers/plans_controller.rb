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

  def edit
    @user = User.find(params[:user_id])
    @plan = @user.plans.find(params[:id])
  end

  def update
    if @plan.update(plan_params)
      redirect_to user_plan_path, notice: "Plan updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @plan = @user.plans.find(params[:id])

    @plan.destroy
    redirect_to user_path(@user), notice: "Plan was successfully removed."
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
