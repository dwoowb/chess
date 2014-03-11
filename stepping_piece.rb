require_relative 'chess_files'

class SteppingPiece < Piece

  def initialize(position)
    super(position) #is this the way it should inherit?

  end

  def moves
    super
  end


end


class Knight < SteppingPiece

end

class Pawn < SteppingPiece

end

