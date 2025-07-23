class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], status: "pending")
    if @friendship.save
      redirect_to users_path, notice: "Friend request sent"
    else
      redirect_to users_path, alert: "Something went wrong"
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.friend == current_user
      @friendship.update(status: params[:status])
      redirect_to users_path, notice: "Friend request updated"
    else
      redirect_to users_path, alert: "Unauthorized"
    end
  end
end
