require_relative 'chess_files'

class Piece

  attr_reader :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def moves
    #new_position.all? { |coord| coord.between?(0,7) }
    poss_positions = []
    @board.each do |row|
      row.each do |col|
        poss_positions << [row, col]
      end
    end

    poss_positions
  end


end