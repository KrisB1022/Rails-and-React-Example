require 'test_helper'

class OwnerTest < ActiveSupport::TestCase
  def setup
    @owner = owners(:owner1);
  end

  test 'valid owner' do
    assert @owner.valid?
  end

  test 'invalid owner without name' do
    @owner.name = nil
    refute @owner.valid?, 'saved an owner without a name'
    assert_not_nil @owner.errors[:name], 'no error validation for name present'
  end

  test 'invalid owner name length' do
    @owner.name = 'K'
    refute @owner.valid?, 'saved an owner too short of name'
    assert_not_nil @owner.errors[:name], 'no error validation for name present'
  end

  test 'invalid without phone_number' do
    @owner.phone_number = nil
    refute @owner.valid?, 'saved an owner without a phone number'
    assert_not_nil @owner.errors[:phone_number], 'no error validation for phone_number present'
  end

  test 'invalid without email' do
    @owner.email = nil
    refute @owner.valid?, 'saved an owner without an email'
    assert_not_nil @owner.errors[:email], 'no error validation for email present'
  end

  test 'invalid email format' do
    @owner.email = 'Westeros.com'
    refute @owner.valid?, 'saved an invalid formatted email'
    assert_not_nil @owner.errors[:email], 'no error validation for email'
  end

  test '#dogs' do
    assert_equal 4, @owner.dogs.size
  end
end
