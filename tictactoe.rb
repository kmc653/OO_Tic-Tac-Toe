class Board
  WIN_CONDITION = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
                  [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @square = {}
    (1..9).each {|pos| @square[pos] = ' '}
  end

  def empty_position
    @square.select {|_, v| v == ' '}.keys
  end

  def mark_square(pos, marker)
    @square[pos] = marker
  end

  def draw_board
    system 'clear'
    puts " #{@square[1]} | #{@square[2]} | #{@square[3]} "
    puts "---+---+---"
    puts " #{@square[4]} | #{@square[5]} | #{@square[6]} "
    puts "---+---+---"
    puts " #{@square[7]} | #{@square[8]} | #{@square[9]} "
  end

  def same_marker_in_a_row?(marker)
    WIN_CONDITION.each do |arr|
       return true if arr & @square.select {|v,s| s == marker}.keys == arr
    end
    false
  end

  def all_square_marked?
    empty_position.length == 0
  end

end

class Player
  attr_accessor :marker, :name
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
  def initialize
    @board = Board.new
    @human = Player.new('kevin', 'O')
    @computer = Player.new('Computer', 'X')
    @current_player = @human
  end

  def current_player_marking
    if @current_player == @human
      begin
        puts "Choose a position (from 1 to 9) to place a piece:"
        position = gets.chomp.to_i
      end until @board.empty_position.include?(position)
    else
      position = @board.empty_position.sample
    end
    @board.mark_square(position, @current_player.marker)
  end

  def check_win_or_not
    @board.same_marker_in_a_row?(@current_player.marker)
  end

  def alter_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end
  
  def play
      @board.draw_board
      loop do  
        current_player_marking
        @board.draw_board
        if check_win_or_not
          puts "#{@current_player.name} won!"
          break
        elsif @board.all_square_marked?
          puts "It's a tie game!"
          break
        else
          alter_player
        end
      end
  end
end

begin
  Game.new.play
  puts "Play again? (Y/N)"
  decision = gets.chomp.downcase
end until decision != 'y'