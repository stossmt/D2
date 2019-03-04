require 'minitest/autorun'
require_relative '../ruby_rush/location'

class LocationTest < Minitest::Test

  # UNIT TESTS FOR METHOD initialize(name, max_real, max_fake)
  # Location is just a data class, so there is not any methods to test. 
  # Test a successful initialization for code coverage

  # The second parameter should properly set max_real
  def test_location_max_real
  	l = Location.new("name", 1, 2)
    assert_equal 1, l.max_real
  end

  # The third parameter should properly set max_fake
  def test_location_max_fake
  	l = Location.new("name", 1, 2)
    assert_equal 2, l.max_fake
  end
end