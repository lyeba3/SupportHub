class TicketResolvedJob < ApplicationJob
  queue_as :mailers

  retry_on Net::OpenTimeout,
           wait: :exponentially_longer,
           attempts: 5

  discard_on ActiveJob::DeserializationError

  def perform(ticket)
    return if ticket.resolution_notice_sent_at?

    TicketMailer.with(ticket: ticket).resolved.deliver_now

    ticket.update!(
      resolution_notice_sent_at: Time.current
    )
  end
end