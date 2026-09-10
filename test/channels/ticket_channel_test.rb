require "test_helper"

class TicketChannelTest < ActionCable::Channel::TestCase
  test "subscribes to a ticket stream" do
    ticket = tickets(:printer)

    stub_connection

    subscribe ticket_id: ticket.id

    assert subscription.confirmed?
    assert_has_stream_for ticket
  end
end