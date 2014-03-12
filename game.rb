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

  def turn(curr_player, next_player, turn_color)
    puts "#{curr_player.name}'s turn:"
    curr_player.play_turn(turn_color)
    @board.render
    puts "Check!" if @board.in_check?(next_player.color)
  end

  def play
    puts "    Let the games begin!"
    puts
    @board.render

    loop do
      break if @board.checkmate?(@player1.color)
      turn(@player1, @player2, @player1.color)
      break if @board.checkmate?(@player2.color)
      turn(@player2, @player1, @player2.color)
    end

    @board.checkmate?(@player1.color) ? win(@player2) : win(@player1)
  end

  def win(player)
    puts "Checkmate! #{player.name} wins!"
  end

end


class HumanPlayer

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

  attr_reader :name, :color

  def initialize(name, color, board)
    @name = name
    @color = color
    @board = board
  end

  def play_turn(turn_color)
    begin
    puts "Please input your starting and ending positions, Ex: f2,f3"
    user_input = gets.chomp.downcase

    unless user_input =~ /^[a-h][1-8],*[a-h][1-8]$/
      raise InvalidMove.new("Letter-number, letter-number, it's not hard!")
    end

    start_pos = [USER_INPUT[user_input[1]], USER_INPUT[user_input[0]]]
    end_pos = [USER_INPUT[user_input[3]], USER_INPUT[user_input[2]]]

    @board.move(start_pos, end_pos, turn_color)
    rescue InvalidMove => e
      puts "Invalid move: #{e.message}"
      retry
    end
    puts
  end


end
