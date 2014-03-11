require_relative 'chess_files'

class ChessBoard

  def initialize(board = nil)
    @board = new_board
  end

  def new_board
    Array.new(8) { Array.new(8) }
  end

  def [](position)
    row, col = position
    self[row][col]
  end



end