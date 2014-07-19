require 'rails_helper'

describe Ability, :type => :model do
  before do
    @user = create(:user)
  end

  let(:client) { build(:client) }
  let(:curator) { build(:curator) }

  it "denied non-curators to modify clients" do
    expect(Ability.new(@user).can? :manage, curator).to be(false)
    expect(Ability.new(@user).can? :manage, create(:client, curator: curator)).to be(false)
  end

  describe "for curators" do
    before(:each) do
      Curatorship.create(user: @user, curator: curator)
    end

    describe "to manage clients" do
      it "exists" do
        expect(Ability.new(@user).can? :manage, curator).to be(true)
        expect(Ability.new(@user).can? :manage, create(:client, curator: curator)).to be(true)
      end
    end
  end

  describe "for members" do
    before(:each) do
      Membership.create(user: @user, client: client)
    end

    describe "to view client information" do
      it "exists" do
        expect(Ability.new(@user).can? :read, client).to be(true)
      end
    end
  end

  describe "for anyone" do
    describe "to create a client" do
      it "exists" do
        client = build(:client)
        expect(Ability.new(@user).can? :create, client).to be(true)
      end
    end
  
    describe "to modify client information" do
      it "does not exist" do
        expect(Ability.new(@user).can? :update, client).to be(false)
      end
    end
  
    
    describe "to update client information" do
      it "does not exist" do
        expect(Ability.new(@user).can? :update, client).to be(false)
      end
    end

    describe "to read client information" do
      it "does not exist" do
        expect(Ability.new(@user).can? :read, client).to be(false)
      end
    end

    describe "to manage clients" do
      it "does not exist" do
        expect(Ability.new(@user).can? :manage, curator).to be(false)
        expect(Ability.new(@user).can? :manage, create(:client, curator: curator)).to be(false)
      end
    end
  end
end
