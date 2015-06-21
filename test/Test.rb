#! /usr/bin/ruby

require_relative '../src/Alphabet'
require_relative '../src/Cracker'
require_relative '../src/Key'

testKey = CustomKey.new(Hash['A'=>'X','B'=>'Y','C'=>'Z','D'=>'A','E'=>'B','F'=>'C','G'=>'D','H'=>'E','I'=>'F','J'=>'G','K'=>'H','L'=>'I','M'=>'J','N'=>'K','O'=>'L','P'=>'M','Q'=>'N','R'=>'O','S'=>'P','T'=>'Q','U'=>'R','V'=>'S','W'=>'T','X'=>'U','Y'=>'V','Z'=>'W'])
message = "HEY, WHATS UP DOODS? YOU TOTALLY ROXOR MY SOXORS!!!"
puts "\n**** Custom Key ****"
puts "message: #{message}"
cypherText = testKey.encrypt(message)
puts "cypherText: #{cypherText}"
receipt = testKey.decrypt(cypherText)
puts "receipt: #{receipt}"
puts ""

puts "\n**** Rot13 ****"
abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
rot13 = RotKey.new(abc,13)
puts "message: #{message}"
cypherText = rot13.encrypt(message)
puts "cypherText: #{cypherText}"
receipt = rot13.decrypt(cypherText)
puts "receipt: #{receipt}"
puts ""

puts "\n**** Rot1 ****"
rot1 = RotKey.new(abc,1)
puts "message: #{message}"
cypherText = rot1.encrypt(message)
puts "cypherText: #{cypherText}"
receipt = rot1.decrypt(cypherText)
puts "receipt: #{receipt}"
puts ""

puts "\n**** Rot10 ****"
rot10 = RotKey.new(abc,10)
puts "message: #{message}"
cypherText = rot10.encrypt(message)
puts "cypherText: #{cypherText}"
receipt = rot10.decrypt(cypherText)
puts "receipt: #{receipt}"

puts "**** StatCracker ****"
#statCrack = StatCracker.new
statMessage = "IT WAS A BEAUTIFUL DAY IN SUNNY, DOWNTOWN BURBANK AS THE BIRDS CHIRPED IN THE TREES AND MY ROOMMATE SALLY STROLLED DOWN THE MARKET LANE. SHE WAS QUITE INTERESTED IN THE UPCOMING FAIR AT WHICH SHE WOULD PLAY MANY GAMES OF SKILL AND EAT A BARBECUED TURKEY LEG. OH, WHAT A DAY! LAST NIGHT, MY BEST FRIEND AND I HEADED OUT TO THIS WONDERFUL, LITTLE RESTAURANT CALLED SILVER CREEK. THEY USUALLY HAVE REALLY GREAT BRUNCHES SO WE THOUGH MAYBE THEY WOULD COOK A GOOD DINNERTIME MEAL, TOO. MY, IT COULD BE SO INSANELY FUCKED UP, LIKE A BIGASS PIG WITH TONS OF SWEAT POURING OUT OF ITS GOOFY, LITTLE SNOUT."
statCrack = StatCracker.new(statMessage)
puts "statMessage: #{statMessage}"
statCypherText = rot13.encrypt(statMessage)
puts "statCypherText: #{statCypherText}"
statReceipt = statCrack.decrypt(statCypherText)
puts "statReceipt: #{statReceipt}"
statCrack.switchKeys("L","S")
statReceipt = statCrack.decrypt(statCypherText)
puts "statReceipt: #{statReceipt}"

puts "**** Code Book 1 ****"
statCrack = StatCracker.new
statCypherText = "PCQ VMJYPD LBYK LYSO KBXBJXWXV BXV ZCJPO EYPD KBXBJYUXJ LBJOO KCPK. CP LBO LBCMKXPV XPV IYJKL PYDBL, QBOP KBO BXV OPVOV LBO LXRO CI SX'XJMI, KBO JCKO XPV EYKKOV LBO DJCMPV ZOICJO BYS, KXUYPD: \"DJOXL EYPD, ICJ X LBCMKXPV XPV CPO PYDBLK Y BXNO ZOOP JOACMPLYPD LC UCM LBO IXZROK CI FXKL XDOK XPV LBO RODOPVK CI XPAYOPL EYPDK. SXU Y SXEO KC ZCRV XK LC AJXNO X IXNCMJ CI UCMJ SXGOKLU?\"

OFYRCDMO, LXROK IJCS LBO LBCMKXPV XPV CPO PYDBLK"
puts "statCypherText: #{statCypherText}"
statReceipt = statCrack.decrypt(statCypherText)
puts "statReceipt: #{statReceipt}"

# (DR)
statCrack.switchKeys("D","R")

statCrack.permuteKeys("FUCPKY")
statCrack.permuteKeys("BGLWV")
statCrack.permuteKeys("IHS")
statCrack.permuteKeys("NAT")
#statCrack.permuteKeys("XZ")

# (XZ)
statCrack.switchKeys("X","Z")

statReceipt = statCrack.decrypt(statCypherText)
puts "statReceipt: #{statReceipt}"


puts "\n**** VigenereKey ****"
vigKey = VigenereKey.new("WHITE",abc)
vigCypherText = vigKey.encrypt("DIVERTTROOPSTOEASTRIDGE")
puts "vigCypherText: #{vigCypherText}"
vigMessage = vigKey.decrypt(vigCypherText)
puts "vigMessage: #{vigMessage}"


