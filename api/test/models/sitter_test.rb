require 'test_helper'

class SitterTest < ActiveSupport::TestCase
  def setup
    @sitter = sitters(:sitter1)
  end

  test 'valid sitter' do
    assert @sitter.valid?
  end

  test 'sitter_score and overall_score set on create' do 
    sitter = Sitter.new(
      name: 'A sitter',
      email: 'email@email.com',
      phone_number: 123
    )
    sitter.send(:add_sitter_score)
    assert_not_nil sitter.sitter_score, 'sitter created without a sitter_score'
    assert_not_nil sitter.overall_score, 'sitter created without an overall score'
  end

  test 'invalid for duplicate sitter email' do
    sitter = sitters(:sitter2)
    sitter.email = @sitter.email

    refute sitter.valid?, 'saved a sitter with duplicate email'
    assert_not_nil sitter.errors[:email], 'no error validation for duplicate email'
  end

  test 'invalid sitter without name' do
    @sitter.name = nil
    refute @sitter.valid?, 'saved a sitter without a name'
    assert_not_nil @sitter.errors[:name], 'no error validation for name present'
  end

  test 'invalid sitter with too short of name' do
    @sitter.name = 'H'
    refute @sitter.valid?, 'saved a sitter with too short of name '
    assert_not_nil @sitter.errors[:name], 'no error validation for name present'
  end

  test 'invalid sitter without phone_number' do
    @sitter.phone_number = nil
    refute @sitter.valid?, 'saved a sitter without a phone_number'
    assert_not_nil @sitter.errors[:phone_number], 'no error validation for phone_numberpresent'
  end

  test 'invalid sitter without email' do
    @sitter.email = nil
    refute @sitter.valid?, 'saved a sitter without '
    assert_not_nil @sitter.errors[:email], 'no error validation for email present'
  end

  test 'invalid sitter with improperly formatted email' do
    @sitter.email = 'DragonsRule!@.org'
    refute @sitter.valid?, 'saved a sitter with invalid email format'
    assert_not_nil @sitter.errors[:email], 'no error validation for email present'
  end

  test '#reviews' do
    assert_equal 2, @sitter.reviews.size
  end

end
