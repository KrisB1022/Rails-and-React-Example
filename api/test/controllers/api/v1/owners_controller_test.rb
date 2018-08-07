require 'test_helper'

class Api::V1::OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:owner1)
  end

  test "should get index" do
    get api_v1_owners_url, as: :json
    assert_response :success
  end

  # test "should create owner" do
  #   assert_difference('Owner.count') do
  #     post api_v1_owners_url, params: { owner: {
  #       name: 'Jimmy Johns',
  #       phone_number: 123456789,
  #       email: 'jj@gmail.com'
  #      } }, as: :json
  #   end

  #   assert_response 201
  # end

  test "should show owner" do
    get api_v1_owner_url(@owner), as: :json
    assert_response :success
  end

  # test "should update owner" do
  #   patch api_v1_owner_url(@owner), params: { owner: {  } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy api_v1_owner" do
  #   assert_difference('Owner.count', -1) do
  #     delete api_v1_owner_url(@owner), as: :json
  #   end

  #   assert_response 204
  # end
end
  