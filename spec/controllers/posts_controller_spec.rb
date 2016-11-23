require 'rails_helper'



RSpec.describe PostsController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = create(:user)
    sign_in @current_user
  end

  let(:valid_attributes) {
    attributes_for(:post, author_id: @current_user.id)
  }

  let(:invalid_attributes) {
    attributes_for(:post, title: nil, body: nil)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all posts as @posts" do
      friend = create(:user)
      @current_user.friendships.create(friend: friend)
      friend.posts.create(attributes_for(:post))

      get :index, params: {}, session: valid_session
      expect(assigns(:posts)).to eq(friend.posts)
    end
  end

  describe "GET #show" do
    it "assigns the requested post as @post" do
      post = create(:post)
      get :show, params: {id: post.to_param}, session: valid_session
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET #new" do
    it "assigns a new post as @post" do
      get :new, params: {}, session: valid_session
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "GET #edit" do
    context "when current user is owner of post" do
      it "assigns the requested post as @post" do
        post = @current_user.posts.create(attributes_for(:post))
        get :edit, params: {id: post.to_param}, session: valid_session
        expect(assigns(:post)).to eq(post)
      end
    end

    context "when current user isn't the owner" do
      it "redirects to root url" do
        another_user = create(:user)
        post = another_user.posts.create(attributes_for(:post))
        get :edit, params: {id: post.to_param}, session: valid_session
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect{
          post :create, params: {post: valid_attributes}, session: valid_session
        }.to change(@current_user.posts, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, params: {post: valid_attributes}, session: valid_session
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to the created post" do
        post :create, params: {post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Post.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        post :create, params: {post: invalid_attributes}, session: valid_session
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        post :create, params: {post: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:post, title: "New Title")
      }

      it "updates the requested post" do
        post = Post.create! valid_attributes
        put :update, params: {id: post.to_param, post: new_attributes}, session: valid_session
        post.reload
        expect(assigns(:post).title).to eq(post.title)
      end

      it "assigns the requested post as @post" do
        post = Post.create! valid_attributes
        put :update, params: {id: post.to_param, post: valid_attributes}, session: valid_session
        expect(assigns(:post)).to eq(post)
      end

      it "redirects to the post" do
        post = Post.create! valid_attributes
        put :update, params: {id: post.to_param, post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid params" do
      it "assigns the post as @post" do
        post = Post.create! valid_attributes
        put :update, params: {id: post.to_param, post: invalid_attributes}, session: valid_session
        expect(assigns(:post)).to eq(post)
      end

      it "re-renders the 'edit' template" do
        post = Post.create! valid_attributes
        put :update, params: {id: post.to_param, post: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, params: {id: post.to_param}, session: valid_session
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete :destroy, params: {id: post.to_param}, session: valid_session
      expect(response).to redirect_to(posts_url)
    end
  end

end
