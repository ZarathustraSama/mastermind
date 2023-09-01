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
    4.times { @code << COLORS.sample }
  end

  def game_over?(code_guess)
    code_guess == @code
  end

  def advance_turn
    @turns -= 1
  end

  def check_guess(code_guess)
    pins = { Yes: 0, Kinda: 0 }
    tmp_code = @code.clone
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
        pins[:Yes] += 1
        tmp_code[index] = nil
      end
    end
  end

  def check_partial_match(code_guess, tmp_code, pins)
    code_guess.each do |color|
      if tmp_code.include?(color)
        pins[:Kinda] += 1
        tmp_code[tmp_code.index(color)] = nil
      end
    end
  end

  def create_all_sets
    COLORS.product(COLORS, COLORS, COLORS)
  end

  def break_code
    initial_guess = %w[red red green green]
  end
end

# Everything that handles user input
class Player
  def ask_code
    loop do
      puts("Choose four colors between #{COLORS.join(', ')}, separated by space\nE.g. red red green green\n\n")
      code = gets.chomp.downcase.split(' ')
      return code if code.all? { |color| correct_color?(color) } && code.length == 4

      puts("\nPlease follow the instructions!\n\n")
    end
  end

  def correct_color?(color)
    COLORS.include?(color) ? true : false
  end

  def code_maker?
    loop do
      puts("Do you want to be the codemaker or the codebreaker?\n\n")
      choice = gets.chomp.downcase
      if choice == 'codemaker'
        return true
      elsif choice == 'codebreaker'
        return false
      end

      puts("\nPick a side!")
    end
  end
end

# Game start
game = Mastermind.new
player = Player.new

if player.code_maker?
  game.code = player.ask_code
  game.break_code
else
  game.choose_code
  loop do
    code_guess = player.ask_code
    return puts("\nGame Over: Codebreaker wins!") if game.game_over?(code_guess)

    pins = game.check_guess(code_guess)
    puts("\nYes: #{pins[:Yes]}, Kinda: #{pins[:Kinda]}\n\n")
    game.advance_turn
    return puts("\nGame Over: Codemaker wins!") if game.turns.zero?
  end
end
