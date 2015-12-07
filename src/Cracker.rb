

# Need to refactor classes into Alphabet, Key, and Cracker
#   Alphabet: characters involved in cypher
#   Key: encrypts and decrypts; modifiable
#   Cracker: engine for cracking encryption; returns a new key

# Crackers have state.  Alphabets may be changed.
#   Generated Keys are held and can be accessed.


# Cracks RotKey, CustomKey
# Cracks monoalphabetic cypher
class StatCracker

  # The +new+ class method initializes the class.
  # === Parameters
  # _text_ = example text used to create alphabet statistics
  def initialize(text=nil)
    if text then
      @statAlphabet = generateAlphabetStats(text)
    else
      @statAlphabet = "ETAOINSHRDLCUMWFGYPBVKJXQZ"
    end
    puts "statAlphabet:   #{@statAlphabet}"
  end

  # Create letter-ordering statistics from a given text.
  # === Parameters
  # _text_ = example text used to create alphabet statistics
  def generateAlphabetStats(text)
    statAlphabetCount = Hash.new
    text.each_byte do |i|
      if i.chr =~ /\w/ then
	if statAlphabetCount[i.chr] then
	  statAlphabetCount[i.chr] += 1
	else
	  statAlphabetCount[i.chr] = 1
	end
      end
    end

    sortedStatAlphabetCount = statAlphabetCount.sort{|a,b| b[1]<=>a[1]}
    statAlphabet = ""
    sortedStatAlphabetCount.each do |i|
      statAlphabet += i[0]
    end
    return statAlphabet
  end

  # Get letter-ordering for the cypherText to decrypt.
  # === Parameters
  # _cypherText_ = message to be decyphered
  def generateCypherTextStats(cypherText)
    statCypherTextCount = Hash.new
    cypherText.each_byte do |i|
      if i.chr =~ /\w/ then
	if statCypherTextCount[i.chr] then
	  statCypherTextCount[i.chr] += 1
	else
	  statCypherTextCount[i.chr] = 1
	end
      end
    end

    sortedStatCypherTextCount = statCypherTextCount.sort{|a,b| b[1]<=>a[1]}
    @statCypherText = ""
    sortedStatCypherTextCount.each do |i|
      @statCypherText += i[0]
    end
    puts "statCypherText: #{@statCypherText}"
    if @statAlphabet.length != @statCypherText.length then
      puts "statAlphabet.length: " + @statAlphabet.length.to_s + ", statCypherText.length: " + @statCypherText.length.to_s
    end

    len = @statAlphabet.length <= @statCypherText.length ? @statAlphabet.length : @statCypherText.length
    @keyHash = Hash.new
    (0..len-1).each do |i|
      #print @statCypherText[i].chr
      @keyHash[@statAlphabet[i].chr] = @statCypherText[i].chr
    end
    #print "\n"
  end

  # Switch two characters in the alphabet key.
  # === Parameters
  # _key1_ = character switched with key2
  # _key2_ = character switched with key1
  def switchKeys(key1, key2)
    if !@keyHash then
      puts "switchKeys: Error - no existing key."
      return
    end

    if !@keyHash[key1] || !@keyHash[key2] then
      if !@keyHash[key1] && !@keyHash[key2] then
        puts "switchKeys: Error - characters #{key1} and #{key2} are not in the alphabet."
      elsif !@keyHash[key1] then
        puts "switchKeys: Error - character #{key1} is not in the alphabet."
      else
        puts "switchKeys: Error - character #{key2} is not in the alphabet."
      end
      return
    end

    @keyHash[key1],@keyHash[key2] = @keyHash[key2],@keyHash[key1]
  end

  # Permute a set of characters in the alphabet key.
  # === Parameters
  # _permuteString_ = string of characters in the alphabet
  def permuteKeys(permuteString)
    (0..permuteString.length-2).each do |i|
      switchKeys(permuteString[i].chr,permuteString[i+1].chr)
    end
  end

  # TODO - check this method
  # Switch two values in the alphabet key?
  # === Parameters
  # _val1_ = character switched with val2
  # _val2_ = character switched with val1
  def switchValues(val1, val2)
    if !@keyHash then
      puts "switchValues: Error - no existing key."
      return
    end
    if !@keyHash.key(val1) || !@keyHash.key(val2) then
      if !@keyHash.key(val1) && !@keyHash.key(val2) then
        puts "switchValues: Error - characters #{@keyHash.key(val1)} and #{@keyHash.key(val2)} are not in the alphabet."
      elsif !@keyHash.key(val1) then
        puts "switchValues: Error - character #{@keyHash.key(val1)} is not in the alphabet."
      else
        puts "switchValues: Error - character #{@keyHash.key(val2)} is not in the alphabet."
      end

      return
    end

    key1 = @keyHash.key(val1)
    key2 = @keyHash.key(val2)
    @keyHash[key1],@keyHash[key2] = @keyHash[key2],@keyHash[key1]
  end

  # Encrypt with the cracked key.
  # === Parameters
  # _message_ = message to encrypt
  def encrypt(message)
    
  end

  # Decrypt with the cracked key.
  # === Parameters
  # _message_ = message to decrypt
  def decrypt(cypherText)
    if !@statCypherText then
      generateCypherTextStats(cypherText)
    end
    message = ""
    cypherText.each_byte do |i|
      if @keyHash.has_value?(i.chr) then
	message = message + @keyHash.key(i.chr)
      else
	message = message + i.chr
      end
    end
    return message
  end

end


# Compare character occurance statistics to RotKeys
class RotCracker

  attr_reader :alphabet, :key
  attr_writer :alphabet, :key

  # The +new+ class method initializes the class.
  # === Parameters
  # _alphabet_ = alphabet to use
  def initialize(alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @alphabet = alphabet
    @key = 0
  end
  
  # Try all keys.
  # === Parameters
  # _cypherText_ = message to decrypt
  def try_all(cypherText)
    rot = RotKey.new(@alphabet,0)
    (1..@alphabet.length).each do |i|
      rot.set_offset(i)
      receipt = rot.decrypt(cypherText)
      puts "receipt #{i}:\n#{receipt}"
    end
  end
  
  # Decrypt with the cracked key.
  # === Parameters
  # _cypherText_ = message to decrypt
  def decrypt(cypherText)
    rot = RotKey.new(@alphabet,@key)
    return rot.decrypt(cypherText)
  end

end


# Crack VigenereKey
class VigenereCracker

  attr_reader :alphabet, :key
  attr_writer :alphabet, :key

  # The +new+ class method initializes the class.
  # === Parameters
  # _alphabet_ = alphabet to use
  def initialize(alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @alphabet = alphabet
    @key = ""
  end

  # Decrypt with the cracked key.
  # === Parameters
  # _cypherText_ = message to decrypt
  def decrypt(cypherText)

  end

end


# Encrypt with new alphabet corresponding to frequencies of characters in
#   message
class HomophonicCracker

  # The +new+ class method initializes the class.
  # === Parameters
  # _text_ = example text used to create alphabet statistics
  def initialize

  end

  # Decrypt with the cracked key.
  # === Parameters
  # _message_ = message to decrypt
  def decrypt

  end

end

