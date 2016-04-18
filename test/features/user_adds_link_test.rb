require "test_helper"

class UserAddsLinkTest < Capybara::Rails::TestCase
  test "user can add link" do
    title = "Best F-ing Title Ever"
    url = "http://www.best.com"

    visit links_path

    fill_in "url", with: url
    fill_in "title", with: title
    click_on "Add Link"

    assert_equal links_path, current_path

    assert_content page, url
    assert_content page, title
    assert_content page, "Read: false"
  end

  test "user sees error if link is invalid" do
    skip
    # Submitting an invalid link should result in an error message being displayed.
  end
end