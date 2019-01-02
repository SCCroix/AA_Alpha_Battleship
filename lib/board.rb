require "byebug"

class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) { Array.new(n, :N) }
    @size = n * n
  end

  def [] (arr)
    @grid[arr[0]][arr[1]]
  end

  def []=(arr,el)
    @grid[arr[0]][arr[1]] = el
  end

  def num_ships
    @grid.flatten.count(:S)
  end

  def attack(pos)
    if self[pos] == :S
      self[pos] = :H
      puts "you sunk my battleship"
      return true
    else
      self[pos] = :X
      return false
    end
  end

  def place_random_ships
    #debugger
    num_ships = @size / 4
    n =  @grid.length
    positions = (0...@size).to_a.sample(num_ships)
    positions.each { |position| self[[(position / n), (position % n)]] = :S }
  end

  def hidden_ships_grid
    @grid.map do |row|
      row.map do |col|
        if col == :S
          :N
        else
          col
        end
      end
    end
  end

  def self.print_grid(arr_2d)
    arr_2d.each do |row|
      puts row.join(" ")
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end

end
