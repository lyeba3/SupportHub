require "test_helper"

class TicketSecurityTest < ActiveSupport::TestCase
  test "ticket belongs to its organization" do
    ticket = tickets(:printer)

    assert_equal organizations(:acme), ticket.organization
    assert_not_equal organizations(:globex), ticket.organization
  end
end