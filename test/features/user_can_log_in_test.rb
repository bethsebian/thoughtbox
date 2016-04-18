require "test_helper"

class UserCanLogInTest < Capybara::Rails::TestCase
  test "user can log in" do
    user = User.create(email: "janedoe@example.com", 
                       password: "password")
    visit root_path
    click_on 'Log In'

    assert_equal '/login', current_path

    fill_in 'email', with: "janedoe@example.com"
    fill_in 'password', with: "password"
    click_on 'Submit'

    assert_equal links_path, current_path
  end
end