# frozen_string_literal: true

COLORS = %w[red green blue yellow white purple].freeze
TURNS = 12

# The structure and logic of the game
class Mastermind
  def game_over?(code, code_guess)
    code_guess == code || TURNS.zero?
  end
end

# The opponent of the game
class Computer
  attr_accessor :code

  def initialize
    @code = [nil, nil, nil, nil]
  end

  def choose_code
    @code.each_with_index do |_color, index|
      @code[index] = COLORS.sample
    end
  end
end

# The user
class Player
  def initialize
    @code = [nil, nil, nil, nil]
  end
end
