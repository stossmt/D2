require 'minitest/autorun'
require_relative '../ruby_rush/initialize'
require_relative '../ruby_rush/prospector'

class InitTest < Minitest::Test
	# UNIT TEST FOR METHOD init(args)
	# Equivalence classes:
	# If args is valid -> return a list of prospectors
	# if args is invalid -> exit with error code 1
	# see cli_test for invalid arguments

	# Args is valid, so a list of prospectors should be returns
	def test_initialize_success
		args = [1, 1, 1]
		assert_instance_of Prospector, init(args)[0]
	end

	# Args is invalid, so the program should exit with code 1
	def test_initialize_invalid_args
		begin
			parse_args(["1", "1", "$"])
		rescue SystemExit => e
			error = e 
		end

		assert_equal error.class, SystemExit
		assert_equal error.status, 1
	end
end