require 'test_helper'

class MobileApiControllerTest < ActionController::TestCase
  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get fb_login" do
    get :fb_login
    assert_response :success
  end

  test "should get twitter_login" do
    get :twitter_login
    assert_response :success
  end

  test "should get upload" do
    get :upload
    assert_response :success
  end

end
