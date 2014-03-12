require_relative 'piece'
require_relative 'stepping_piece'
require_relative 'sliding_piece'
require_relative 'chess_board'
require_relative 'game'
require_relative 'exceptions'


# cb = ChessBoard.new
# q = Queen.new([0,0], cb, :black)
# r = Rook.new([0,0], cb, :black)
# b = Bishop.new([0,0], cb, :black)
# n = Knight.new([0,0], cb, :black)
# k = King.new([0,0], cb, :black)
# q.moves([0,0])
# r.moves([0,0])
# b.moves([0,0])
# n.moves([0,0])
# k.moves([5,5])

# pb = Pawn.new([1,0], cb, :black)
# pw = Pawn.new([6,0], cb, :white)
# pb.moves([1,0])
#
# cb = ChessBoard.new
# db = cb.board_dup