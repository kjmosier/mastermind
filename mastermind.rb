class Mastermind
# The Secret code are 4 digits 1-6 to represent colors
# The response is of two types: 'RN' or 'RNRP'  (Right Number - Right Position)

#Shows log of guesses made and the evaluation of that guess in RN: RNRP
def display_moves
  win = "unknown"
  0.upto((@guesses.length)-1) do |i|
    puts "#{@guesses[i].join('-')}  RN: #{@matches[i][1]} RNRP: #{@matches[i][0]}"
    if @matches[i][0] == 4
      win = "yes"
      puts "\n\nYou Win!"
    end
  end
  if @moves_left == 0
    puts "Solution: #{@code.join('-')}"
    if win == "unknown"
      win = "no"
      puts "\n\nYou Lose!"
    end
   else
     puts "Remaing Guesses: #{@moves_left}"
   end
  win
end


#Returns values of Right Position and Right Color
def evaluate(move)
  puts "here is the move incoming format #{move}"
   target = @code.dup
   attempt = move.dup
   rnrp = 0
   rn = 0
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




#evaluate: checks incoming array and compares to hidden @code.  Returns number of matches in RN RNRP format
# def evaluate2(move)
# #  puts "Move #{move}   Code: #{@code}"
#   hits = [0, 0, 0, 0]
#   0.upto(3) do |i|
#       puts "NEXT BLOCK"
#     0.upto(3) do |j|
#       puts "evaluating move: #{move[j]} and code: #{@code[i]}"
#       temp_hit = []
#       if i == j && move[j] == @code[i]
#         hits[i] += 5
#         if temp_hit
#           temp_hit.each {|x| hits[x] = 0 }
#         end
#       elsif move[j] == @code[i] && hits[i] == 0
#         hits[i] += 1
#         temp_hit << i
#         puts "Hit move #{move[j]} and code: #{@code[i]}"
#       end
#       puts "hits = #{hits}"
#     end
#   end
#   hits
#   rnrp = hits.select{|n| n > 4}.size
#   rn = hits.select{|n| n ==1 }.size
#   [rnrp, rn]
# end
