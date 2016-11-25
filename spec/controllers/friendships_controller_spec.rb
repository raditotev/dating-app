require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = create(:user)
    sign_in @current_user
  end

  # let(:valid_attributes) {
  #     friend_id: create(:user)
  # }

  let(:invalid_attributes) {
    { friend_id: nil }
  }

  let(:valid_session) { {} }

  describe "Friendship #create" do
    context "with valid params" do
      it "creates a new Friendship" do
        another_user = create(:user)
        expect{
          post :create, params: {friendship: {friend_id: another_user.id}}, session: valid_session
        }.to change(@current_user.friendships, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        another_user = create(:user)
        post :create, params: {friendship: {friend_id: another_user.id}}, session: valid_session
        expect(assigns(:friendship)).to be_a(Friendship)
        expect(assigns(:friendship)).to be_persisted
      end

      it "redirects to root_url when params[:redirect_me] not set" do
        another_user = create(:user)
        post :create, params: {friendship: {friend_id: another_user.id}}, session: valid_session
        expect(response).to redirect_to(root_url)
      end

    it "redirects to given when params[:redirect_me] set" do
        another_user = create(:user)
        post :create, params: {friendship: {friend_id: another_user.id}, redirect_me: users_path}, session: valid_session
        expect(response).to redirect_to(users_path)
      end
    end

    context "with invalid params" do
      it "raises an error" do
        expect{
          post :create, params: { friendship: invalid_attributes }, session: valid_session
          }.to raise_error(RuntimeError)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested friendship" do
        friendship = create(:friendship)
        expect {
          delete :destroy, params: {id: friendship.to_param}, session: valid_session
        }.to change(Friendship, :count).by(-2) # destroys reverse friendship
      end

      it "redirects to the root_url when params[:redirect_me] not provided" do
        friendship = create(:friendship)
        delete :destroy, params: {id: friendship.to_param}, session: valid_session
        expect(response).to redirect_to(root_url)
      end

       it "redirects to the given path when params[:redirect_me] set" do
        friendship = create(:friendship)
        delete :destroy, params: {id: friendship.to_param, redirect_me: users_path}, session: valid_session
        expect(response).to redirect_to(users_path)
      end
  end
end
