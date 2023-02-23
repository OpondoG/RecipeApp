class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can(:manage, Recipe, user:)
    can(:manage, Food, user:)
    can :read, :all
  end
end
