class SlidingPiece < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def moves(start_position)
    moves = []
    row, col = start_position

    self.directions.each do |(row_shift, col_shift)|
      1.upto(7) do |mult|
        candidate_pos = [row + (row_shift * mult), col + (col_shift * mult)]
        # square = @board[candidate_pos]
        break unless on_board?(candidate_pos)

        if @board[candidate_pos].nil?
          moves << candidate_pos
        elsif @board[candidate_pos].color != self.color
          moves << candidate_pos
          break
        elsif @board[candidate_pos].color == self.color
          break
        end
      end
    end
    moves
  end

end

class Queen < SlidingPiece

  QUEEN_DELTAS = [
    [1, -1],
    [1, 0],
    [1, 1],
    [0, 1],
    [-1, 1],
    [-1, 0],
    [-1, -1],
    [0, -1]
  ]

  def initialize(position, board, color)
    super(position, board, color)
  end

  def directions
    QUEEN_DELTAS
  end

end

class Rook < SlidingPiece

  ROOK_DELTAS = [
    [1, 0],
    [0, 1],
    [-1, 0],
    [0, -1]
  ]

  def initialize(position, board, color)
    super(position, board, color)
  end

  def directions
    ROOK_DELTAS
  end

end

class Bishop < SlidingPiece

  BISHOP_DELTAS = [
    [1, -1],
    [1, 1],
    [-1, 1],
    [-1, -1]
  ]

  def initialize(position, board, color)
    super(position, board, color)
  end

  def directions
    BISHOP_DELTAS
  end

end