require 'rails_helper'

describe Update do
  let(:board)   { create(:board) }

  before(:each) do
    create(:element, template: board.curator.template, name: 'a')
    create(:element, template: board.curator.template, name: 'b')
    create(:element, template: board.curator.template, name: 'c')
  end

  it "needs at least one field set to be valid" do
    expect(board.updates.new()).to be_invalid
  end

  it "is invalid if a unknown field is set" do
    expect(board.updates.new(d: 'hello', c: 'ha')).to be_invalid
  end

  it "is valid if some elements are set" do
    expect(board.updates.new(a: 'test')).to be_valid
  end

  it "is persisted when valid" do
    expect(board.updates.create(a: 12, b: 23)).to be_persisted
  end
end
