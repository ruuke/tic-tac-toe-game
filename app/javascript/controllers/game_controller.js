import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.gameId = this.element.dataset.gameId
    console.log("Game ID (connect):", this.gameId) // Проверка значения gameId при подключении контроллера
  }

  makeMove(event) {
    console.log("Cell clicked:", event.target)
    const row = parseInt(event.target.dataset.gameRowValue)
    const col = parseInt(event.target.dataset.gameColValue)
    const position = row * 3 + col
    console.log("Row:", row)
    console.log("Col:", col)
    console.log("Position:", position)
    console.log("Game ID (makeMove):", this.gameId)

    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    console.log("CSRF Token:", token)

    fetch(`/games/${this.gameId}/moves`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({ position: position })
    }).then(response => {
      if (response.ok) {
        Turbo.visit(window.location.href)
      } else {
        return response.json().then(data => {
          console.error("Error response:", data)
        })
      }
    }).catch(error => {
      console.error("Error:", error)
    })
  }
}
