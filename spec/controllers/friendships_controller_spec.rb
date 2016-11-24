require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = create(:user)
    @another_user = create(:user)
    sign_in @current_user
  end

  let(:valid_attributes) {
    { friend_id: @another_user.id }
  }

  # let(:invalid_attributes) {
  #   { friend_id: nil }
  # }

  let(:valid_session) { {} }

  # describe "Friendship #create" do
  #   context "with valid params" do
  #     it "creates a new Friendship" do
  #       @friendship = @current_user.friendships.new
  #       expect{
  #         post :create, params: {friendship: valid_attributes}, session: valid_session
  #       }.to change(Friendship, :count).by(1)
  #     end

  #     it "assigns a newly created post as @post" do
  #       post :create, params: {post: valid_attributes}, session: valid_session
  #       expect(assigns(:post)).to be_a(Post)
  #       expect(assigns(:post)).to be_persisted
  #     end

  #     it "redirects to the created post" do
  #       post :create, params: {post: valid_attributes}, session: valid_session
  #       expect(response).to redirect_to(Post.last)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved post as @post" do
  #       post :create, params: {post: invalid_attributes}, session: valid_session
  #       expect(assigns(:post)).to be_a_new(Post)
  #     end

  #     it "re-renders the 'new' template" do
  #       post :create, params: {post: invalid_attributes}, session: valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end

  describe "DELETE #destroy" do
    it "destroys the requested friendship" do
        friendship = create(:friendship)
        expect {
          delete :destroy, params: {friend_id: friendship.to_param}, session: valid_session
        }.to change(Friendship, :count).by(-1)
      end

      it "redirects to the posts list" do
        post = @current_user.posts.create(valid_attributes)
        delete :destroy, params: {id: post.to_param}, session: valid_session
        expect(response).to redirect_to(posts_url)
      end
  end

  # describe "POST #create" do
  #   it "returns http success" do
  #     post :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
