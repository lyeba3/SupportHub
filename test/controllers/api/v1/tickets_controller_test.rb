require "test_helper"

class Api::V1::TicketsControllerTest < ActiveSupport::TestCase
  test "ticket data is available for the API" do
    ticket = tickets(:printer)

    assert_equal "Printer is not working", ticket.subject
    assert_equal "open", ticket.status
    assert_equal 2, ticket.priority
  end

  test "ticket belongs to current user's organization" do
    ticket = tickets(:printer)
    user = users(:lyeba)

    assert_equal user.organization, ticket.organization
  end

  test "new ticket can be created for the current organization" do
    organization = organizations(:acme)

    ticket = organization.tickets.create!(
      subject: "API-created ticket",
      description: "Created through the API workflow.",
      priority: 1
    )

    assert_equal organization, ticket.organization
    assert_equal "open", ticket.status
  end

  test "ticket can be updated" do
    ticket = tickets(:printer)

    ticket.update!(priority: 5)

    assert_equal 5, ticket.reload.priority
  end
end