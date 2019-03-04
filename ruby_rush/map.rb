# frozen_string_literal: true

require 'yaml'
require_relative 'location.rb'

# The Map class contains a graph that represents the provided map
class Map
  attr_reader :start, :graph

  def initialize(infile, random)
    raise 'ArgumentError' if random.nil?

    @graph = {}
    @locations = {}
    @random = random

    begin
      @parameters = YAML.load_file(infile)
      @start = @parameters['start']
      build_meta_data
      build_graph
    rescue StandardError
      raise ArgumentError
    end
  end

  def build_meta_data
    @parameters['locations'].each do |location|
      name = location[0]
      max_real = location[1]['max_real']
      max_fake = location[1]['max_fake']

      @locations[name] = Location.new(name, max_real, max_fake)
    end

    @locations
  end

  def build_graph
    @parameters['locations'].each do |location|
      name = location[0]
      @graph[name] = []
    end

    @parameters['graph'].each do |edge|
      key = edge.keys[0]
      value = edge.values[0]

      @graph[key].push(value).sort
      @graph[value].push(key).sort
    end

    @graph
  end

  def get_rubies(location)
    location = @locations[location]
    return nil if location.nil?

    num_real = @random.rand(0..location.max_real)
    num_fake = @random.rand(0..location.max_fake)

    [num_real, num_fake]
  end

  def get_next_city(location)
    neighbors = @graph[location]
    return nil if neighbors.nil?

    neighbors[@random.rand(0..neighbors.size - 1)]
  end
end
