class PlansController < ApplicationController
  before_action :require_user
  load_and_authorize_resource through: :current_user

  def index
    @plans = Plan.all
  end

  def show
    @plan = Plan.find(params[:id])
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
