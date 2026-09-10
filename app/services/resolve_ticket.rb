class ResolveTicket
  Result = Struct.new(:ticket, :changed, keyword_init: true)

  def self.call(ticket:, actor:)
    changed = false

    Ticket.transaction do
      ticket.lock!

      unless ticket.status == "resolved"
        ticket.update!(
          status: "resolved",
          resolved_at: Time.current
        )

        ticket.ticket_events.create!(
          user: actor,
          event_type: "ticket.resolved",
          metadata: "{}"
        )

        changed = true
      end
    end

    if changed
      ActiveSupport::Notifications.instrument(
        "ticket.resolved",
        ticket_id: ticket.id,
        organization_id: ticket.organization_id
      ) do
        TicketChannel.broadcast_to(
          ticket,
          status: ticket.status
        )

        TicketResolvedJob.perform_later(ticket)
      end
    end

    Result.new(ticket: ticket, changed: changed)
  end
end