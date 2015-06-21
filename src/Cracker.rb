

# Need to refactor classes into Alphabet, Key, and Cracker
#   Alphabet: characters involved in cypher
#   Key: encrypts and decrypts; modifiable
#   Cracker: engine for cracking encryption; returns a new key

# Crackers have state.  Alphabets may be changed.
#   Generated Keys are held and can be accessed.


# Compare character occurance statistics to RotKeys
#   should be child of StatCracker
class RotCracker

  def initialize(text=nil)

  end

  def crack(cypherText, alphabet)

  end

end


# Cracks CustomKey
class StatCracker

  def initialize(text=nil)
    if text then
      @statAlphabet = generateAlphabetStats(text)
    else
      @statAlphabet = "ETAOINSHRDLCUMWFGYPBVKJXQZ"
    end
    puts "statAlphabet: #{@statAlphabet}"
  end

  # Create letter-ordering statistics from a
  # given text.
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

  # Get letter-ordering for the cypherText
  # to decrypt.
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

  def switchKeys(key1, key2)
    if !@keyHash then
      puts "WTF, dumbass?  You need to generate a key first!"
      return
    end
    if !@keyHash[key1] || !@keyHash[key2] then
      puts "Yeah, it would help if you asked to switch some keys that actually existed, unlike #{key1} and #{key2}."
      return
    end
    @keyHash[key1],@keyHash[key2] = @keyHash[key2],@keyHash[key1]
  end

  def permuteKeys(permuteString)
    (0..permuteString.length-2).each do |i|
      switchKeys(permuteString[i].chr,permuteString[i+1].chr)
    end
  end

  def switchValues(val1, val2)
    if !@keyHash then
      puts "switchValue: WTF, dumbass?  You need to generate a key first!"
      return
    end
    if !@keyHash.key(val1) || !@keyHash.key(val2) then
      puts "switchValues: Yeah, it would help if you asked to switch some values that actually existed, unlike #{@keyHash.key(val1)} and #{@keyHash.key(val2)}."
      return
    end
    key1 = @keyHash.key(val1)
    key2 = @keyHash.key(val2)
    @keyHash[key1],@keyHash[key2] = @keyHash[key2],@keyHash[key1]
  end

  # Encrypt with the cracked key.
  def encrypt(message)
    
  end

  # 
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


# Crack VigenereKey
class VigenereCracker

  def initialize

  end

  def crack(message)
    #return key
  end

end



# Encrypt with new alphabet corresponding to frequencies of characters in
#   message
class HomophonicCracker

  def initialize

  end

  def crack

  end

end

