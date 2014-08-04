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
    let(:new_template) { build(:template, curator: curator) }

    let(:element) { create(:element, template: template) }
    let(:new_element) { build(:element, template: template) }

    subject { Ability.new(keeper) }
    it_behaves_like "curator clearance"
    it { is_expected.not_to be_able_to(:manage, client) }
    it { is_expected.not_to be_able_to(:manage, curator) }
    it { is_expected.not_to be_able_to(:destroy, curator) }

    it { is_expected.not_to be_able_to(:create, new_template) }
    it { is_expected.to be_able_to(:read, template) }
    it { is_expected.not_to be_able_to(:update, template) }
    it { is_expected.not_to be_able_to(:destroy, template) }

    it { is_expected.not_to be_able_to(:create, new_element) }
    it { is_expected.to be_able_to(:read, element) }
    it { is_expected.not_to be_able_to(:update, element) }
    it { is_expected.not_to be_able_to(:destroy, element) }

    context "with administrative privileges" do
      subject { Ability.new(admin_keeper) }
      it_behaves_like "curator clearance"
      it { is_expected.not_to be_able_to(:manage, client) }
      it { is_expected.to be_able_to(:manage, curator) }
      it { is_expected.not_to be_able_to(:destroy, curator) }

      it { is_expected.to be_able_to(:create, new_template) }
      it { is_expected.to be_able_to(:read, template) }
      it { is_expected.to be_able_to(:update, template) }
      it { is_expected.to be_able_to(:destroy, template) }

      it { is_expected.to be_able_to(:create, new_element) }
      it { is_expected.to be_able_to(:read, element) }
      it { is_expected.to be_able_to(:update, element) }
      it { is_expected.to be_able_to(:destroy, element) }
    end
  end
end
