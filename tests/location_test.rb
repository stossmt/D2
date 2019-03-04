require 'minitest/autorun'
require_relative '../ruby_rush/location'

class LocationTest < Minitest::Test

  # UNIT TESTS FOR METHOD initialize(name, max_real, max_fake)
  # Location is just a data class, so there is not any methods to test. 
  # Test a successful initialization for code coverage

  def test_location_success
    assert_instance_of Location, Location.new("name", 1, 2)
  end

end