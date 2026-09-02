class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :read, User, id: user.id
    can :manage, Plan, user_id: user.id
    can :read, Activity
    can :manage, PlanActivity, plan: { user_id: user.id }
  end
end

## cancancan gem - gives ability to centralize authorization rules.
