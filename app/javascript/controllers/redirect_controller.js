import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['boardFrame']

  initialize() {
    let currentUrl = window.location.href
    if (currentUrl.includes('confessions')) {
      Turbo.visit('/')
      window.sessionStorage.setItem('previousUrl', currentUrl)
    } else {
      if (window.sessionStorage.getItem('previousUrl') != null) {
        this.boardFrameTarget.src = window.sessionStorage.getItem('previousUrl')
        window.sessionStorage.removeItem('previousUrl')
      }
    }
  }
}
