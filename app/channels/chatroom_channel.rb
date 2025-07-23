class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    @chatroom = Chatroom.find(params[:chatroom_id])
    stream_for @chatroom
  end

  def unsubscribed
    # যেকোন ক্লিনআপ দরকার হলে এখানে
  end
end
