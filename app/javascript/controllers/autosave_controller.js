// app/javascript/controllers/autosave_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  connect() {
    this.saveContent = this.debounce(this.saveContent.bind(this), 5000)
  }

  startAutosave() {
    this.saveContent()
  }

  async saveContent() {
    const content = this.contentTarget.innerHTML
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    try {
      const response = await fetch(this.data.get("url"), {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify({ note: { content: content } })
      })

      if (!response.ok) {
        throw new Error("Network response was not ok.")
      }
    } catch (error) {
    }
  }

  debounce(func, wait) {
    let timeout
    return function (...args) {
      clearTimeout(timeout)
      timeout = setTimeout(() => func.apply(this, args), wait)
    }
  }
}
