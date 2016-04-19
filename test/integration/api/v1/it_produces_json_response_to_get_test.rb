require "test_helper"

class ThoughtsTest < Capybara::Rails::TestCase
  attr_reader :user, :thought_1, :thought_2

  def setup
    @user = User.create(email: "janedoe@example.com",
                    password: "password")
    @thought_1 = user.links.create(url: "http://www.test.com",
                                  title: "My title 1")
    @thought_2 = user.links.create(url: "http://www.test1.com",
                                  title: "My title 2")
  end

  test "it produces json response to request for all items" do
    skip
    get "api/v1/links.json"

    json = JSON.parse(response.body)

    assert_response 200
		assert_equal 2, json.length
		assert_equal thought_2.url, json.last['url']
		assert_equal thought_2.title, json.last['title']
    assert_equal thought_2.read_status, json.last['read_status']
  end
end