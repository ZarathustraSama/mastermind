# frozen_string_literal: true

COLORS = %w[red green blue yellow white purple].freeze
TURNS = 12

# Both the logic and the opponent of the game
class Mastermind
  attr_accessor :code, :turns

  def initialize
    @code = %w[]
    @turns = TURNS
  end

  def choose_code
    4.times do
      @code << COLORS.sample
    end
  end

  def game_over?(code_guess)
    code_guess == @code
  end

  def advance_turn
    @turns -= 1
  end

  def ask_code_guess
    code_guess = []
    until code_guess.length == 4
      puts("Choose four colors between #{COLORS.join(', ')}, separated by space")
      puts("E.g. red red white white\n\n")
      code_guess = gets.chomp.downcase.split(' ')
      return code_guess if code_guess.length == 4

      puts("\nPlease follow the instructions!\n\n")
    end
  end

  def check_guess(code_guess)
    pins = %w[No No No No]
    tmp_code = @code
    update_pins(code_guess, tmp_code, pins)
    pins
  end

  def update_pins(code_guess, tmp_code, pins)
    check_perfect_match(code_guess, tmp_code, pins)
    check_partial_match(code_guess, tmp_code, pins)
  end

  def check_perfect_match(code_guess, tmp_code, pins)
    code_guess.each_with_index do |_color, index|
      if code_guess[index] == tmp_code[index]
        pins[index] = 'Yes'
        tmp_code[index] = nil
      end
    end
  end

  def check_partial_match(code_guess, tmp_code, pins)
    code_guess.each_with_index do |color, index|
      if tmp_code.include?(color)
        pins[index] = 'Kinda'
        tmp_code[tmp_code.index(color)] = nil
      end
    end
  end
end

# Game start
game = Mastermind.new
game.choose_code

loop do
  code_guess = game.ask_code_guess
  game_over = game.game_over?(code_guess)
  return puts('Game Over: Codebreaker wins!') if game_over

  puts("\n#{game.check_guess(code_guess).join(' ')}\n\n")
  game.advance_turn
  return puts('Game Over: Codemaker wins!') if game.turns.zero?
end
