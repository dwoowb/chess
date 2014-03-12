class ChessBoard

  BLACK_UNICODE = {
    "King"   => "\u265A",
    "Queen"  => "\u265B",
    "Rook"   => "\u265C",
    "Bishop" => "\u265D",
    "Knight" => "\u265E",
    "Pawn"   => "\u265F"
  }

  WHITE_UNICODE = {
    "King"   => "\u2654",
    "Queen"  => "\u2655",
    "Rook"   => "\u2656",
    "Bishop" => "\u2657",
    "Knight" => "\u2658",
    "Pawn"   => "\u2659"
  }

  attr_reader :grid

  def initialize(grid = nil)
    @grid = new_grid
  end

  def new_grid
    Array.new(8) { Array.new(8) }
  end

  def [](position)
    row, col = position
    self.grid[row][col]
  end

  def []=(position, object)
    row, col = position
    self.grid[row][col] = object
  end

  def move!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[end_pos].position = end_pos
  end

  def move(start_pos, end_pos, turn_color)

    if self[start_pos].nil?
      raise InvalidMove.new("There is no piece at that starting position.")
    elsif self[start_pos].moves(start_pos).include?(end_pos) == false
      raise InvalidMove.new("This piece cannot move to that position.")
    elsif self[start_pos].move_into_check?(end_pos)
      raise InvalidMove.new("This move would put you in check.")
    elsif self[start_pos].color != turn_color
      raise InvalidMove.new("This isn't your piece to move!")
    else
      move!(start_pos, end_pos)
    end
  end

  def board_dup
    dup_board = ChessBoard.new
    dup_piece, dup_position = nil, nil

    self.grid.each_with_index do |array, row|
      array.each_with_index do |piece, col|
        if piece
          dup_position = piece.position.dup
          dup_piece = piece.class.new(dup_position, dup_board, piece.color)
          dup_board[dup_position] = dup_piece
        else
          dup_board[[row,col]] = nil
        end
      end
    end
    dup_board
  end

  def king_position(color)
    self.grid.flatten.select do |piece|
      piece.class == King && piece.color == color
    end.first.position
  end

  def enemy_moves(color)
    enemy_moves = []

    self.grid.flatten.select do |square|
      square
    end.select do |piece|
      piece.color != color
    end.each do |enemy|
      enemy_moves += enemy.moves(enemy.position)
    end
    enemy_moves
  end

  def ally_moves(color)
    all_valid_moves = []

    self.grid.flatten.select do |square|
      square
    end.select do |piece|
      piece.color == color
    end.each do |ally|
       all_valid_moves += ally.valid_moves
    end
    all_valid_moves
  end

  def in_check?(color)
    return true if enemy_moves(color).include?(king_position(color))
    false
  end

  def checkmate?(color)
    return false unless in_check?(color)
    ally_moves(color).empty?
  end

  def piece_color(square, unicode_color, bg_color)
    unicode_piece = unicode_color[square.class.to_s]
    print " #{unicode_piece} ".colorize(:background => bg_color)
  end

  def square_color(square, bg_color)
    if square.nil?
      print "   ".colorize(:background => bg_color)
    else
      if square.color == :white
        piece_color(square, WHITE_UNICODE, bg_color)
      else
        piece_color(square, BLACK_UNICODE, bg_color)
      end
    end
  end

  def render
    color_counter = 0
    row_counter = 8

    self.grid.each_with_index do |array, row|
      print "#{row_counter} "
      color_counter += 1
      array.each_with_index do |square, col|
        if color_counter.even?
          square_color(square, :light_red)
        else
          square_color(square, :white)
        end
        color_counter += 1
      end
      puts
      row_counter -= 1
    end
    print "   a  b  c  d  e  f  g  h \n\n"
  end



  def setup_board
    @grid[1].each_index do |pawn_col|
      self[[1, pawn_col]] = Pawn.new([1, pawn_col], self, :black)
    end

    @grid[6].each_index do |pawn_col|
      self[[6, pawn_col]] = Pawn.new([6, pawn_col], self, :white)
    end

    self[[0,0]] = Rook.new([0, 0],   self, :black)
    self[[0,7]] = Rook.new([0, 7],   self, :black)
    self[[7,0]] = Rook.new([7, 0],   self, :white)
    self[[7,7]] = Rook.new([7, 7],   self, :white)

    self[[0,2]] = Bishop.new([0, 2], self, :black)
    self[[0,5]] = Bishop.new([0, 5], self, :black)
    self[[7,2]] = Bishop.new([7, 2], self, :white)
    self[[7,5]] = Bishop.new([7, 5], self, :white)

    self[[0,1]] = Knight.new([0, 1], self, :black)
    self[[0,6]] = Knight.new([0, 6], self, :black)
    self[[7,1]] = Knight.new([7, 1], self, :white)
    self[[7,6]] = Knight.new([7, 6], self, :white)

    self[[0,4]] = King.new([0, 4],   self, :black)
    self[[7,4]] = King.new([7, 4],   self, :white)

    self[[0,3]] = Queen.new([0, 3],  self, :black)
    self[[7,3]] = Queen.new([7, 3],  self, :white)

    self
  end

end