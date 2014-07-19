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
    end

    it "should be aware of its membership" do
      expect {
        @membership = create(:membership, user: @user)
      }.to change(@user.memberships, :count).by(1)
    end

    it "should accept other memberships" do
      expect {
        @user.memberships << build(:membership)
      }.to change(Membership, :count).by(1)
    end

    it "removes memberships upon user removal" do
      count = rand(1..10)
      count.times { create(:membership, user: @user) }
      expect {
        @user.destroy
      }.to change(Membership, :count).by(-count)
    end
  end

  describe "being a curator" do
    before(:each) do
      @user = create(:user)
    end

    it "should be aware of its curatorships" do
      expect {
        @curatorship = create(:curatorship, user: @user)
      }.to change(@user.curatorships, :count).by(1)
    end

    it "should accept other curatorships" do
      expect {
        @user.curatorships << build(:curatorship)
      }.to change(Curatorship, :count).by(1)
    end

    it "removes curatorship upon user removal" do
      count = rand(1..10)
      count.times { create(:curatorship, user: @user) }
      expect {
        @user.destroy
      }.to change(Curatorship, :count).by(-count)
    end
  end
end
