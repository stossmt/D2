# frozen_string_literal: true

def parse_args(args)
  begin
    seed, num_prospect, num_turns = parse(args)
  rescue ArgumentError, TypeError, NoMethodError
    usage
    exit 1
  end

  [seed, num_prospect, num_turns]
end

def usage
  puts 'Usage:'
  puts 'ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*'
  puts '*seed* should be an integer'
  puts '*num_prospectors* should be a non-negative integer'
  puts "*num_turns* should be a non-negative integer\n\n"
end

def parse(args)
  seed = Integer(args[0])
  num_prospect = Integer(args[1])
  num_turns = Integer(args[2])

  raise ArgumentError if num_prospect.negative? || num_turns.negative?

  [seed, num_prospect, num_turns]
end
