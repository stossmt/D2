# frozen_string_literal: true

require_relative 'ruby_rush/prospector'
require_relative 'ruby_rush/initialize'

init(ARGV).each do |prospector|
  loop do
    while prospector.mine do end
    break unless prospector.travel
  end
end
