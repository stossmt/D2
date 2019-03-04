# frozen_string_literal: true

# Prospector stores the data and actions associated with prospectors, such as mining and traveling locations
class Prospector
  attr_reader :number, :location

  def initialize(map, turns_allowed, number)
    @number = number
    @location = map.start
    @map = map
    @days = 0
    @total_real = 0
    @total_fake = 0
    @turns = 0
    @turns_allowed = turns_allowed
  end

  def mine
    puts "Rubyist ##{@number} starting in #{@location}." if @days.zero?
    ret = false
    num_real, num_fake = @map.get_rubies(@location)
    @days += 1

    if num_real.positive? || num_fake.positive?
      @total_real += num_real
      @total_fake += num_fake
      puts "\tFound #{format_ruby(num_real, true)} and #{format_ruby(num_fake, false)} in #{@location}."
      ret = true
    else
      puts "\tFound no rubies or fake rubies in #{@location}."
    end

    ret
  end

  def travel
    ret = false

    if @turns < @turns_allowed
      old_location = @location
      @location = @map.get_next_city(@location)
      @turns += 1
      ret = true
      puts "Heading from #{old_location} to #{@location}."
    else
      go_home
    end

    ret
  end

  def go_home
    print "After #{@days} days, Rubyist #{@number} found:\n\t#{format_ruby(@total_real, true)}.\n"
    print "\t#{format_ruby(@total_fake, false)}."
    puts "\nGoing home victorious!" if @total_real >= 10
    puts "\nGoing home sad." if @total_real < 10
  end

  def format_ruby(num, real)
    return nil if num.nil? || real.nil?

    ret = "#{num} "

    ret += 'fake ' if real == false
    ret += 'ruby' if num == 1
    ret += 'rubies' if num != 1

    ret
  end
end
