require 'rails_helper'

RSpec.describe Ability, :type => :model do
  before do
    @user = create(:user)
  end

  it "allows curators to modify clients" do
    curator = build(:curator)
    Curatorship.create(user: @user, curator: curator)

    expect(Ability.new(@user).can? :manage, curator).to be(true)
  end

  it "denied non-curators to modify clients" do
    curator = build(:curator)
    expect(Ability.new(@user).can? :manage, curator).to be(false)
  end

  it "allows members to view client data" do
    client = build(:client)
    Membership.create(user: @user, client: client)

    expect(Ability.new(@user).can? :read, client).to be(true)
  end

  it "denied non-members to view client data" do
    client = build(:client)
    expect(Ability.new(@user).can? :read, client).to be(false)
  end
end
