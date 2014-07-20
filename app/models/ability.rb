class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Client do |client|
      !user.memberships.where(client: client).empty?
    end

    can :manage, Client do |client|
      curator_admin(user, client.curator) || member_admin(user, client)
    end

    can :manage, Curator do |curator|
      # TODO: don't make all curators managers
      !user.curatorships.where(curator: curator, is_admin: true).empty?
    end

    can :create, Client

    can :update, Client do |client|
      member_admin(user, client)
    end

    can :curate, Client do |client|
      if client.curator
        !user.curatorships.where(curator: client.curator).empty?
      else
        false
      end
    end

    cannot :destroy, Client do |client|
      unless client.is_active == false
        member_admin(user, client)
      end
    end

    cannot :destroy, Curator do |curator|
      unless curator.is_active == false
        curator_admin(user, curator)
      end
    end
  end
  
  private
  def member_admin(user, client)
    !user.memberships.where(client: client, is_admin: true).empty?
  end

  def curator_admin(user, curator)
    !user.curatorships.where(curator: curator, is_admin: true).empty?
  end
end
