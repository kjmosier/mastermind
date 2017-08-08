class EasyAI < CodeMaker

  def initialize
    #primary search
    #variables to establish quantity of which numbers are present
    @nums_present = Hash.new
    @trial_num = 1
    @primary_over = false
    #variables for secondary search
    @most_sig = 0
    @sig_count = 0
    @dummy = 0
    @answer = "xxxx"

    #duplicates from super since I cannot figure out how to get them to talk to eachother
    @ai_guesses = Array.new
    @ai_matches = Array.new
  end

#Directs which type of move to make: Primary or Secondary or submits answer when answer is complete.
  def move
    guess = nil
     if !@primary_over
       guess = primary_trials
     else
       final_answer = @answer.scan(/[1-6]/)
       final_answer.size == 4 ? guess = final_answer : guess = secondary_trials
     end
     guess
  end

#get_results rewrites @answer- if there is an "rnrp hit", the correct digit(1-6) will replace the trial "t"
#if there is no "hit" @answer's trial position "t" will be changed to 'n'  for "no hit"
  def get_results(hit)
    if hit == 1
       0.upto(3) do |i|
         if @answer[i] == "t"
           @answer[i] = @most_sig.to_s
           @sig_count -= 1
           break
         end
       end
     else
       @answer.sub! 't', 'n'
     end
  end

#secondary_trials returns a guess by testing an "RN" in each of the four positions until it locks into "RNRP"
#@dummy is used as filler to make a controlled test of each position
   def secondary_trials
     #If last test number is complete iterate to next test number
     set_significant if @sig_count == 0
     guess, hit = [] , false
     #create guess
     0.upto(3) do |i|
       if @answer[i] == "x"  && !hit
         guess << @most_sig.to_s
         @answer[i], hit = "t" , true
       else
         guess << @dummy.to_s
       end
     end
     guess
    end

  #primary_trials increments @trial_num and returns and array of trial_num until 4 matching digits have been recorded in @nums_present
  def primary_trials
    guess = @trial_num.to_s  * 4
    if !@ai_matches.empty? && @ai_matches[-1].reduce(:+) > 0
      @nums_present[@trial_num-1] = @ai_matches[-1].reduce(:+)     #trial_num -1 b/c it is incremented at end of array.  We are evaluating the previous guess
      if @nums_present.inject(0) { |sum, tuple| sum += tuple[1]} == 4
        @primary_over = true
        set_dummy
        set_significant
        return secondary_trials
      end
    end
    @trial_num += 1
    guess.scan(/[1-6]/)
  end


  #set_significant finds the key in @nums_present with greatest freq.
  #it will then set @most_sig to this digit and @sig_count to its freq.
  #it erases quantity of @most_sig so this digit will not be tested again
  #it resets @answer replacing 'n' - no hits from last test, with 'x' signifying 'untested/unknown'
  def set_significant
     @most_sig = @nums_present.key(@nums_present.values.max)
     @sig_count = @nums_present.values.max
     @nums_present[@most_sig] = 0
     @answer.gsub! 'n' , 'x'

  end

  #sets @dummy to a number which is proven to not exist in the code.
  def set_dummy
    unused = (1..6).to_a - @nums_present.keys
    @dummy = unused[-1]
  end


  #Setter function for super because I can't figure out a better way to do this!
  def add_ai_matches(arr)
    @ai_matches << arr
  end

end
