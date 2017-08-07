require_relative "easy_ai"

class CodeMaker  < Mastermind

  def initialize
    @moves_left = 12
    @code =  nil
    @guesses = Array.new
    @matches = Array.new
    play
  end


  def play
    puts "Create the Secret Code Now."
    @code = get_user_code
    playing = true
     until !playing
       ai = EasyAI.new
       puts "Press any key to see AI's next move:"
       gets
       evaluate(ai.move)
       win = display_moves
       playing = false if win != "unknown"
    #   @guesses << move
    #   @matches << evaluate(move)
    #   @moves_left -= 1
    #   win = display_moves
    #   playing = false if win != "unknown"
     end
  end


end
