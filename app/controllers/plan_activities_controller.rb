class PlanActivitiesController < ApplicationController
  before_action :require_user
  before_action :set_plan_activity
  load_and_authorize_resource

  def edit; end

  def update
    if @plan_activity.update(plan_activity_params)
      redirect_to user_plan_path(current_user, @plan_activity.plan),
                  notice: "Activity details updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

private

  def set_plan_activity
    @plan_activity = PlanActivity
                     .joins(:plan)
                     .where(plans: { user_id: current_user.id })
                     .find(params[:id])
  end

  def plan_activity_params
    params.require(:plan_activity).permit(:notes, :rating)
  end
end
