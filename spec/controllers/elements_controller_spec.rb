require 'rails_helper'

describe ElementsController, :type => :controller do
  let(:curator) { create(:curator, template: nil) }
  let(:template) { create(:template, curator: curator) }
  before(:each) {
    curator.template = template
    curator.save
  }
  let(:curatorship) { create(:curatorship, is_admin: true, curator: curator) }
  let(:request_params) { 
    { curator_id: curatorship.curator.id }
  }
  let(:element) { create(:element, template: template) }
  
  before(:context) do
    Template.destroy_all
  end

  before(:example) do
    sign_in :user, curatorship.user
  end

  describe "GET index" do
    it "returns all elements for the template" do
      2.times { create(:element, template: template) }
      get :index, request_params
      expect(assigns(:elements)).to match_array(template.elements)
    end
  end

  describe "GET show" do
    it "shows the element details" do
      request_params[:id] = element.id
      get :show, request_params
      expect(assigns(:element)).to eq(element)
    end
  end

  describe "GET new" do
    it "prepared a new element" do
      get :new, request_params
      expect(assigns(:element)).to be_a_new(Element)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      skip # only for json requests TODO: copy to request specs
      request_params[:id] = element.id
      get :edit, request_params
      expect(response).to have_http_status(:success)
    end

    it "offers the existing element for modification" do
      request_params[:id] = element.id
      get :edit, request_params
      expect(assigns(:element)).to eq(element)
    end
  end

  describe "POST create" do
    it "creates the resource upon submission" do
      expect { 
        request_params[:element] = build(:element, template: curatorship.curator.template).attributes
        post :create, request_params
      }.to change{template.reload.elements.count}.by(1)
    end
  end

  describe "PUT update" do
    it "performs the update" do
      request_params[:id] = element.id
      request_params[:element] = { name: 'Spock' }
      expect {
        put :update, request_params
        element.reload
      }.to change(element, :name).to(request_params[:element][:name])
    end
  end

  describe "DELETE destroy" do
    it "removes the element" do
      request_params[:id] = element.id
      expect {
        delete :destroy, request_params
      }.to change{curatorship.curator.template.reload.elements.count}.by(-1)
    end
  end

end
