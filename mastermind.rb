# frozen_string_literal: true

COLORS = %w[red green blue yellow white purple].freeze
TURNS = 12

# Both the structure and logic of the game and the opponent
class Mastermind
  attr_accessor :code

  def initialize
    @code = []
  end

  def choose_code
    0..3.each do
      @code << COLORS.sample
    end
  end

  def game_over?(code, code_guess)
    code_guess == code || TURNS.zero?
  end
end

# The user
class Player
  def initialize
    @code = [nil, nil, nil, nil]
  end
end
