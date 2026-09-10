require "test_helper"

class TicketResolvedJobTest < ActiveJob::TestCase
  test "repeat execution does not send twice" do
    ticket = tickets(:resolved)

    assert_difference("ActionMailer::Base.deliveries.size", 1) do
      perform_enqueued_jobs do
        TicketResolvedJob.perform_later(ticket)
      end
    end

    assert_no_difference("ActionMailer::Base.deliveries.size") do
      TicketResolvedJob.perform_now(ticket.reload)
    end
  end
end