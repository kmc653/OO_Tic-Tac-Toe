#1. Ask player's name and draw a @square, start to play

require 'pry'

class Square
  attr_reader :value
  def initialize(v)
    @value = v
  end

  def empty?
    @value = ' '
  end

  def mark(marker)
    @value = marker
  end

  def to_s
    @value
  end
end

class Board
  attr_reader :square

  win_condition = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
                  [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @square = {}
    (1..9).each {|pos| @square[pos] = Square.new(' ')}
  end

  def empty_position
    @square.select {|_, v| v.empty?}.keys
  end

  def empty_square
    
  end

  def mark_square(pos, marker)
    @square[pos].mark(marker)
  end

  def draw_board
    system 'clear'
    puts " #{@square[1]} | #{@square[2]} | #{@square[3]} "
    puts "---+---+---"
    puts " #{@square[4]} | #{@square[5]} | #{@square[6]} "
    puts "---+---+---"
    puts " #{@square[7]} | #{@square[8]} | #{@square[9]} "
  end
end

class Player
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end
end

class Human < Player
  def human_marking(board)
    begin
      puts "Choose a position (from 1 to 9) to place a piece:"
      human_input = gets.chomp.to_i
    end until board.empty_position.include?(human_input)
    board.mark_square(human_input, self.marker)
  end
end

class Computer < Player
  def computer_marking(board)
    position = board.empty_position.sample
    board.mark_square(position, self.marker)



  end
end

class Game
  #attr_accessor :@square, :player, :computer
  def initialize
    @board = Board.new
    @human = Human.new('O')
    @computer = Computer.new('X')
  end

  def play
    @board.draw_board
    #begin  
    @human.human_marking(@board)
    @board.draw_board
    puts @board.square
    #binding.pry
    # @computer.computer_marking(@board)
    # @board.draw_board
    # puts @board.square
    #end

  end
end


Game.new.play