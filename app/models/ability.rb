class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Client do |client|
      !user.memberships.where(client: client).empty?
    end

    can :manage, Client do |client|
      curator_admin(user, client.curator) || member_admin(user, client)
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

    can :manage, Curator do |curator|
      if curator.new_record?
        true
      else
        curator_admin(user, curator)
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

    can :read, Board do |board|
      is_member = !user.memberships.where(client: board.client).empty?
      is_curator = !user.curatorships.where(curator: board.curator).empty?

      false
      true if (is_member or is_curator)
    end

    can :manage, Board do |board|
      is_curator = !user.curatorships.where(curator: board.curator).empty?
      false or true if is_curator
    end

    can :read, Update do |update|
      false or (true if can? :read, update.board)
    end

    can :manage, Update do |update|
      false or (true if can? :manage, update.board)
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
