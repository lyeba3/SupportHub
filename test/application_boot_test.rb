require "test_helper"

class ApplicationBootTest < ActiveSupport::TestCase
  test "application is initialized with Rails 7 defaults" do
    assert Rails.application.initialized?
    assert_equal 7, Rails::VERSION::MAJOR
    assert_equal SupportHub::Application, Rails.application.class
  end

  test "support email is configured during boot" do
    assert_equal "support@supporthub.example",
                 Rails.configuration.x.support_email
  end
end