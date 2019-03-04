require 'minitest/autorun'
require_relative '../ruby_rush/map'

class MapTest < Minitest::Test

	# UNIT TESTS FOR METHOD initialize(infile, random)
	# Equivalence classes:
	# infile is valid and random provided -> successfully build data structures
	# infile is invalid -> raise 'ArgumentError'
	# random is nil -> raise 'ArgumentError'

	# When infile is valid and random is not null, build the graph data structure
	def test_initialize_success
		# This is the graph that map should build
		expected_graph = Hash.new
	    expected_graph['A'] = ['B']
	    expected_graph['B'] = ['A', 'C', 'D']
	    expected_graph['C'] = ['B', 'D']
	    expected_graph['D'] = ['B', 'C']

	    map = Map.new("tests/test_data.yaml", "random")

	    assert (expected_graph == map.graph)
	end

	# When infile contains invalid data, initialize should raise an 'ArgumentError'
	# EDGE CASE
	def test_initialize_invalid_data
		assert_raises ('ArgumentError') { Map.new("tests/test_data_invalid.yaml", "random") }
	end

	# When random is nil, initialize should raise an 'ArgumentError'
	# EDGE CASE
	def test_initialize_nil_random
		assert_raises ('ArgumentError') { Map.new("tests/test_data.yaml", nil) }
	end

	# UNIT TESTS FOR METHOD get_rubies(location)
	# Equivalence classes:
	# location is valid -> return a list of integers, where each integer is randomly generated in range 0..max
	# location is invalid -> return nil

	# If location is valid, get_rubies should return a list of integers
	# Each integer should be randomly generated, and in range 0..max
	def test_get_rubies_valid
		# First, strub a random number generator
    	mock_random = Minitest::Mock.new("random")
	    def mock_random.rand(x); 1; end;

	    # Then, generate a new map
	    map = Map.new("tests/test_data.yaml", mock_random)

	    assert_equal [1, 1], map.get_rubies('B')
	end

	# If location is invalid, get_rubies should return nil
	def test_get_rubies_invalid
		# First, strub a random number generator
    	mock_random = Minitest::Mock.new("random")
	    def mock_random.rand(x); 1; end;

	    # Then, generate a new map
	    map = Map.new("tests/test_data.yaml", mock_random)

	    assert_nil map.get_rubies("not_a_city")
	end

	# UNIT TESTS FOR METHOD get_next_city(location)
	# Equivalence classes:
	# location is valid -> return neighboring city
	# location is invalid -> return nil

	# If the location is valid, get_next_city should randomly return a neighboring city
	def test_get_next_city_valid
		# First, stub a random number generator
		mock_random = Minitest::Mock.new("random")
  		def mock_random.rand(x); 1; end;

  		# Then, generate a new map
	  	map = Map.new("tests/test_data.yaml", mock_random)

  		assert_equal 'C', map.get_next_city('B')
	end

	# If the location is invalid, get_next_city should return nil
	# EDGE CASE
	def test_get_next_city_invalid
		# First, mock a random number generator
		mock_random = Minitest::Mock.new("random")
  		def mock_random.rand(x); 1; end;

  		# Then, generate a new map
	  	map = Map.new("tests/test_data.yaml", mock_random)

  		assert_nil map.get_next_city("not_a_city")
	end
end