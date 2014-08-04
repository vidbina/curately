require 'rails_helper'

describe Ability, :type => :model do
  let(:guest) { Ability.new(User.new) }
  let(:user) { create(:user) }

  let(:member) { create(:user) }
  let(:admin_member) { create(:user) }

  let(:keeper) { create(:user) }
  let(:admin_keeper) { create(:user) }

  let(:client) { create(:client) }
  let(:inactive_client) { client.update(is_active: false) and client }
  let(:curator) { create(:curator) }
  let(:board) { create(:board, curator: curator, client: client) }
  let(:update) { board.updates.create(attributes_without_id(build(:update))) }
  
  before(:each) do
    create(:curatorship, curator: curator, user: admin_keeper, is_admin: true)
    create(:curatorship, curator: curator, user: keeper, is_admin: false)
    create(:membership, client: client, user: admin_member,  is_admin: true)
    create(:membership, client: client, user: member,  is_admin: false)
  end

  shared_examples "user clearance" do
    it { is_expected.to be_able_to(:create, Curator.new) }
    it { is_expected.to be_able_to(:create, Client.new) }
  end

  context "for guest" do
    subject { guest }
    it { is_expected.not_to be_able_to(:create, Curator.new) }
  end

  subject { Ability.new(user) }

  shared_examples "accessing foreign resources" do
    let(:foreign_board) { create(:board) }
    it { is_expected.not_to be_able_to(:read, board) }
  end
  
  shared_examples "subscriber clearance" do
    it { is_expected.to be_able_to(:read, client) }
    it { is_expected.to be_able_to(:read, board) }
    it { is_expected.to be_able_to(:read, update) }
  end

  shared_examples "non-curative clearance" do
    let(:new_update) { 
      board.updates.build(attributes_without_id(build(:update))) 
    }
    it { is_expected.not_to be_able_to(:update, board) }
    it { is_expected.not_to be_able_to(:destroy, board) }
    it { is_expected.not_to be_able_to(:create, new_update) }
    it { is_expected.not_to be_able_to(:update, update) }
    it { is_expected.not_to be_able_to(:destroy, update) }
  end

  context "for member" do
    subject { Ability.new(member) }
    it_behaves_like "subscriber clearance"
    it_behaves_like "non-curative clearance"
    it { is_expected.not_to be_able_to(:update, client) }
    it { is_expected.not_to be_able_to(:destroy, client) }

    context "with administrative privileges" do
      subject { Ability.new(admin_member) }
      it_behaves_like "subscriber clearance"
      it_behaves_like "non-curative clearance"
      it { is_expected.not_to be_able_to(:curate, client) }
      it { is_expected.to be_able_to(:update, client) }
      it { is_expected.not_to be_able_to(:destroy, client) }
      it { is_expected.to be_able_to(:destroy, inactive_client) }
    end
  end

  shared_examples "curator clearance" do
    let(:curatable_client) { create(:client, curator: curator) }
    it { is_expected.to be_able_to(:read, curatable_client) }
    it { is_expected.to be_able_to(:curate, curatable_client) }
    it { is_expected.to be_able_to(:manage, update) }
    it { is_expected.to be_able_to(:create, board.updates.build) }
  end

  context "for curator" do
    let(:template) { create(:template, curator: curator) }
    subject { Ability.new(keeper) }
    it_behaves_like "curator clearance"
    it { is_expected.not_to be_able_to(:manage, client) }
    it { is_expected.not_to be_able_to(:manage, curator) }
    it { is_expected.not_to be_able_to(:destroy, curator) }

    it { is_expected.to be_able_to(:read, template) }
    it { is_expected.not_to be_able_to(:create, build(:template, curator: curator)) }
    it { is_expected.not_to be_able_to(:update, template) }
    it { is_expected.not_to be_able_to(:destroy, template) }

    context "with administrative privileges" do
      subject { Ability.new(admin_keeper) }
      it_behaves_like "curator clearance"
      it { is_expected.not_to be_able_to(:manage, client) }
      it { is_expected.to be_able_to(:manage, curator) }
      it { is_expected.not_to be_able_to(:destroy, curator) }

      it { is_expected.to be_able_to(:read, template) }
      it { is_expected.to be_able_to(:update, template) }
      it { is_expected.to be_able_to(:create, template) }
      it { is_expected.to be_able_to(:destroy, template) }
    end
  end

#  context "with deteactivated curator" do
#    before(:each) do
#      curator.is_active = false
#      curator.save
#    end
#
#
#  end
#  describe "for curators" do
#    let!(:curatorship) { 
#      create(:curatorship, user: user, curator: curator, is_admin: false) 
#    }
#
#    describe "to remove a curator" do
#      describe "that has been disabled" do
#        before do
#          curator.is_active = false
#          curator.save
#        end
#
#        it "is not available for regular users" do
#          expect(Ability.new(user).can? :destroy, curator).to be(false)
#        end
#
#        it "is only reserved to administrators" do
#          curatorship.is_admin = true
#          curatorship.save
#          expect(Ability.new(user).can? :destroy, curator).to be(true)
#        end
#      end
#    end
#
#    describe "to access template creation form" do
#      it "is available to admins" do
#        curatorship.is_admin = true
#        curatorship.save
#        expect(Ability.new(user).can? :new, Template.new(curator: curator)).to be(true)
#      end
#
#      it "is not available to non-signed in users" do
#        expect(Ability.new(User.new).can? :new, Template.new(curator: curator)).to be(false)
#      end
#    end
#
#    describe "to manage templates" do
#      let(:template) { create(:template, curator: curator) }
#
#      it "does not exist for non-owned templates" do
#        expect(Ability.new(user).can? :manage, template).to be(false)
#      end
#
#      it "does not exist for non-admin" do
#        expect(Ability.new(user).can? :manage, template).to be(false)
#      end
#
#      it "exists for admin" do
#        curatorship.is_admin = true
#        curatorship.save
#        expect(Ability.new(user).can? :manage, template).to be(true)
#      end
#
#      it "exists for new resource" do
#        curatorship.is_admin = true
#        curatorship.save
#        expect(Ability.new(user).can? :manage, Template.new(curator: curatorship.curator)).to be(true)
#      end
#    end
#  end
#
#  describe "for members" do
#    let(:membership) { create(:membership, user: user, client: client) }
#
#    describe "to view client information" do
#      it "exists" do
#        expect(membership).to be_persisted
#        expect(Ability.new(user).can? :read, client).to be(true)
#      end
#    end
#
#    describe "to manage a client" do
#      it "does not exist for non-administrative users" do
#        expect(Ability.new(user).can? :manage, client).to be(false)
#      end
#
#      it "exists for administrators" do
#        membership.is_admin = true
#        membership.save
#        expect(Ability.new(user).can? :manage, client).to be(true)
#      end
#    end
#
#    describe "to update a client" do
#      it "is not available to regular users" do
#        expect(Ability.new(user).can? :update, client).to be(false)
#      end
#
#      it "is reserved to administrators" do
#        membership.is_admin = true
#        membership.save
#        expect(Ability.new(user).can? :update, client).to be(true)
#      end
#    end
#
#    describe "to deactivate a client" do
#      it "is not available to regular users" do
#        expect(Ability.new(user).can? :deactivate, client).to be(false)
#      end
#
#      it "is reserved to administrators only" do
#        membership.is_admin = true
#        membership.save
#        expect(Ability.new(user).can? :deactivate, client).to be(true)
#      end
#    end
#
#    describe "to remove a client" do
#      it "is not available to regular users" do
#        expect(Ability.new(user).can? :destroy, client).to be(false)
#      end
#
#      it "is not even available to administrators" do
#        membership.is_admin = true
#        membership.save
#        expect(Ability.new(user).can? :destroy, client).to be(false)
#      end
#
#      describe "that has been disabled" do
#        before do
#          client.is_active = false
#          client.save
#        end
#
#        it "is not available to regular users" do
#          expect(Ability.new(user).can? :destroy, client).to be(false)
#        end
#
#        it "is only reserved to administrators" do
#          membership.is_admin = true
#          membership.save
#          expect(Ability.new(user).can? :destroy, client).to be(true)
#        end
#      end
#    end
#
#    it "denies the viewing of non-owned boards" do
#      board = create(:board)
#      expect(Ability.new(user).can? :read, board).to be(false)
#    end
#
#    it "allows for the viewing of its boards" do
#      board = create(:board, client: membership.client)
#      expect(Ability.new(user).can? :read, board).to be(true)
#    end
#    
#    it "allows for the viewing of updates" do
#      board = create(:board, client: membership.client)
#      update = board.updates.create(build(:update).attributes)
#      expect(Ability.new(user).can? :read, update).to be(true)
#    end
#
#    it "denies the management of boards" do
#      board = create(:board, client: membership.client)
#      expect(Ability.new(user).can? :manage, board).to be(false)
#    end
#    
#    it "denies the updating of updates" do
#      board = create(:board, client: membership.client)
#      update = board.updates.create(build(:update).attributes)
#      expect(Ability.new(user).can? :update, update).to be(false)
#    end
#    
#    it "denies the removal of updates" do
#      board = create(:board, client: membership.client)
#      update = board.updates.create(build(:update).attributes)
#      expect(Ability.new(user).can? :destroy, update).to be(false)
#    end
#    
#    it "denies the creation of updates" do
#      board = create(:board, client: membership.client)
#      update = board.updates.build(build(:update).attributes)
#      expect(Ability.new(user).can? :create, update).to be(false)
#    end
#  end
#
#  describe "for anyone" do
#    it "to manage a template does not exist" do
#      expect(Ability.new(user).can? :manage, create(:template)).to be(false)
#    end
#
#    describe "to create a client" do
#      it "exists" do
#        client = build(:client)
#        expect(Ability.new(user).can? :create, client).to be(true)
#      end
#    end
#  
#    describe "to modify client information" do
#      it "does not exist" do
#        expect(Ability.new(user).can? :update, client).to be(false)
#      end
#    end
#  
#    
#    describe "to update client information" do
#      it "does not exist" do
#        expect(Ability.new(user).can? :update, client).to be(false)
#      end
#    end
#
#    describe "to read client information" do
#      it "does not exist" do
#        expect(Ability.new(user).can? :read, client).to be(false)
#      end
#    end
#
#    describe "to manage curators" do
#      it "does not exist" do
#        expect(Ability.new(user).can? :manage, curator).to be(false)
#      end
#    end
#
#    describe "to manage clients" do
#      it "does not exist" do
#        expect(Ability.new(user).can? :manage, create(:client, curator: curator)).to be(false)
#      end
#    end
#  end
#
#  describe "for guests" do
#    describe "to manage templates" do
#      it "is disabled" do
#        expect(Ability.new(User.new).can? :manage, Template.new(curator: create(:curator))).to be(false)
#      end
#    end
#
#    describe "to manage stored templates" do
#      it "is disabled" do
#        expect(Ability.new(User.new).can? :manage, curator.template).to be(false)
#      end
#    end
#  end
end
