class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else
      can :manage, Recipe, author: user
      can :manage, Food, author: user
      can :read, :all
    end
  end
end
