

class Game

  attr_reader :board

  def self.setup_game
    new_board = ChessBoard.new.setup_board
    puts "Please enter a name for player 1"
      player1 = HumanPlayer.new(gets.strip, :white, new_board)
    puts "Please enter a name for player 2"
      player2 = HumanPlayer.new(gets.strip, :black, new_board)
    Game.new(player1, player2, new_board)
  end

  def initialize(player1, player2, board)
    @board = board
    @player1 = player1
    @player2 = player2
  end


  def play
    puts "Let the games begin!"
    @board.render

    loop do
      break if @board.checkmate?(@player1.color)
      @player1.play_turn
      @board.render
      puts "Check!" if @board.in_check?(@player2.color)

      break if @board.checkmate?(@player2.color)
      @player2.play_turn
      @board.render
      puts "Check!" if @board.in_check?(@player1.color)
    end
    # refactor these into methods that take player objects

    if @board.checkmate?(@player1.color)
          puts "#{@player2.name} wins!"
    elsif @board.checkmate?(@player2.color)
          puts "#{@player1.name} wins!"
    end
  end


end


class HumanPlayer

  attr_reader :name, :color

  USER_INPUT = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7,
    "8" => 0,
    "7" => 1,
    "6" => 2,
    "5" => 3,
    "4" => 4,
    "3" => 5,
    "2" => 6,
    "1" => 7
  }


  def initialize(name, color, board)
    @name = name
    @color = color
    @board = board
  end

  #could have a factory method here to instantiate new players

  def play_turn
    begin
    puts "Please input your starting and ending positions, Ex: f2,f3"
    user_input = gets.chomp.downcase.scan(/\w/) # array: ["f", "2", "f", "3"]
    # consider adding a InvalidMove check for bad input, (bad_input != bad_coord) e.g. 12, 8f
    start_pos = [USER_INPUT[user_input[1]], USER_INPUT[user_input[0]]]
    end_pos = [USER_INPUT[user_input[3]], USER_INPUT[user_input[2]]]

    @board.move(start_pos, end_pos)
    rescue InvalidMove => e
      puts "Invalid move: #{e.message}"
      retry
    end
  end


end
