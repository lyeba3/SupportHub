class TicketMailer < ApplicationMailer
  def resolved
    @ticket = params[:ticket]
    @recipient = @ticket.requester

    mail(
      to: @recipient.email,
      subject: "Resolved: #{@ticket.subject}"
    )
  end
end