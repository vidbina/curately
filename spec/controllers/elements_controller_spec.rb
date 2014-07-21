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
    it "returns http success" do
      get :index, request_params
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "returns http success" do
      request_params[:id] = element.id
      get :show, request_params
      expect(response).to be_success
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new, request_params
      expect(response).to be_success
    end
  end

  describe "GET edit" do
    it "returns http success" do
      request_params[:id] = element.id
      get :edit, request_params
      expect(response).to be_success
    end
  end

  describe "POST create" do
    it "returns http success" do
      post :create, request_params
      expect(response).to be_success
    end
  end

  describe "PUT update" do
    it "returns http success" do
      request_params[:id] = element.id
      put :update, request_params
      expect(response).to be_success
    end
  end

  describe "DELETE destroy" do
    it "returns http success" do
      request_params[:id] = element.id
      delete :destroy, request_params
      expect(response).to be_success
    end
  end

end
