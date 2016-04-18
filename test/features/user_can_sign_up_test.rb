require "test_helper"

class UserCanSignUpTest < Capybara::Rails::TestCase
  test "user can sign up" do
    visit '/signup'
    assert_content page, "Sign Up"

    fill_in 'email', with: "janedoe@example.com"
    fill_in 'password', with: "password"
    fill_in 'password confirmation', with: "password"
    click_on 'Submit'

    assert_equal links_path, current_path
  end

  test "user cannot sign up with email already in system" do
    user = User.create(email: "janedoe@example.com",
                       password: "password")
    visit '/signup'
    assert_content page, "Sign Up"

    fill_in 'email', with: "janedoe@example.com"
    fill_in 'password', with: "password"
    fill_in 'password confirmation', with: "password"
    click_on 'Submit'

    assert_equal '/signup', current_path
    assert_content 'Please use a different email address'
  end
end
