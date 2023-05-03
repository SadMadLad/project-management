import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'dialog' ]
  static values = {
    keep: { type: Boolean, default: false },
    // If the dialog is only for a specific action to path.
    actionOnly: { type: Boolean, default: true }
  }

  dialogTargetConnected(element) { if(this.keepValue === true) { element.showModal() } }

  close() {
    this.dialogTarget.close()
    if(this.actionOnlyValue === true) { this.dialogTarget.remove() }
  }
  show() { this.dialogTarget.showModal() }
  stay(e) { e.stopPropagation() }
}
