class UnauthenticatedUserRedirectedTest < Minitest::Test
  test "it redirects unauthenticated user to login page" do
    visit "/"
    assert_equal "/login", current_path
  end

  test "it redirects unauthenticated user to login page" do
    skip 
    user  = User.create(email: "janedoe@example.com",
                        password: "password")
    # (stub)

    visit "/"
    assert_equal "/", current_path
  end
end