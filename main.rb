require_relative "mastermind"
require_relative "code_maker"
require_relative "code_breaker"


puts "Welcome to Mastermind"
playing = true

while playing
  puts "M to be Code Maker, B to be Code Breaker"
  option = [(print '=>'), gets.rstrip][1]
  option == 'm'  ? game = CodeMaker.new :  game = CodeBreaker.new
  puts "Press any key to play again or 'Q' to quit:"
  selection = [(print '?: '), gets.rstrip][1]
  playing = false if selection.downcase == "q"
  puts "\n\n\n\n\n"
end
