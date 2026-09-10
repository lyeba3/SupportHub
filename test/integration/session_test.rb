require "test_helper"

class SessionsTest < ActiveSupport::TestCase
  test "valid credentials authenticate the user" do
    user = users(:lyeba)

    assert user.authenticate("secret")
  end

  test "invalid credentials do not authenticate the user" do
    user = users(:lyeba)

    assert_not user.authenticate("wrong")
  end
end