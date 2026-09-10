require "test_helper"

class ResolveTicketInstrumentationTest < ActiveSupport::TestCase
  test "instrumentation API is available" do
    assert_respond_to ActiveSupport::Notifications, :instrument
    assert_respond_to ActiveSupport::Notifications, :subscribe
  end
end