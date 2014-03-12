

class Game

  def self.setup_game
    puts "Please enter a name for player 1"
      player1 = HumanPlayer.new(gets.strip, :black)
    puts "Please enter a name for player 2"
      player2 = HumanPlayer.new(gets.strip, :white)
    Game.new(player1, player2, ChessBoard.new.setup_board)
  end



  def initialize(player1, player2, board)
    @board = board
    @player1 = player1
    @player2 = player2
  end


  def play
    puts "Let the games begin!"
    loop do
      break if checkmate?(player1.color)
      @player1.play_turn
      #call render after each play_turn

      break if checkmate?(player2.color)
      @player2.play_turn
      #call render after each play_turn
    end

    if @board.checkmate?(player1.color)
          puts "#{player2.name} wins!"
    elsif @board.checkmate?(player1.color)
          puts "#{player1.name} wins!"
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
    "1" => 0,
    "2" => 1,
    "3" => 2,
    "4" => 3,
    "5" => 4,
    "6" => 5,
    "7" => 6,
    "8" => 7
  }


  def initialize(name, color)
    @name = name
    @color = color.to_sym
  end

  #could have a factory method here to instantiate new players

  def play_turn
    begin
    puts "Please input your starting and ending positions, Ex: f2,f3"
    user_input = gets.chomp.downcase.scan(/\w/) # array: ["f", "2", "f", "3"]
    # consider adding a InvalidMove check for bad input, (bad_input != bad_coord) e.g. 12, 8f
    start_pos = [USER_INPUT[user_input[1]], USER_INPUT[user_input[0]]]
    end_pos = [USER_INPUT[user_input[3]], USER_INPUT[user_input[2]]]

    move(start_pos, end_pos)
    rescue InvalidMove => e
      puts "Invalid move: #{e.message}"
      retry
    end
  end


end
