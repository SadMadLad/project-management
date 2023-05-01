import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form']
  static values = { keep: Boolean }

  connect() {
    if(this.keepValue === true) { this.element.showModal() }
  }
  formTargetConnected(element) {
    element.addEventListener('turbo:submit-end', e => {
      if(e.detail.success) { this.element.close() }
    })
  }

  close() { this.element.close() }

  stay(e) { e.stopPropagation() }
}
