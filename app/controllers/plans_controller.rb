class PlansController < ApplicationController
  before_action :require_user
  before_action :set_user
  load_and_authorize_resource through: :current_user
  def show; end

  def new
    @activities = Activity.all
  end

  def create
    if @plan.save
      redirect_to user_plan_path(current_user, @plan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

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
      :vibe
    )
  end

  def set_user
    @user = current_user
  end
end
