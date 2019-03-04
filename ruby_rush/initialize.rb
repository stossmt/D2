# frozen_string_literal: true

require_relative 'cli'
require_relative 'map'
require_relative 'prospector'

def init(args)
  # Parse args
  seed, num_prospect, num_turns = parse_args(args)

  # Create random number generator
  random = Random.new(seed)

  # Create map based on input file
  map = Map.new('location_parameters.yaml', random)

  # Create prospector objects
  prospectors = []
  (0..num_prospect - 1).each { |i| prospectors.append(Prospector.new(map, num_turns, i + 1)) }

  prospectors
end
