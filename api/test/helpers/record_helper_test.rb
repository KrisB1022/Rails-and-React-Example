require 'test_helper'
include RecordHelper

class RecordHelperTest < ActiveSupport::TestCase
    def setup
        @sitter = sitters(:sitter1)
    end

    test 'santize_str sanitizes a string' do
        test1 = RecordHelper.sanitize_str('Hello')
        assert_equal 'helo', test1.join('')

        test2 = RecordHelper.sanitize_str('Hello BigGGGgg Bopper!!!!')
        assert_equal 'helobigpr', test2.join('')

        test3 = RecordHelper.sanitize_str('1235498 !!: ":"Lkjhaldfjkh')
        assert_equal 'lkjhadf', test3.join('')
    end

    test 'get_sitter_score returns a sitter score' do
        score = RecordHelper.get_sitter_score('Drew Carrey')
        assert_equal 1.85, score.truncate(2)
    end
    
    test 'get_ratings_score returns a ratings score' do
        score = RecordHelper.get_ratings_score(@sitter)
        assert_equal 1.33, score.truncate(2)
    end
    
    test 'get_overall_score returns ratings_score for 10 stays' do
        @sitter.stays = 10
        score = RecordHelper.get_overall_score(@sitter)
        assert_equal @sitter.ratings_score, score
    end

    test 'get_overall_score returns overall_score <= 5' do
        score = RecordHelper.get_overall_score(@sitter)
        assert_equal 3.0, score
    end

end
