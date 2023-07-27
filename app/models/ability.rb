class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new

    can :read, Post, public: true
    can :read, Comment, public: true
    can :read, Like, public: true

    return unless user.present?  # additional permissions for logged in users (they can read their own posts)
    can :manage, Post, author: user
    can :manage, Comment, author: user
    can :create, Like, author: user

    return unless user.is?(:admin)  # additional permissions for administrators
    can :manage, Post, user: user
    can :manage, Comment, user: user
    can :create, Like, user: user

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
