require "test_helper"

class BioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bio_index_url
    assert_response :success
  end
end
