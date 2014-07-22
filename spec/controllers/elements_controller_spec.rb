require 'rails_helper'

describe ElementsController, :type => :controller do
  let(:curatorship) { create(:curatorship) }
  let(:request_params) { 
    { curator_id: curatorship.curator.id }
  }
  let(:element) { create(:element, template: curatorship.curator.template) }
  
  before(:context) do
    Template.destroy_all
  end

  describe "GET index" do
    it "returns all elements for the template" do
      2.times { create(:element, template: curatorship.curator.template) }
      get :index, request_params
      expect(assigns(:elements)).to match_array(curatorship.curator.template.elements)
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
      p request.url
      expect(assigns(:element)).to be_a_new(Element)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      request_params[:id] = element.id
      get :edit, request_params
      expect(response).to have_http_status(:success)
    end

    it "offers the existing element for modification" do
      request_params[:id] = element.id
      get :edit, request_params
      expect(assigns(:element)).to be_a_new(Element)
    end
  end

  describe "POST create" do
    it "creates the resource upon submission" do
      request_params[:element] = build(:element).attributes
      post :create, request_params
      expect(Element).to receive(:create)
    end
  end

  describe "PUT update" do
    it "performs the update" do
      request_params[:id] = element.id
      request_params[:element] = build(:element).attributes
      put :update, request_params
      expect_any_instance_of(Element).to receive(:update)
    end
  end

  describe "DELETE destroy" do
    it "removes the element" do
      request_params[:id] = element.id
      delete :destroy, request_params
      expect_any_instance_of(Element).to receive(:destroy)
    end
  end

end
