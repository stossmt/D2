require 'minitest/autorun'
require_relative '../ruby_rush/cli'

class CliTest < Minitest::Test
	# UNIT TEST FOR METHOD usage()
	# Tests that usage prints the correct message
	# This method has no equivalence classes. When called, it only does one thing: prints the usage
	def test_usage
		expected = "Usage:\nruby ruby_rush.rb "\
				   "*seed* *num_prospectors* *num_turns*\n"\
				   "*seed* should be an integer\n"\
				   "*num_prospectors* should be a non-negative integer\n"\
				   "*num_turns* should be a non-negative integer\n\n"

		assert_output(expected) { usage }
	end

	# UNIT TESTS FOR METHOD parse(args)
	# Provided a list of three valid strings, returns a list of three integers
	# SUCCESS CASES: args.length is 3, all arguments are integers, args[1] and args[2] are not negative
	# FAILURE CASES: If args.length is not 3 -> raise 'TypeError'
	#                If args contains a non-integer -> raise 'ArgumentError'
	#                If args[1] is negative -> raise 'ArgumentError'
	# 				 If args[2] is negative -> raise 'ArgumentError'

	# If args is a valid list of strings, return a list of integers
	# valid list = list.length is 3, all strings can be converted to integers, list[1] and list[2] are not non-negative
	def test_parse_success
		assert_equal [1, 1, 1], parse(["1", "1", "1"])
	end

	# If args is not a list of length 3, raise a 'TypeError'
	def test_parse_incorrect_length
		assert_raises ('TypeError') { parse(["1", "1"]) }
	end

	# If args contains a string that cannot be parsed into an integer, raise an 'ArgumentError'
	def test_parse_invalid_symbol
		assert_raises ('ArgumentError') { parse(["1", "1", "$"]) }
	end

	# If the second argument in args is negative, raise an 'ArgumentError'
	def test_parse_invalid_second_arg
		assert_raises ('ArgumentError') { parse(["1", "-1", "1"]) }
	end

	# If the third argument in args is negative, raise an 'ArgumentError'
	def test_parse_invalid_third_arg
		assert_raises ('ArgumentError') { parse(["1", "1", "-1"]) }
	end

	# UNIT TESTS FOR METHOD parse_args(args)
	# If args is valid, return a list of integers. Otherwise, print usage and exit the program
	# SUCCESS CASES: args.length is 3, all arguments are integers, args[1] and args[2] are not negative
	# FAILURE CASES: If args.length is not 3 -> exit with code 1
	#                If args contains a non-integer -> exit with code 1
	#                If args[1] is negative -> exit with code 1
	# 				 If args[2] is negative -> exit with code 1

	# If parse_args is a valid list of strings, return a list of integers
	# valid list = list.length is 3, all strings can be converted to integers, list[1] and list[2] are not non-negative
	def test_parse_args_success
		assert_equal [1, 1, 1], parse_args(["1", "1", "1"])
	end

	# If args is not a list of length 3, exit with code 1
	def test_parse_args_incorrect_length
		begin
			parse_args(["1", "1"])
		rescue SystemExit => e
			error = e 
		end

		assert_equal error.class, SystemExit
		assert_equal error.status, 1
	end

	# If parse_args contains a string that cannot be parsed into an integer, exit with code 1
	def test_parse_args_invalid_symbol
		begin
			parse_args(["1", "1", "$"])
		rescue SystemExit => e
			error = e 
		end

		assert_equal error.class, SystemExit
		assert_equal error.status, 1
	end

	# If the second argument in args is negative, exit with code 1
	def test_parse_args_invalid_second_arg
		begin
			parse_args(["1", "-1", "1"])
		rescue SystemExit => e
			error = e 
		end

		assert_equal error.class, SystemExit
		assert_equal error.status, 1
	end

	# If the second argument in args is negative, exit with code 1
	def test_parse_args_invalid_third_arg
		begin
			parse_args(["1", "1", "-1"])
		rescue SystemExit => e
			error = e 
		end

		assert_equal error.class, SystemExit
		assert_equal error.status, 1
	end

end
