require_relative 'chess_files'

class SteppingPiece < Piece

  def initialize(position, board)
    super(position, board)
  end

  def moves(start_position, deltas)
    moves = []
    row, col = start_position

    deltas.each do |(row_shift, col_shift)|
      moves << [row + row_shift, col + col_shift]
    end

    moves.select{|move| super.include?(move)}

  end

end


class Knight < SteppingPiece

  KNIGHT_DELTAS = [
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2]
  ]

  def initialize(position, board)
    super(position, board)
  end

  def moves(start_position, KNIGHT_DELTAS)
    super
  end

end

class King < SteppingPiece

  KING_DELTAS = [
    [1, -1],
    [1, 0],
    [1, 1],
    [0, 1],
    [-1, 1],
    [-1, 0],
    [-1, -1],
    [0, -1]
  ]

  def initialize(position, board)
    super(position, board)
  end

  def moves(start_position, KING_DELTAS)
    super
  end

end

class Pawn < SteppingPiece
  # Special piece class, can't move backwards.
  # Will need to know which player is accessing this class
  # to choose the direction of DELTAS.
  # Currently we have DELTAS set for the player moving from
  # the top of the board downwards.
  # For the other player, multiply the row coordinate by -1.

  DELTAS = [
    [1, 0],
    [2, 0],
    [1, 1],
    [1, -1]
  ]

  def initialize(position, board)
    super(position, board)
  end

  def moves



  end

end

