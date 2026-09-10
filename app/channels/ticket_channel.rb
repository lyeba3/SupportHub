class TicketChannel < ApplicationCable::Channel
  def subscribed
    ticket = Ticket.find(params[:ticket_id])
    stream_for ticket
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end