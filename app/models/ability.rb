class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Client do |client|
      !user.memberships(client: client).empty?
    end

    can :manage, Client do |client|
      #p user.curatorships(curator: client.curator, is_admin: true)
      curator_admin = !user.curatorships(
        curator: client.curator, 
        is_admin: true
      ).empty?

      member_admin = !user.memberships(
        client: client,
        is_admin: true
      ).empty?

      curator_admin || member_admin
    end

    can :manage, Curator do |curator|
      # TODO: don't make all curators managers
      !user.curatorships(curator: curator, is_admin: true).empty?
    end

    can :create, Client
    can :update, Client do |client|
      !user.memberships(client: client, is_admin: true).empty?
    end

    cannot :destroy, Client
    cannot :destroy, Curator
  end
end
