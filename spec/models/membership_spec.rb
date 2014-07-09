require 'spec_helper'

describe Membership do
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
