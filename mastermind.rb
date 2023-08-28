# frozen_string_literal: true

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
  def initialize
    @code = []
  end
end

# The user
class Player
  def initialize
    @code = []
  end
end
