require "test_helper"

class TicketsAttachmentTest < ActiveSupport::TestCase
  test "ticket does not have an attachment initially" do
    ticket = tickets(:printer)

    assert_not ticket.attachment.attached?
  end
end