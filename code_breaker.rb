class CodeBreaker < Mastermind



def initialize
  @moves_left = 12
  @code =   generate_random_code #["0","4","3","1"]
  @guesses = Array.new
  @matches = Array.new
  play
end



def play
  playing = true
  until !playing
    move = get_user_code
    @guesses << move
    @matches << evaluate(move)
    @moves_left -= 1
    win = display_moves
    playing = false if win != "unknown"
  end
end


end
