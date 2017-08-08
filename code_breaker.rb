class CodeBreaker < Mastermind

def initialize
  @moves_left = 12
  @code =   generate_random_code #["0","4","3","1"]
  @guesses = Array.new
  @matches = Array.new
end


def play
  playing = true
  until !playing
    move = get_user_code
    @guesses << move
    @matches << evaluate(@code, move)
    @moves_left -= 1
    display_moves(@guesses, @matches, @moves_left)
    playing = game_over?(@code, @guesses[-1], @moves_left)
  end
end


end
