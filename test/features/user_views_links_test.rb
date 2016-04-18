require "test_helper"

class UserViewsLinksTest < Capybara::Rails::TestCase
  test "user views links" do
    user = User.create(email: "janedoe@example.com",
                       password: "password")
    link_1 = Link.create(url: "http://www.word.com",
                         title: "Best Title",
                         read_status: true)
    link_2 = Link.create(url: "http://www.believeland.com",
                         title: "Second Best Title")


    visit '/links'
    assert_content page, "http://www.word.com"
    assert_content page, "Best Title"
    within "#link_#{link_1.id}" do
      assert_content page, "Read: true"
    end
    assert_content page, "http://www.believeland.com"
    assert_content page, "Second Best Title"
    within "#link_#{link_2.id}" do
      assert_content page, "Read: false"
    end
  end
end