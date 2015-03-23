require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout_links" do
    get root_path
    assert_template 'static_pages/home'   # test if rendered using the correct view
    assert_select "a[href=?]", root_path, count: 2   # test if there are 2 links to root path (the "?" is replaced with root_path by Rails)
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

  end

  test "test get signup" do
    get signup_path
    assert_select "title", "Sign up | Ruby on Rails Tutorial Sample App"
  end
end
