require "test_helper"

class ServerTimingTest < ActiveSupport::TestCase
  test "application has request timing middleware configured" do
    middleware = Rails.application.middleware.map(&:klass)
    assert_includes middleware, RequestTimer
  end
end