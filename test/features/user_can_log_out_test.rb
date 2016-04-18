require "test_helper"

class UserCanLogOutTest < Capybara::Rails::TestCase
  test "logged in user can log out" do
    user = User.create(email: "janedoe@example.com",
                       password: "password")

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit root_path
    click_on "Log Out"

    assert_equal '/login', current_path
  end

  test "new user does not see log out button" do
    skip
    visit '/login'
    refute_content 'Log Out'
  end
end


