require 'rails_helper'

describe "curators/show" do
  before(:context) do
    Template.destroy_all
  end

  before(:each) do
    @curator = assign(
      :curator, 
      stub_model(Curator, attributes_without_id(build(:curator)))
    )
  end

  it "renders attributes" do
    render

    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Shortname/)
  end

  it "renders template if applicable" do
    skip
    #curatorship = create(:curatorship, user: create(:user), curator: @curator)
    @curator.template = stub_model(Template, attributes_without_id(build(:template)))
    #sign_in :user, curatorship.user

    render
    expect(rendered).to match(/Template/)
  end
end
