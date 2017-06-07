require 'unicode'
class CaesarsCipher
  attr_reader :alphabet, :string, :step

  def initialize(string, step, language = :en)
    @string = string
    @step   = step
    @language = language
    @alphabet = set_alphabet
    @idx = 0
  end

  def translate
    @string.chars.map do |char|
      convert_character(char)
    end.join
  end

  private

  def convert_character(char)
    return char if is_not_a_letter?(char)
    @idx = @alphabet.index(Unicode::downcase(char))
    new_letter = alphabet[(@idx+@step) % @alphabet.size]

    char == Unicode::downcase(char) ? new_letter : Unicode::upcase(new_letter)
  end

  def is_not_a_letter?(c)
    c !~ /\p{L}/
  end

  def set_alphabet
    if @language == :en
      ('a'..'z').to_a
    elsif @language == :ru
      ('а'..'я').to_a
    end
  end
end
