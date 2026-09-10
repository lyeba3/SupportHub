import consumer from "./consumer"

const ticketChannel = consumer.subscriptions.create(
  {
    channel: "TicketChannel",
    ticket_id: document.body.dataset.ticketId
  },
  {
    connected() {
      console.log("Connected to TicketChannel")
    },

    disconnected() {
      console.log("Disconnected from TicketChannel")
    },

    received(data) {
      const statusElement = document.querySelector("[data-ticket-status]")

      if (statusElement && data.status) {
        statusElement.textContent = data.status
      }
    }
  }
)

export default ticketChannel