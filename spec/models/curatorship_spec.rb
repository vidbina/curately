require 'rails_helper'

RSpec.describe Curatorship, :type => :model do
  it "should be created if given a valid user and accountant" do
    user = create(:user)
    accountant = create(:accountant)
    expect(Curatorship.create(user: user, accountant: accountant)).to be_persisted
  end

  it "should not be created without a user" do
    accountant = create(:accountant)
    expect(Curatorship.create()).not_to be_persisted
  end

  it "should not be created without an accountant" do
    user = create(:user)
    expect(Curatorship.create(user: user)).not_to be_persisted
  end
end
