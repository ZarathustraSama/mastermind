# frozen_string_literal: true

COLORS = %w[red green blue yellow white purple].freeze

# The structure of the game
class Mastermind
  attr_accessor :code, :turns

  def initialize(code)
    @code = code
    @turns = 12
  end

  def game_over?(code_guess)
    code_guess == @code || @turns.zero?
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
