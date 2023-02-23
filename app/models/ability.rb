class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, Recipe, user: user
    can :manage, Food, user: user
    can :read, :all
  end
end
