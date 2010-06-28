require 'test_helper'

class InquiriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inquiries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inquiry" do
    assert_difference('Inquiry.count') do
      post :create, :inquiry => { }
    end

    assert_redirected_to inquiry_path(assigns(:inquiry))
  end

  test "should show inquiry" do
    get :show, :id => inquiries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => inquiries(:one).to_param
    assert_response :success
  end

  test "should update inquiry" do
    put :update, :id => inquiries(:one).to_param, :inquiry => { }
    assert_redirected_to inquiry_path(assigns(:inquiry))
  end

  test "should destroy inquiry" do
    assert_difference('Inquiry.count', -1) do
      delete :destroy, :id => inquiries(:one).to_param
    end

    assert_redirected_to inquiries_path
  end
end
