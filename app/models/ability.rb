class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Client do |client|
      !user.memberships(client: client).empty?
    end

    can :manage, Client do |client|
      !user.curatorships(curator: client.curator).empty?
    end

    can :manage, Curator do |curator|
      # TODO: don't make all curators managers
      !user.curatorships(curator: curator).empty?
    end

    can :create, Client
    can :update, Client do |client|
      !user.memberships(client: client).empty?
    end
  end
end
