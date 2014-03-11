class SteppingPiece < Piece

  def initialize(position, board, color)
    super(position, board, color)
  end

  def moves(start_position)
    moves = []
    row, col = start_position

    self.deltas.each do |(row_shift, col_shift)|
      candidate_pos = [row + row_shift, col + col_shift]

      if on_board?(candidate_pos)
        if @board[candidate_pos].nil?
          moves << candidate_pos
        elsif @board[move].color != self.color
           moves << candidate_pos
        end
      end
    end

    moves
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

  def initialize(position, board, color)
    super(position, board, color)
  end

  def deltas
    KNIGHT_DELTAS
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

  def initialize(position, board, color)
    super(position, board, color)
  end

  def deltas
    KING_DELTAS
  end

end

class Pawn < SteppingPiece
  # Special piece class, can't move backwards.
  # Will need to know which player is accessing this class
  # to choose the direction of DELTAS.
  # Currently we have DELTAS set for the player moving from
  # the top of the board downwards.
  # For the other player, multiply the row coordinate by -1.

  BLACK_PAWN_DELTAS = [
    [1, 0],
    [2, 0],
    [1, 1],
    [1, -1]
  ]

  WHITE_PAWN_DELTAS = [
    [-1, 0],
    [-2, 0],
    [-1, 1],
    [-1, -1]
  ]


  def initialize(position, board, color)
    super(position, board, color)
  end

  def moves(start_position)
    if self.color == :white
      white_moves(start_position)
    else
      black_moves(start_position)
    end
  end

  def white_moves(start_position)
    moves = []
    row, col = start_position

    WHITE_PAWN_DELTAS.each do |(row_shift, col_shift)|
      candidate_pos = [row + row_shift, col + col_shift]

      if on_board?(candidate_pos)

        if [row_shift, col_shift].any?{|shift| shift == 0}
          if row_shift == -2 && @position[0] == 6
            moves << candidate_pos if @board[candidate_pos].nil?
          else
            moves << candidate_pos if @board[candidate_pos].nil?
          end
        else
          if @board[candidate_pos] && @board[candidate_pos].color != self.color
            moves << candidate_pos
          end
        end

      end
    end

    moves
  end

  def black_moves(start_position)
    moves = []
    row, col = start_position

    BLACK_PAWN_DELTAS.each do |(row_shift, col_shift)|
      candidate_pos = [row + row_shift, col + col_shift]

      if on_board?(candidate_pos)

        if [row_shift, col_shift].any?{|shift| shift == 0}
          if row_shift == 2 && @position[0] == 1
            moves << candidate_pos if @board[candidate_pos].nil?
          else
            moves << candidate_pos if @board[candidate_pos].nil?
          end
        else
          if @board[candidate_pos] && @board[candidate_pos].color != self.color
            moves << candidate_pos
          end
        end

      end
    end

    moves
  end


end

