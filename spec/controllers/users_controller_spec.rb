require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = create(:user)
    sign_in @current_user
  end

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all users as @users" do
      another_user = create(:user, name: "Another User")
      get :index, params: {}, session: valid_session
      expect(assigns(:users)).to eq([@current_user, another_user])
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user = create(:user)
      get :show, params: {id: user.to_param}, session: valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

end
