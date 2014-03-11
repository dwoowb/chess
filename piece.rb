class Piece

  attr_reader :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def moves
    #BULLSHIT
  end

  def on_board?(position)
    poss_positions = []
    @board.grid.each_with_index do |row, idx|
      row.each_index do |col|
        poss_positions << [idx, col]
      end
    end

    poss_positions.include?(position)
  end

end