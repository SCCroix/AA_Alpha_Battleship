require_relative "board"
require_relative "player"

class Battleship
  attr_reader :board, :player

  def initialize(length)
    @player = Player.new
    @board = Board.new(length)
    @remaining_misses = @board.size / 2
  end

  def start_game
    @board.place_random_ships
    puts "#{@board.num_ships} ships on the board"
    @board.print
  end

  def lose?
    if @remaining_misses > 0
      return false
    else
      puts "you lose"
      return true
    end
  end

  def win?
    if @board.num_ships > 0
      return false
    else
      puts 'you win'
      return true
    end
  end

  def game_over?
    win? || lose?
  end

  def turn
    position = @player.get_move
    unless @board.attack(position)
      @remaining_misses -= 1
    end
    @board.print
    puts @remaining_misses
  end
end
