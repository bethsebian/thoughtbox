require "test_helper"

class UserAddsLinkTest < Capybara::Rails::TestCase
  attr_reader :user_1, :user_2

  def setup
    @user_1 = User.create(email: "janedoe@example.com",
                          password: "password")
    @user_2 = User.create(email: "jose@example.com",
                          password: "password")
  end

  test "user can add link" do
    ApplicationController.any_instance.stubs(:current_user).returns(user_1)

    title = "Best F-ing Title Ever"
    url = "http://www.best.com"

    visit links_path

    fill_in "Url", with: url
    fill_in "Title", with: title
    click_on "Add Link"

    assert_equal links_path, current_path
    assert_content page, url
    assert_content page, title
    assert_content page, "Read: false"
  end

  test "user sees error if link is invalid" do
    ApplicationController.any_instance.stubs(:current_user).returns(user_1)

    title = "Best F-ing Title Ever"
    url = "www"

    visit links_path

    fill_in "Url", with: url
    fill_in "Title", with: title
    click_on "Add Link"

    assert_equal links_path, current_path
    assert_content page, "The url is invalid. Please try again."
    refute_content page, url
    refute_content page, title
  end

  test "unauthenticated user cannot add link" do
    title = "Best F-ing Title Ever"
    url = "http://www.best.com"

    visit links_path

    fill_in "Url", with: url
    fill_in "Title", with: title
    click_on "Add Link"

    assert_equal links_path, current_path
    assert_content page, "Please log in to view links."
    refute_content page, url
    refute_content page, title
  end

  test "user only sees their links" do
    ApplicationController.any_instance.stubs(:current_user).returns(user_1)
    link_1 = Link.create(title: "User 1 Title 1",
                         url: "http://www.best1.com",
                         user_id: user_1.id)
    link_2 = Link.create(title: "User 2 Title 1",
                         url: "http://www.best2.com",
                         user_id: user_2.id)

    visit links_path
    fill_in "Title", with: "User 1 Title 2"
    fill_in "Url", with: "http://www.banana.com"
    click_on "Add Link"

    assert_content page, "User 1 Title 1"
    assert_content page, "User 1 Title 2"
    refute_content page, "User 2 Title 1"
  end
end