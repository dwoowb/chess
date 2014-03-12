class Piece

  attr_reader :color
  attr_accessor :position

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def moves
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

  def move_into_check?(end_position)
    dup_board = @board.board_dup
    dup_board.move!(self.position, end_position)
    dup_board.in_check?(self.color)
  end

  def valid_moves
    self.moves(self.position).select do |position|
      !move_into_check?(position)
    end
  end

end