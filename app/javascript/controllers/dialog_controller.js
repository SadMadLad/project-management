import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'dialog' ]
  static values = { keep: Boolean }

  dialogTargetConnected(element) { if(this.keepValue === true) { element.showModal() } }

  close() { this.dialogTarget.close() }
  show() { this.dialogTarget.showModal() }
  stay(e) { e.stopPropagation() }
}
