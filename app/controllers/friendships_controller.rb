class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friendship_params)
    @redirect_me = params[:redirect_me] || root_url
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @redirect_me, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        raise @friendship.errors.inspect
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    @redirect_me = params[:redirect_me] || root_url
    respond_to do |format|
      format.html { redirect_to @redirect_me, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def friendship_params
      params.require(:friendship).permit(:friend_id)
    end
end
