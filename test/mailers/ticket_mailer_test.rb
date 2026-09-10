require "test_helper"

class TicketMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  test "resolved message has recipient, subject, and both parts" do
    mail = TicketMailer.with(ticket: tickets(:resolved)).resolved

    assert_equal [users(:customer).email], mail.to
    assert_match(/Resolved:/, mail.subject)
    assert mail.multipart?

    assert_match(
     ticket_url(tickets(:resolved), host: "www.example.com"),
     mail.html_part.body.to_s
    )
    assert_match(
      tickets(:resolved).subject,
      mail.text_part.body.to_s
    )
  end
end