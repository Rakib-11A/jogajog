import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatroomId: Number }

  connect() {
    this.channel = consumer.subscriptions.create(
        { channel: "ChatroomChannel", chatroom_id: this.chatroomIdValue },
        {
          received: data => {
            document.getElementById("messages").insertAdjacentHTML("beforeend", data.message)
          }
        }
    )
  }
}
