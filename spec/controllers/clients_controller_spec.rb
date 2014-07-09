require 'rails_helper'

describe ClientsController do
  let(:valid_attributes) { {
    name: 'Acme Corp',
    shortname: 'acme',
    data: '{}'
  } }

  let(:invalid_attributes) { {
    bogus: 'crap'
  } }

  let(:user) {
    User.create(email:'han@alliance.org', password: 'Solo is the name')
  }

  let(:valid_session) { {} }

  before(:all) do
    Client.destroy_all
  end

  describe "GET index" do
    it "assigns all clients as @clients" do
      client = Client.create! valid_attributes
      clients = Client.all

      sign_in :user, user
      get :index, {}, valid_session
      assigns(:clients).should eq([client])
    end
  end

  describe "GET show" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes

      sign_in :user, user
      get :show, {:id => client.to_param}, valid_session
      assigns(:client).should eq(client)
    end
  end

  describe "GET new" do
    it "assigns a new client as @client" do
      sign_in :user, user
      get :new, {}, valid_session
      assigns(:client).should be_a_new(Client)
    end
  end

  describe "GET edit" do
    it "assigns the requested client as @client" do
      client = Client.create! valid_attributes

      sign_in :user, user
      get :edit, {:id => client.to_param}, valid_session
      assigns(:client).should eq(client)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in :user, user
    end

    describe "with valid params" do
      it "creates a new Client" do
        expect {
          post :create, {:client => valid_attributes}, valid_session
        }.to change(Client, :count).by(1)
      end

      it "assigns a newly created client as @client" do
        post :create, {:client => valid_attributes}, valid_session
        assigns(:client).should be_a(Client)
        assigns(:client).should be_persisted
      end

      it "redirects to the created client" do
        post :create, {:client => valid_attributes}, valid_session
        response.should redirect_to(Client.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved client as @client" do
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        post :create, {:client => invalid_attributes}, valid_session
        assigns(:client).should be_a_new(Client)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        post :create, {:client => invalid_attributes}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      sign_in :user, user
    end

    describe "with valid params" do
      it "updates the requested client" do
        client = Client.create! valid_attributes
        Client.any_instance.should_receive(:update).with({ "name" => "Something" })
        put :update, {:id => client.to_param, :client => { "name" => "Something" }}, valid_session
      end

      it "assigns the requested client as @client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
        assigns(:client).should eq(client)
      end

      it "redirects to the client" do
        client = Client.create! valid_attributes
        put :update, {:id => client.to_param, :client => valid_attributes}, valid_session
        response.should redirect_to(client)
      end
    end

    describe "with invalid params" do
      it "assigns the client as @client" do
        client = Client.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
        assigns(:client).should eq(client)
      end

      it "re-renders the 'edit' template" do
        client = Client.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        put :update, {:id => client.to_param, :client => invalid_attributes}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      sign_in :user, user
    end

    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect {
        delete :destroy, {:id => client.to_param}, valid_session
      }.to change(Client, :count).by(-1)
    end

    it "redirects to the clients list" do
      client = Client.create! valid_attributes
      delete :destroy, {:id => client.to_param}, valid_session
      response.should redirect_to(clients_url)
    end
  end

end
