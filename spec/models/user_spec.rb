require 'rails_helper'

describe User do
  let(:valid_attributes) { {
    email: 'yoda@jedi.org',
    password: 'Entry, I request'
  } }

  it "It is saved is valid" do
    expect {
      User.create(valid_attributes)
    }.to change(User, :count).by(1)
  end

  it "has memberships" do
    expect(User.new).to respond_to(:memberships)
  end

  it "has curatorships" do
    expect(User.new).to respond_to(:curatorships)
  end

  describe "being a member" do
    before(:each) do
      @user = create(:user)
      @membership = create(:membership, user: @user)
    end

    it "should be aware of its membership" do
      expect(@user.memberships).to contain_exactly(@membership)
    end

    it "should accept other memberships" do
      expect {
        @user.memberships << build(:membership)
      }.to change(Membership, :count).by(1)
    end

    it "removes membership upon user removal" do
      expect {
        @user.destroy
      }.to change(Membership, :count).by(-1)
    end
  end
end
