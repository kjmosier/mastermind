class Mastermind
# The Secret code are 4 digits (1-6).
# The response is of two types: 'RN' or 'RNRP'  (Right Number - Right Number Right Position)


#Returns true if the the code is matched or 12 turns have been used.
def game_over?(code, guess, moves_left)
  if code == guess || moves_left ==0
    puts "Solution: #{code.join('-')}"
    code == guess ? win_message : lose_message
    return false
  end
  return true
end


#display_moves  shows all of the guesses with corresponding results in RN  RNRP format
def display_moves(guesses, matches, moves_left)
  0.upto((guesses.length)-1) do |i|
    puts "#{guesses[i].join('-')}  RN: #{matches[i][1]} RNRP: #{matches[i][0]}"
  end
  puts "Remaing Guesses: #{moves_left}"
end



def win_message
  puts "\n\nYou Win!"

end

def lose_message
  puts "\n\nYou Lose!"
end

#evaluate takes the secret code and guess as parameters and will compare these to
#return the values of Right Position and Right Position Right Number
def evaluate(code, move)
   target = code.dup
   attempt = move.dup
   rnrp, rn = 0 , 0

   0.upto(3) do |i|
     if attempt[i] == target[i]
       rnrp += 1
       target[i] = "X"
       attempt[i] ="XXX"
     end
   end

   0.upto(3) do |i|
     0.upto(3) do |j|
       if attempt[j] == target[i]
         rn +=1
         target[i] = "Y"
         attempt[j] = "YYY"
       end
     end
   end
   [rnrp, rn]
end

#get_user_code will prompt player to make a guess and validate input
def get_user_code
  loop do
    puts "Please enter 4 -digits between within the range [1-6]"
    guess = [(print '?: '), gets.rstrip][1]
    scanned = guess.scan(/[1-6]/)
    return scanned if scanned.size == 4
    puts "Invalid input: #{guess}\n"
  end
end


#generate_random_code returns an array of four random digits (0-5)
def generate_random_code
  arr = Array.new
  4.times {arr << (rand(6) + 1).to_s}
  arr
end




end
