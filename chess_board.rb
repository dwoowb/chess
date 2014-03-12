class ChessBoard

  attr_reader :grid

  BLACK_UNICODE = {
    "Queen"  => "\u265A",
    "King"   => "\u265B",
    "Rook"   => "\u265C",
    "Bishop" => "\u265D",
    "Knight" => "\u265E",
    "Pawn"   => "\u265F"
  }

  WHITE_UNICODE = {
    "Queen"  => "\u2654",
    "King"   => "\u2655",
    "Rook"   => "\u2656",
    "Bishop" => "\u2657",
    "Knight" => "\u2658",
    "Pawn"   => "\u2659"
  }

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

  def render
    @grid.each do |row|
      row.each do |obj|
        p obj.class
      end
      puts
    end
  end

  def in_check?(color)

    king_position = @grid.flatten.select do |piece|
      piece.class == King && piece.color == color
    end.first.position
  # could possibly break out into its own method ^
    enemy_moves = []

    @grid.flatten.select do |piece|
      piece.color != color
    end.each do |enemy|
      enemy_moves += enemy.moves
    end

    return true if enemy_moves.include?(king_position)
    false
  end

  def move(start_pos, end_pos)

    if self[start_pos].nil?
      raise InvalidMove.new("There is no piece at that starting position.")
    elsif self[start_pos].moves.include?(end_pos) == false
      raise InvalidMove.new("This piece cannot move to that position.")
    elsif self[start_pos].move_into_check?(end_pos)
      raise InvalidMove.new("This move would put you in check.")
    else
      self[end_pos] = self[start_pos]
      self[start_pos] = nil
      self[end_pos].position = end_pos
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
          # Hopefully updating the dup_board will update the dup_piece's board attribute.
        else
          dup_board[[row,col]] = nil
        end
      end
    end
    dup_board
  end

  def checkmate?(color)
    return false unless in_check?(color)
    all_valid_moves = []

    @grid.flatten.select do |piece|
      piece.color == color
    end.each do |piece|
       all_valid_moves += piece.valid_moves
    end

    all_valid_moves.empty?
  end

  def render

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
  end


end