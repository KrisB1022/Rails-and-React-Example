require 'test_helper'

class DogTest < ActiveSupport::TestCase
  def setup
    @dog = dogs(:dog1)
  end

  test 'valid dog' do
    assert @dog.valid?
  end

  test 'invalid dog missing name' do
    @dog.name = nil
    refute @dog.valid?, 'saved dog missing name'
    assert_not_nil @dog.errors[:name], 'no error validation for missing name'
  end

  test 'invalid dog missing owner' do
    @dog.owner = nil
    refute @dog.valid?, 'saved dog missing an owner'
    assert_not_nil @dog.errors[:owner], 'no error validation for missing owner'
  end

end
