require 'test_helper'

class Api::V1::DogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dog = dogs(:dog1)
  end

  test "should get index" do
    get api_v1_dogs_url, as: :json
    assert_response :success
  end

  test "should show dog" do
    get api_v1_dog_url(@dog), as: :json
    assert_response :success
  end

  test "should update dog" do
    patch api_v1_dog_url(@dog), params: { dog: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_v1_dog" do
    assert_difference('Dog.count', -1) do
      delete api_v1_dog_url(@dog), as: :json
    end

    assert_response 204
  end
end
