class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "You are now following #{friend.full_name}"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to my_friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friend = User.find(params[:id])
    flash[:notice] = "Stopped following #{friend.full_name}"
    friendship.destroy
    friend.destroy
    redirect_to my_friends_path
  end
end
