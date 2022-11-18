class FriendshipsController < ApplicationController
  def create
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    flash[:notice] = "Stopped following #{friendship.first_name}"
    friendship.destroy
    redirect_to my_friends_path
  end
end
