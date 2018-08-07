require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @review = reviews(:review1)
  end

  test 'valid review' do
    assert @review.valid?
  end

  # test 'sitter scores should be updated on new review' do
  #   sitter_pre = @review[:sitter]
  #   puts @review.sitter.stays
  #   review = Review.new(
  #     rating: 1,
  #     sitter: sitter_pre,
  #     text: 'review review review review review review review review review review review review',
  #     start_date: '2000-02-02',
  #     end_date: '2000-02-03'
  #   )
  #   review.send(:update_sitter_scores)

  #   # sitter_post = review[:sitter
  #   # assert_not_equal sitter_pre.stays, sitter_post.stays
  #   # assert_not_equal sitter_pre.ratings_total, sitter_post.ratings_total
  #   # assert_not_equal sitter_pre.ratings_score, sitter_post.ratings_score
  #   # assert_not_equal sitter_pre.overall_score, sitter_post.overall_score
  # end

  # test 'sitter scores should be updated on updated review' do
    

  # end

  # test 'sitter scores should be updated on deleted review' do
    

  # end

  test 'invalid review missing rating' do
    @review.rating = nil
    refute @review.valid?, 'saved review with missing rating'
    assert_not_nil @review.errors[:rating], 'no validation error for missing rating'
  end

  test 'invalid review missing start_date' do
    @review.start_date = nil
    refute @review.valid?, 'saved review with missing start_date'
    assert_not_nil @review.errors[:start_date], 'no validation error for missing start_date'
  end
  
  test 'invalid review for invalid start_date format' do
    @review.start_date = 3000-02-02
    refute @review.valid?, "saved review with bad start_date format %@review.start_date"
    assert_not_nil @review.errors[:start_date], 'no validation error for bad start_date format'
  end
  
  test 'invalid review end_date' do
    @review.end_date = nil
    refute @review.valid?, 'saved review with missing end_date'
    assert_not_nil @review.errors[:end_date], 'no validation error for missing end_date'
  end

  test 'invalid review for invalid end_date format' do
    @review.end_date = 1/1/2000
    refute @review.valid?, 'saved review with bad end_date format'
    assert_not_nil @review.errors[:end_date], 'no validation error for bad end_date format'
  end
  
  test 'invalid review missing text' do
    @review.text = nil
    refute @review.valid?, 'saved review with missing text'
    assert_not_nil @review.errors[:text], 'no validation error for missing text'
  end

  test 'invalid review text not enough length' do
    @review.text = 'Hello world. I am too short.'
    refute @review.valid?, 'saved review with too short of text'
    assert_not_nil @review.errors[:text], 'no validation error for too short of text'
  end
  
  test 'invalid review missing sitter' do
    @review.sitter = nil
    refute @review.valid?, 'saved review with missing sitter'
    assert_not_nil @review.errors[:sitter], 'no validation error for missing sitter'
  end

end
