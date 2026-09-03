class PlansController < ApplicationController
  before_action :require_user
  load_and_authorize_resource through: :current_user
  def show; end

  def new
    @user = current_user
    @activities = Activity.all
  end

  def create
    if @plan.save
      @plan.assign_random_activities
      redirect_to user_plan_path(current_user, @plan)
    else
      @activities = Activity.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    if @plan.update(plan_params)
      redirect_to user_plan_path(current_user, @plan),
                  notice: "Plan updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plan.destroy
    redirect_to user_path(current_user),
                notice: "Plan was successfully removed."
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
