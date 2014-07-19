require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CuratorsController do

  # This should return the minimal set of attributes required to create a valid
  # Curator. As you add validations to Curator, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { 
    "name" => "ABCTotaal",
    "shortname" => "abctotaal",
  } }

  let(:user) {
    User.create(email: 'spock@starfleet.org', password: 'Clearly observed!')
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CuratorsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    Curator.destroy_all
  end

  describe "GET index" do
    it "assigns all curators as @curators" do
      curator = Curator.create! valid_attributes

      sign_in :user, user
      get :index, {}, valid_session
      expect(assigns(:curators)).to eq([curator])
    end
  end

  describe "GET show" do
    it "assigns the requested curator as @curator" do
      curator = Curator.create! valid_attributes
      get :show, {:id => curator.to_param}, valid_session
      expect(assigns(:curator)).to eq(curator)
    end
  end

  describe "GET new" do
    it "assigns a new curator as @curator" do
      get :new, {}, valid_session
      expect(assigns(:curator)).to be_a_new(Curator)
    end
  end

  describe "GET edit" do
    it "assigns the requested curator as @curator" do
      curator = Curator.create! valid_attributes

      sign_in :user, user
      get :edit, {:id => curator.to_param}, valid_session
      expect(assigns(:curator)).to eq(curator)
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in :user, user
    end

    describe "with valid params" do
      it "creates a new Curator" do
        expect {
          post :create, {:curator => valid_attributes}, valid_session
        }.to change(Curator, :count).by(1)
      end

      it "assigns a newly created curator as @curator" do
        post :create, {:curator => valid_attributes}, valid_session
        expect(assigns(:curator)).to be_persisted
      end

      it "redirects to the created curator" do
        post :create, {:curator => valid_attributes}, valid_session
        expect(response).to redirect_to(Curator.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved curator as @curator" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Curator)).to receive(:save).and_return(false)
        post :create, {:curator => { "name" => "invalid value" }}, valid_session
        expect(assigns(:curator)).to be_a_new(Curator)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Curator)).to receive(:save).and_return(false)
        post :create, {:curator => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      sign_in :user, user
    end

    describe "with valid params" do
      it "updates the requested curator" do
        curator = Curator.create! valid_attributes
        # Assuming there are no other curators in the database, this
        # specifies that the Curator created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Curator).to receive(:update).with({ "name" => "MyString" })
        put :update, {:id => curator.to_param, :curator => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested curator as @curator" do
        curator = Curator.create! valid_attributes
        put :update, {:id => curator.to_param, :curator => valid_attributes}, valid_session
        expect(assigns(:curator)).to eq(curator)
      end

      it "redirects to the curator" do
        curator = Curator.create! valid_attributes
        put :update, {:id => curator.to_param, :curator => valid_attributes}, valid_session
        expect(response).to redirect_to(curator)
      end
    end

    describe "with invalid params" do
      it "assigns the curator as @curator" do
        curator = Curator.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Curator)).to receive(:save).and_return(false)
        put :update, {:id => curator.to_param, :curator => { "name" => "" }}, valid_session
        expect(assigns(:curator)).to eq(curator)
      end

      it "re-renders the 'edit' template" do
        curator = Curator.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow(instance_double(Curator)).to receive(:save).and_return(false)
        put :update, {:id => curator.to_param, :curator => { "name" => "" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      sign_in :user, user
    end

    it "destroys the requested curator" do
      curator = Curator.create! valid_attributes
      expect {
        delete :destroy, {:id => curator.to_param}, valid_session
      }.to change(Curator, :count).by(-1)
    end

    it "redirects to the curators list" do
      curator = Curator.create! valid_attributes
      delete :destroy, {:id => curator.to_param}, valid_session
      expect(response).to redirect_to(curators_url)
    end
  end

end
