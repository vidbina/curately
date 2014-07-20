class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Client do |client|
      !user.memberships.where(client: client).empty?
    end

    can :manage, Client do |client|
      curator_admin = !user.curatorships.where(
        curator: client.curator, 
        is_admin: true
      ).empty?

      member_admin = !user.memberships.where(
        client: client,
        is_admin: true
      ).empty?

      curator_admin || member_admin
    end

    can :manage, Curator do |curator|
      # TODO: don't make all curators managers
      !user.curatorships.where(curator: curator, is_admin: true).empty?
    end

    can :create, Client

    can :update, Client do |client|
      !user.memberships.where(client: client, is_admin: true).empty?
    end

    can :curate, Client do |client|
      if client.curator
        !user.curatorships.where(curator: client.curator).empty?
      else
        false
      end
    end

    cannot :destroy, Client
    cannot :destroy, Curator
  end
end
