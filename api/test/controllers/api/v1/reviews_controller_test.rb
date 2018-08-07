require 'test_helper'

class Api::V1::ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = reviews(:review1)
  end

  test "should get index" do
    get api_v1_reviews_url, as: :json
    assert_response :success
  end

  test "should show review" do
    get api_v1_review_url(@review), as: :json
    assert_response :success
  end

  # test "should update review" do
  #   patch api_v1_review_url(@review), params: { review: {  } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy api_v1_review" do
  #   assert_difference('Review.count', -1) do
  #     delete api_v1_review_url(@review), as: :json
  #   end

  #   assert_response 204
  # end
end
