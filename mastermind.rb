# frozen_string_literal: true

COLORS = %w[red green blue yellow white purple].freeze
TURNS = 12

# Both the logic and the opponent of the game
class Mastermind
  attr_accessor :code

  def initialize
    @code = []
    @turns = TURNS
  end

  def choose_code
    0..3.each do
      @code << COLORS.sample
    end
  end

  def game_over?(code_guess)
    code_guess == @code || @turns.zero?
  end

  def advance_turn
    @turns -= 1
  end

  def ask_code_guess
    code_guess = []
    until code_guess.lenght == 4
      puts("Choose four colors between #{COLORS}, separated by space")
      puts('E.g. red red white white')
      code_guess = gets.chomp.downcase.split(' ')
      return code_guess if code_guess.lenght == 4

      puts('Please follow the instructions!')
    end
  end
end

# Game start
game = Mastermind.new
game.choose_code

loop do
  code_guess = game.ask_code_guess
  game_over = game.game_over?(code_guess)
  if game_over
    return game.turns.zero? ? puts('Game Over: Codemaker wins!') : puts('Game Over: Codebreaker wins!')
  end

  code_guess.each do |color|

  end
end

# Ask player colors 1-4
# Check if guess is correct
# If correct, game over
# If not correct check if right color
# If right color check if right position
# If right position red pin + 1
# If right color but not right position white pin + 1
# If neither check next color
# If no color end turn
# If no more turns game over
# If turns > 0 repeat
