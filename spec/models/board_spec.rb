require 'rails_helper'

describe Board, :type => :model do
  it "belongs to a curator" do
    expect {
      create(:board, curator: nil)
    }.to raise_error
  end

  it "belongs to a client" do
    expect {
      create(:board, client: nil)
    }.to raise_error
  end

  it "is saved as long as it has a client and curator" do
    expect {
      board = create(:board)
    }.not_to raise_error
  end

  it "is not saved if the curator does not exist" do
    expect {
      create(:board, curator: build(:curator))
    }.to raise_error
  end

  it "is not saved if the client does not exist" do
    expect {
      create(:board, client: build(:client))
    }.to raise_error
  end

  it "returns the client upon request" do
    client = create(:client)
    expect(create(:board, client: client).client).to eq(client)
  end

  it "returns the curator upon request" do
    curator = create(:curator)
    expect(create(:board, curator: curator).curator).to eq(curator)
  end

  it "bases its available elements on the curator's template fields" do
    curator = create(:curator)
    board = create(:board, curator: curator)

    expect {
      3.times { create(:element, template: curator.template) }
    }.to change { board.reload.elements.count }.by(3)
  end
end
