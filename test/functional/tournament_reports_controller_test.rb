require 'test_helper'

class TournamentReportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tournament_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tournament_report" do
    assert_difference('TournamentReport.count') do
      post :create, :tournament_report => { }
    end

    assert_redirected_to tournament_report_path(assigns(:tournament_report))
  end

  test "should show tournament_report" do
    get :show, :id => tournament_reports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tournament_reports(:one).to_param
    assert_response :success
  end

  test "should update tournament_report" do
    put :update, :id => tournament_reports(:one).to_param, :tournament_report => { }
    assert_redirected_to tournament_report_path(assigns(:tournament_report))
  end

  test "should destroy tournament_report" do
    assert_difference('TournamentReport.count', -1) do
      delete :destroy, :id => tournament_reports(:one).to_param
    end

    assert_redirected_to tournament_reports_path
  end
end
