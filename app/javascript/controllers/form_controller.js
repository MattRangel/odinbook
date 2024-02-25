import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  clear() {
    this.element.reset()
  }

  submit() {
    this.element.requestSubmit()
  }
}
