class Ability
  include CanCan::Ability

  def initialize(user)
    #user ||= User.new
    return unless user
    @user = user

    can :read, Client do |client|
      is_member_of?(client) || is_curator_of?(client.curator)
      #!user.memberships.where(client: client).empty?
    end

    can :create, Client
    can :update, Client do |client|
      is_member_of? client, is_admin: true
    end

    can :destroy, Client do |client|
      (is_member_of? client, is_admin: true) if client.is_active == false
    end

    can :curate, Client do |client|
      (client.curator && is_curator_of?(client.curator))
    end

    can :manage, Curator do |curator|
      if user.new_record?
        false
      else
        if curator.new_record?
          true
        else
          is_curator_of? curator, is_admin: true
          #curator_admin(user, curator)
        end
      end
    end

    cannot :destroy, Curator do |curator|
      if user.new_record?
        false
      else
        false
        unless curator.is_active == false
          is_curator_of? curator, is_admin: true
          #curator_admin(user, curator)
        end
      end
    end

    can :manage, Template do |template|
      false or (can?(:manage, template.curator) if template.curator)
    end

    can :read, Template do |template|
      (is_curator_of? template.curator) if template.curator
    end

    can :create, Template do |template|
      (is_curator_of? template.curator, is_admin: true) if template.curator
    end

    can :manage, Element do |element|
      false or (can?(:manage, element.template) if element.template)
    end

    can :read, Element do |element|
      false or (can?(:read, element.template) if element.template)
    end

    can :manage, Board do |board|
      false or (true if is_curator_of? board.curator)
    end

    can :read, Board do |board|
      false
      true if (is_member_of?(board.client) or is_curator_of?(board.curator))
    end

    can :manage, Update do |update|
      false or (true if can? :manage, update.board)
    end

    can :read, Update do |update|
      false or (true if can? :read, update.board)
    end
  end
  
  private
  def is_curator_of?(curator, params={})
    !@user.curatorships.where(params.merge(curator: curator)).empty? if @user
  end

  def is_member_of?(client, params={})
    !@user.memberships.where(params.merge(client: client)).empty? if @user
  end
end
