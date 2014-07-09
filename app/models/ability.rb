class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Client do |client|
      !user.memberships(client: client).empty?
    end

    can :manage, Client do |client|
      !client.curatorships(user: user).empty?
    end

    can :manage, Curator do |curator|
      # TODO: don't make all curators managers
      !user.curatorships(curator: curator).empty?
    end
  end
end
