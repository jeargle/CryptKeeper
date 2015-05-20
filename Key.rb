

# Need to refactor classes into Alphabet, Key, and Cracker
#   Alphabet: characters involved in cypher
#   Key: encrypts and decrypts; modifiable
#   Cracker: engine for cracking encryption; returns a new key

# Cracked by StatCracker
#   Use a hash for a simple char=>char code
class CustomKey

  def initialize(hash)
    @keyHash = hash
  end

  def encrypt(message)
    cypherText = ""
    message.each_byte do |i|
      if @keyHash.has_key?(i.chr) then
	cypherText = cypherText + @keyHash[i.chr]
      else
	cypherText = cypherText + i.chr
      end
    end
    return cypherText
  end

  def decrypt(cypherText)
    message = ""
    cypherText.each_byte do |i|
      if @keyHash.has_value?(i.chr) then
	message = message + @keyHash.index(i.chr)
      else
	message = message + i.chr
      end
    end
    return message
  end

end


# Cracked by RotCracker
#   Use a code which is simply the provided alphabet rotated by some
#   offset.
class RotKey

  attr_reader :offset, :alphabet

  def initialize(alphabet, offset)
    #puts alphabet
    @keyHash = Hash.new()
    (0..alphabet.length-1).each do |i|
      #puts i
      #puts alphabet[i].chr
      @keyHash[alphabet[i].chr] = alphabet[(i+offset)%alphabet.length].chr
    end
  end

  def encrypt(message)
    cypherText = ""
    message.each_byte do |i|
      #puts i
      if @keyHash.has_key?(i.chr) then
	cypherText = cypherText + @keyHash[i.chr]
      else
	cypherText = cypherText + i.chr
      end
    end
    return cypherText
  end

  def decrypt(cypherText)
    message = ""
    cypherText.each_byte do |i|
      if @keyHash.has_value?(i.chr) then
	message += @keyHash.index(i.chr)
      else
	message += i.chr
      end
    end
    return message
  end

end


# Cracked by VigenereKey
#   Need alphabet and keyword for cycling through the alphabet.
class VigenereKey

  attr_reader :key, :alphabet

  def initialize(key, alphabet)
    @key = key
    @alphabet = alphabet
    # XXX - check that all key characters are in alphabet
  end

  def encrypt(message)
    cypherText = ""
    keyIndex = 0
    message.each_byte do |i|
      if (@alphabet.include?(i.to_s)) then
	keyOffset = @alphabet.index(@key[keyIndex])
	if (keyIndex < @key.length-1) then
	  keyIndex += 1
	else
	  keyIndex = 0
	end
	alphabetIndex = (@alphabet.index(i) + keyOffset) % @alphabet.length
	cypherText += @alphabet[alphabetIndex].chr
      else
	cypherText += i.chr
      end
    end
    return cypherText
  end

  def decrypt(cypherText)
    message = ""
    keyIndex = 0
    cypherText.each_byte do |i|
      if (@alphabet.include?(i.to_s)) then
	keyOffset = @alphabet.index(@key[keyIndex])
	if (keyIndex < @key.length-1) then
	  keyIndex += 1
	else
	  keyIndex = 0
	end
	alphabetIndex = (@alphabet.index(i) - keyOffset) % @alphabet.length
	message += @alphabet[alphabetIndex].chr
      else
	message += i.chr
      end
    end
    return message
  end

end


# 
class HomophonicKey

  def initialize

  end

  def encrypt

  end

  def decrypt

  end

end


