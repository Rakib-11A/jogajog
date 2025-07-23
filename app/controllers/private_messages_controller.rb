# app/controllers/private_messages_controller.rb
class PrivateMessagesController < ApplicationController
  before_action :authenticate_user!

  def chat
    @receiver = User.find(params[:id])
    @messages = PrivateMessage.where(sender: current_user, receiver: @receiver)
                              .or(PrivateMessage.where(sender: @receiver, receiver: current_user))
                              .order(:created_at)
  end

  def create
    @message = current_user.sent_messages.build(receiver_id: params[:id], body: params[:body])
    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_user_path(params[:id]) }
      end
    end
  end
end
