class ChessBoard

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

  def setup_board

    @grid[1].each_index do |pawn_col|
      self[[1, pawn_col]] = Pawn.new([1, pawn_col], self, :black)
    end

    @grid[6].each_index do |pawn_col|
      self[[6, pawn_col]] = Pawn.new([6, pawn_col], self, :white)
    end

    self[[0,0]] = Rook.new([0, 0], self, :black)
    self[[0,7]] = Rook.new([0, 7], self, :black)
    self[[7,0]] = Rook.new([7, 0], self, :white)
    self[[7,7]] = Rook.new([7, 7], self, :white)

    self[[0,2]] = Bishop.new([0, 2], self, :black)
    self[[0,5]] = Bishop.new([0, 5], self, :black)
    self[[7,2]] = Bishop.new([7, 2], self, :white)
    self[[7,5]] = Bishop.new([7, 5], self, :white)

    self[[0,1]] = Knight.new([0, 1], self, :black)
    self[[0,6]] = Knight.new([0, 6], self, :black)
    self[[7,1]] = Knight.new([7, 1], self, :white)
    self[[7,6]] = Knight.new([7, 6], self, :white)

    self[[0,4]] = King.new([0, 4], self, :black)
    self[[7,4]] = King.new([7, 4], self, :white)

    self[[0,3]] = Queen.new([0, 3], self, :black)
    self[[7,3]] = Queen.new([7, 3], self, :white)

  end

  def render

    grid.each do |row|
      row.each do |obj|
        p obj.class
      end
      print "\n\n"
    end

  end



end