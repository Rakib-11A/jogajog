class MessagesController < ApplicationController
  # Updated create method
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = @chatroom.messages.build(message_params)
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(@chatroom, {
        message: render_to_string(partial: 'messages/message', locals: { message: @message })
      })
      head :ok
    else
      redirect_to @chatroom, alert: "Message can't be blank."
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
