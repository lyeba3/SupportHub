require "test_helper"

class TicketAttachmentTest < ActiveSupport::TestCase
  test "rejects a non-PDF attachment" do
    ticket = tickets(:printer)

    ticket.attachment.attach(
      io: StringIO.new("not a pdf"),
      filename: "support.txt",
      content_type: "text/plain"
    )

    assert_not ticket.valid?
    assert_includes ticket.errors[:attachment], "must be a PDF"
  end
end