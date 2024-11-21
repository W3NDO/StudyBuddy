import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "window"]

  connect() {
    this.scrollToBottom()

    document.addEventListener("turbo:frame-render", () => {
        this.scrollToBottom()
      })
  }

  afterSendMessage(){
    this.inputTarget.value = ""
  }

  scrollToBottom(){
    const chatWindow = this.windowTarget
    chatWindow.scrollTop = chatWindow.scrollHeight
    this.inputTarget.value = ""
  }
}