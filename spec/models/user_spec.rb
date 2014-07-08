require 'spec_helper'

describe User do
  let(:valid_attributes) { {
    email: 'yoda@jedi.org',
    password: 'Entry, I request'
  } }

  it "It is saved is valid" do
    expect {
      User.create(valid_attributes).should be_persisted
    }.to change(User, :count).by(1)
  end
end
