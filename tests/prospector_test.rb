require 'minitest/autorun'
require_relative '../ruby_rush/prospector'

class ProspectorTest < Minitest::Test
	# UNIT TEST FOR METHOD mine()
	# Equivalence classes:
	# If @days == 0 -> print start mining message
	# if num_real or num_fake > 0 -> print found rubies message
	# if num_real and num_fake == 0 -> print no found rubies message

	# If days is zero (first time calling mine), print the start mining message
	def test_mine_first_day
		expected = "Rubyist #1 starting in start.\n\tFound no rubies or fake rubies in start.\n"

		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_rubies(x); [0, 0]; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_output (expected) { p.mine }
	end

	# If any rubies are found, print the found rubies message
	def test_mine_rubies_found
		expected = "\tFound 1 ruby and 1 fake ruby in start.\n"

		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_rubies(x); [1, 1]; end;
		p = Prospector.new(mock_map, 1, 1)
		p.mine

		assert_output (expected) { p.mine }
	end

	# If no rubies are found, print the no rubies are found message
	def test_mine_rubies_not_found
		expected = "\tFound no rubies or fake rubies in start.\n"

		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_rubies(x); [0, 0]; end;
		p = Prospector.new(mock_map, 1, 1)
		p.mine

		assert_output (expected) { p.mine }
	end

	# UNIT TEST FOR METHOD travel()
	# Equivalence classes:
	# @turns < @turns_allowed -> print travel message and return true
	# @turns >= @turns_allowed -> print go home message and return false

	# If @turns < @turns_allowed, return true
	def test_travel_true_return
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_next_city(x); "location"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert p.travel
	end

	# If @turns < @turns_allowed, print travel message
	def test_travel_true_output
		expected = "Heading from start to location.\n"

		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_next_city(x); "location"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_output (expected) { p.travel }
	end

	# If @turns >= @turns_allowed, return false
	def test_travel_false_return
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_next_city(x); "location"; end;
		p = Prospector.new(mock_map, 0, 1)

		refute p.travel
	end

	# If @turns >= @turns_allowed, print go_home
	def test_travel_false_output
		expected = "After 0 days, Rubyist 1 found:\n"\
				   "\t0 rubies.\n"\
				   "\t0 fake rubies."\
				   "\nGoing home sad.\n"

		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_next_city(x); "location"; end;
		p = Prospector.new(mock_map, 0, 1)

		assert_output (expected) { p.travel }
	end

	# UNIT TEST FOR METHOD go_home()
	# Equivalence classes:
	# @total_real >= 10 -> print victorious message
	# @total_real < 10 -> print going home sad message

	# If prospector has mined less than 10 rubies (@total_real < 10), print going home sad message
	def test_go_home_sad
		expected = "After 0 days, Rubyist 1 found:\n"\
				   "\t0 rubies.\n"\
				   "\t0 fake rubies."\
				   "\nGoing home sad.\n"

		# Mock a map
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_output (expected) { p.go_home() }
	end

	# If prospector has mined more than 9 rubies (@total_real >= 10), print victorious message
	def test_go_home_victorious
		expected = "After 1 days, Rubyist 1 found:\n"\
		   "\t10 rubies.\n"\
		   "\t0 fake rubies."\
		   "\nGoing home victorious!\n"

		# Mock a map
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
	    def mock_map.get_rubies(x); [10, 0]; end;
		p = Prospector.new(mock_map, 1, 1)

		# Mine once, so real rubies = 10
		p.mine

		assert_output (expected) { p.go_home() }
	end

	# UNIT TESTS FOR METHOD format_ruby(x, real)
	# Equivalence classes:
	# x == 1 and real == true -> returns "{{x}} ruby"
	# x == 1 and real == false -> returns "{{x}} fake ruby"
	# x != 1 and real == true -> returns "{{x}} rubies"
	# x != 1 and real == false -> returns "{{x}} fake rubies"
	# x == nil -> raise 'ArgumentError'
	# real == nil -> raise 'ArgumentError'

	# If one real ruby (x=1, real=true), return "{{x}} ruby"
	def test_format_ruby_singular_real
    	mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_equal "1 ruby", p.format_ruby(1, true)
	end

	# If one fake ruby (x=1, real=false), return "{{x}} fake ruby"
	def test_format_ruby_singular_fake
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_equal "1 fake ruby", p.format_ruby(1, false)
	end

	# If zero or many real rubies (x!=1, real=true), return "{{x}} rubies"
	def test_format_ruby_plural_real
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_equal "2 rubies", p.format_ruby(2, true)
	end

	# If zero or many fake rubies (x!=1, real=fake), return "{{x}} fake rubies"
	def test_format_ruby_plural_fake
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_equal "2 fake rubies", p.format_ruby(2, false)
	end

	# If x is nil, raise an argument error
	# EDGE CASE
	def test_format_ruby_x_nil
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_nil p.format_ruby(nil, false)
	end

	# If real is nil, raise an argument error
	# EDGE CASE
	def test_format_ruby_real_nil
		mock_map = Minitest::Mock.new("map")
	    def mock_map.start; "start"; end;
		p = Prospector.new(mock_map, 1, 1)

		assert_nil p.format_ruby(1, nil)
	end

end