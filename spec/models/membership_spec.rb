require 'rails_helper'

describe Membership, type: :model do
  it "may contain administrative clearance" do
    expect(Membership.new).to respond_to(:is_admin)
  end

  it "should be created if given a valid user and client" do
    user = create(:user)
    client = create(:client)
    expect(Membership.create(user: user, client: client)).to be_persisted
  end

  it "should not be created without a user" do
    client = create(:client)
    expect(Membership.create()).not_to be_persisted
  end

  it "should not be created without a client" do
    user = create(:user)
    expect(Membership.create(user: user)).not_to be_persisted
  end
end
