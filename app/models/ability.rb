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
      if curator.new_record?
        true
      else
        curator_admin(user, curator)
      end
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
      if user.new_record?
        false
      else
        false
        unless curator.is_active == false
          curator_admin(user, curator)
        end
      end
    end

    can :manage, Template do |template|
      if user.new_record?
        false
      else
        if template.new_record?
          true
        else
          curator = Curator.all.where(template_id: template.id.to_binary).first
          if curator
            !curator.curatorships.empty?
          else
            false
          end
        end
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
