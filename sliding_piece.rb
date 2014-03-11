require_relative 'chess_files'

class SlidingPiece < Piece

  def initialize(position)
    super(position) #is this the way it should inherit?

  end

  def moves

  end


end

class King < SlidingPiece

end

class Queen < SlidingPiece

end

class Rook < SlidingPiece

end

class Bishop < SlidingPiece

end