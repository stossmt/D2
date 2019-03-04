# frozen_string_literal: true

# The Location class is used by Map.rb to hold metadata associated with one location
class Location
  attr_reader :max_real, :max_fake

  def initialize(name, max_real, max_fake)
    @name = name
    @max_real = max_real
    @max_fake = max_fake
  end
end
