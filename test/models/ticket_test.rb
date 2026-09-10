require "test_helper"

class TicketTest < ActiveSupport::TestCase
  test "requires a subject" do
    ticket = Ticket.new(
      organization: organizations(:acme),
      status: "open",
      priority: 1
    )

    assert_not ticket.valid?
    assert_includes ticket.errors[:subject], "can't be blank"
  end

  test "accepts valid statuses" do
    ticket = tickets(:printer)

    Ticket::STATUSES.each do |status|
      ticket.status = status
      assert ticket.valid?
    end
  end

  test "rejects invalid status" do
    ticket = tickets(:printer)
    ticket.status = "invalid"

    assert_not ticket.valid?
    assert_includes ticket.errors[:status], "is not included in the list"
  end

  test "unresolved scope excludes resolved tickets" do
  assert_includes Ticket.unresolved, tickets(:printer)
  assert_includes Ticket.unresolved, tickets(:email)
end

  test "urgent_first orders by priority" do
    tickets = Ticket.urgent_first

    assert_equal 2, tickets.first.priority
  end
end