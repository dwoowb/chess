require_relative 'chess_files'

class SlidingPiece < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def moves(start_position, range = 1)
    moves = []
    row, col = start_position

    1.upto(range) do |mult|
      self.class.move_dirs.each do |(row_shift, col_shift)|
        moves << [row + (row_shift * mult), col + (col_shift * mult)]
      end
    end
    moves.select{|move| super.include?(move)}
  end
  end

end

class Queen < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def self.move_dirs
    [
      [1, -1],
      #[2, -2],

      [1, 0],
      [1, 1],
      [0, 1],
      [-1, 1],
      [-1, 0],
      [-1, -1],
      [0, -1]
    ]
  end

end

class Rook < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

end

class Bishop < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
  end

end