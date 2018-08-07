require 'test_helper'

class Api::V1::SittersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sitter = sitters(:sitter1)
  end

  test "should get index" do
    get api_v1_sitters_url, as: :json
    assert_response :success
  end

  test "should get correct number of sitters index" do
    Sitter.per_page = 1

    get api_v1_sitters_url, params: { page: 2 }
    assert_response :success
    
    res = JSON.parse(response.body)
    assert_equal Sitter.per_page, res['data'].size

    assert_equal Sitter.count, res['meta']['totalCount']
  end

  test 'should filter sitters by ratingsScore 3+' do
    expected = Sitter.where({ ratings_score: 3..5})
    get api_v1_sitters_url, params: {
      filterBy: :ratingsScore,
      filterByValue: 3
    }
    assert_response :success

    res = JSON.parse(response.body)['data']
    assert_equal expected.size, res.size
  end

  test 'should filter sitters by ratingsScore 5' do
    expected = Sitter.where({ ratings_score: 5})
    get api_v1_sitters_url, params: {
      filterBy: 'ratingsScore',
      filterByValue: 5
    }
    assert_response :success

    res = JSON.parse(response.body)['data']
    assert_equal expected.size, res.size
  end

  # test "should create sitter" do
  #   assert_difference('Sitter.count') do
  #     post api_v1_sitters_url, params: { sitter: {
  #       name: 'Darth V',
  #       phone_number: 123456789,
  #       email: 'thedeathstar@gmail.com'
  #      } }, as: :json
  #   end

  #   assert_response 201
  # end

  test "should show sitter" do
    get api_v1_sitter_url(@sitter), as: :json
    assert_response :success
  end

  # test "should update sitter" do
  #   patch api_v1_sitter_url(@sitter), params: { sitter: {  } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy api_v1_sitter" do
  #   assert_difference('Sitter.count', -1) do
  #     delete api_v1_sitter_url(@sitter), as: :json
  #   end

  #   assert_response 204
  # end
end
