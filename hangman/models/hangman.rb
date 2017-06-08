require 'yaml'

class Hangman

  attr_reader :secret_word, :incorrect_letters, :placeholder
  def initialize
    @number_of_lives = 10
    @state = ''
    @incorrect_letters = []
    @save_file = 'save.yml'
    guess_word
  end

  def play
    greeting
    guess_word unless @loaded
    loop do
      show_game_stats
      guess_letter
      change_placeholder if @secret_word.include?(@guess)
      break(puts "Bye!") if @guess == 'Q'
      @guess == 'S' ? save_game : take_one_life
      update_game_state
      check_game_state
    end
  end
  
  def lives
    @number_of_lives
  end

  def available_letters
    arr = []
    ('a'..'z').to_a.each do |l|
      arr <<  l unless @incorrect_letters.include?(l)
    end
    arr
  end

  def next_turn(letter)
    take_one_life
    change_placeholder
  end

  def save_game
    @save = YAML::dump(
      number_of_lives:  @number_of_lives,
      incorrect_letters: @incorrect_letters,
      placeholder: @placeholder,
      secret_word: @secret_word
    )
    File.open(@save_file, 'w') do |file|
      file.write(@save)
    end

    puts "Game is saved."
  end

  def load_game
    params = YAML::load_file('save.yml')
    @number_of_lives = params[:number_of_lives]
    @incorrect_letters = params[:incorrect_letters]
    @placeholder = params[:placeholder]
    @secret_word = params[:secret_word]

    @loaded = true
  end

  def update_game_state
    @state = 'lose' if @number_of_lives == 0
    @state = 'win' unless @placeholder.include?('_')
  end

  def show_game_stats
    puts "``````````````````"
    puts "Number of lives: #{@number_of_lives}"
    puts "Incorrect letters: #{@incorrect_letters.join(' ')}"
    puts "''''''''''''''''''"
  end


  def check_game_state
    if @state == 'lose'
      puts "Sorry, you lost!"
      puts "Secret word: #{@secret_word}"
      File.delete('save.yml') if File.exists?('save.yml')
      play_again?
    elsif @state == 'win'
      puts "Grats! You won!"
      play_again?
    end
  end

  def play_again?
    puts "Play again? [y/n]"
    decision = gets.strip.downcase
    play if decision == 'y'
    puts ("Goodbye!\n")
    exit
  end

  def take_one_life
    @number_of_lives -= 1
  end

  def find_indexes
    @indexes = @secret_word.chars.each_index.select { |i| @secret_word[i] == @guess }
  end

  def change_placeholder
    find_indexes
    @placeholder = @placeholder.chars.each_with_index.map do |letter,i|
      @indexes.include?(i) ? @guess : letter
    end.join('')
  end

  def greeting
    puts "Welcome to Hangman!"
    if File.exists?('save.yml')
      puts "Load last game? [y/n]"
      answer = gets.strip
      load_game if answer == 'y'
    end
  end

  def guess_letter
    puts @placeholder
    print "Make your guess! "
    @guess = gets.chomp
    validate(@guess)
    puts "Da" if @secret_word.include?(@guess)
    @incorrect_letters << @guess unless @guess == 'S'
  end

  def check_letter(letter)
    if @secret_word.include?(letter)
      change_placeholder
    else
      @incorrect_letters << letter
    end
  end

  def validate(input)
    loop do
      break if input.size == 1 && input =~ /[a-zSQ]/
      puts "Incorrect input. Please try again."
      input = gets.strip
    end
    @guess = input
  end

  def guess_word
    @secret_word =
      File.readlines('./5desk.txt')
      .map(&:strip)
      .select {|word| word.size > 4 && word.size < 13}
      .sample
      .downcase
    @placeholder = '_' * @secret_word.size
  end
end
