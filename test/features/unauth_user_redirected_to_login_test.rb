require "test_helper"

class UnauthUserRedirectedToLoginTest < Capybara::Rails::TestCase
  test "it redirects unauthenticated user to login page" do
    visit '/'
    assert_equal "/login", current_path
  end

  test "authenticated user is not redirected" do
    user  = User.create(email: "janedoe@example.com",
                        password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit "/"
    assert_equal "/", current_path
  end
end