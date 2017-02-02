Player=Struct.new(:name,:score)
Peg=Struct.new(:color, :marked)

module Game
  
  def generate_code
    colors=[:blue, :red, :green, :yellow, :white, :orange]
    code=[]
    4.times do
      code << Peg.new(colors[rand(0..5)])
    end
    code
    end
    
  def create_guess text
    guess_array=text.split()   
    guess_array.map {|x| Peg.new(x.to_sym)}
    end
    
  def feedback guess,code
      exact_keys = 0 
      misplaced_keys = 0 
      no_match_keys = 0
     for i in 0..3
        if guess[i].color==code[i].color
        exact_keys+=1
        code[i].marked=true
        guess[i].marked=true
        end
      end
      code_remaining=code.select {|x| x.marked==nil}
      guess_remaining=guess.select {|x| x.marked==nil}
      
      guess_remaining.each do |x| 
        
        code_remaining.each do |y|
          
          if (x.color==y.color && y.marked==nil && x.marked==nil)
            y.marked=true
            x.marked=true
            misplaced_keys+=1
          end
        end
      end
      no_match_keys= (4 - misplaced_keys - exact_keys)
    puts "Exact matches: #{exact_keys}, Near matches:#{misplaced_keys}, No-matches: #{no_match_keys}"
    return exact_keys
    end
  
  def user_guessing
    
    code=generate_code
    exact_keys=0
    i=0
    while  i < 8
    
    code.each {|x| x.marked=nil}
    puts
    puts "Please enter 4 color keys, color options are : \nBlue Red Green Yellow White Orange"
    puts "#{8-i} guesses left"
    puts
    guess = create_guess gets.chomp.strip
    puts
    exact_keys=feedback guess,code
    break if exact_keys==4
    i+=1
    end
    exact_keys==4 ? puts('Wow!! You broke the code') : puts('You FAILED!!')
    puts "Code was #{(code.map {|x| x.color.to_s }).to_s}"
    
    end
    
    def computer_guessing
      
      puts "Please enter a secret code "
      
      code=create_guess gets.chomp.strip
    exact_keys=0
    i=0
    while  i < 8
    
    code.each {|x| x.marked=nil}
    puts
    puts "Computer guess is :"
    guess = generate_code
    puts " #{(guess.map {|x| x.color.to_s }).to_s}"
    puts
    exact_keys=feedback guess,code
    break if exact_keys==4
    i+=1
    puts "#{8-i} guesses left"
    puts
    end
    exact_keys==4 ? puts('Wow!! Computer broke the code') : puts('Computer FAILED!!')
    puts "Code was #{(code.map {|x| x.color.to_s }).to_s}"
    
    end
  
  def start_game
  
  puts "Would you like to (M)ake the code or (B)reak it?\n Please enter 'M' or 'B' as choice:"
  
  gets.chomp.downcase=="b" ? user_guessing : computer_guessing
    end
end

include Game

start_game