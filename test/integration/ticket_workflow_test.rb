require "test_helper"

class TicketWorkflowTest < ActionDispatch::IntegrationTest
  test "create and resolve a ticket" do
    organization = organizations(:acme)

    ticket = Ticket.create!(
      organization: organization,
      subject: "Cannot access dashboard",
      description: "The dashboard returns an error.",
      priority: 2
    )

    assert_equal "open", ticket.status

    ticket.update!(
      status: "resolved",
      resolved_at: Time.current
    )

    ticket.reload

    assert_equal "resolved", ticket.status
    assert_not_nil ticket.resolved_at
  end
end