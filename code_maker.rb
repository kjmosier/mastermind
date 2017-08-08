class CodeMaker < Mastermind


  def initialize
    @code =  nil
    @moves_left = 12
    @guesses = Array.new
    @matches = Array.new
  end


  def play
    puts "Create the Secret Code Now."
    @code = get_user_code
    playing = true
    ai = EasyAI.new
     until !playing
       puts "Press any key to see AI's next move:"
       gets
       move = ai.move
       @guesses << move
       @matches << evaluate(@code, move)
       ai.add_ai_matches(@matches[-1])
       ai.get_results(@matches[-1][0])
       @moves_left -= 1
       display_moves(@guesses, @matches, @moves_left)
       playing = game_over?(@code, @guesses[-1] ,@moves_left)
     end
  end


end
