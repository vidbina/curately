require 'rails_helper'

describe Curatorship, type: :model do
  it "may contain administrative clearance" do
    expect(Curatorship.new).to respond_to(:is_admin)
  end

  it "should be created if given a valid user and curator" do
    user = create(:user)
    curator = create(:curator)
    expect(Curatorship.create(user: user, curator: curator)).to be_persisted
  end

  it "should not be created without a user" do
    curator = create(:curator)
    expect(Curatorship.create()).not_to be_persisted
  end

  it "should not be created without an curator" do
    user = create(:user)
    expect(Curatorship.create(user: user)).not_to be_persisted
  end
end
