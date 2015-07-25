#! /usr/bin/ruby

require_relative '../src/Alphabet'
require_relative '../src/Cracker'
require_relative '../src/Key'


# Monoalphabetic cypher
def stage1
  puts "**** Stage 1 ****"
  message = "BT JPX RMLX PCUV AMLX ICVJP IBTWXVR CI M LMT'R PMTN, MTN YVCJX CDXV MWMBTRJ JPX AMTNGXRJBAH UQCT JPX QGMRJXV CI JPX YMGG CI JPX HBTW'R QMGMAX; MTN JPX HBTW RMY JPX QMVJ CI JPX PMTN JPMJ YVCJX. JPXT JPX HBTW'R ACUTJXTMTAX YMR APMTWXN, MTN PBR JPCUWPJR JVCUFGXN PBL, RC JPMJ JPX SCBTJR CI PBR GCBTR YXVX GCCRXN, MTN PBR HTXXR RLCJX CTX MWMBTRJ MTCJPXV. JPX HBTW AVBXN MGCUN JC FVBTW BT JPX MRJVCGCWXVR, JPX APMGNXMTR, MTN JPX RCCJPRMEXVR. MTN JPX HBTW RQMHX, MTN RMBN JC JPX YBRX LXT CI FMFEGCT, YPCRCXDXV RPMGG VXMN JPBR YVBJBTW, MTN RPCY LX JPX BTJXVQVXJMJBCT JPXVXCI, RPMGG FX AGCJPXN YBJP RAMVGXJ, MTN PMDX M APMBT CI WCGN MFCUJ PBR TXAH, MTN RPMGG FX JPX JPBVN VUGXV BT JPX HBTWNCL. JPXT AMLX BT MGG JPX HBTW'R YBRX LXT; FUJ JPXE ACUGN TCJ VXMN JPX YVBJBTW, TCV LMHX HTCYT JC JPX HBTW JPX BTJXVQVXJMJBCT JPXVXCI. JPXT YMR HBTW FXGRPMOOMV WVXMJGE JVCUFGXN, MTN PBR ACUTJXTMTAX YMR APMTWXN BT PBL, MTN PBR GCVNR YXVX MRJCTBRPXN. TCY JPX KUXXT, FE VXMRCT CI JPX YCVNR CI JPX HBTW MTN PBR GCVNR, AMLX BTJC JPX FMTKUXJ PCURX; MTN JPX KUXXT RQMHX MTN RMBN, C HBTW, GBDX ICVXDXV; GXJ TCJ JPE JPCUWPJR JVCUFGX JPXX, TCV GXJ JPE ACUTJXTMTAX FX APMTWXN; JPXVX BR M LMT BT JPE HBTWNCL, BT YPCL BR JPX RQBVBJ CI JPX PCGE WCNR; MTN BT JPX NMER CI JPE IMJPXV GBWPJ MTN UTNXVRJMTNBTW MTN YBRNCL, GBHX JPX YBRNCL CI JPX WCNR, YMR ICUTN BT PBL; YPCL JPX HBTW TXFUAPMNTXOOMV JPE IMJPXV, JPX HBTW, B RME, JPE IMJPXV, LMNX LMRJXV CI JPX LMWBABMTR, MRJVCGCWXVR, APMGNXMTR, MTN RCCJPRMEXVR; ICVMRLUAP MR MT XZAXGGXTJ RQBVBJ, MTN HTCYGXNWX, MTN UTNXVRJMTNBTW, BTJXVQVXJBTW CI NVXMLR, MTN RPCYBTW CI PMVN RXTJXTAXR, MTN NBRRCGDBTW CI NCUFJR, YXVX ICUTN BT JPX RMLX NMTBXG, YPCL JPX HBTW TMLXN FXGJXRPMOOMV; TCY GXJ NMTBXG FX AMGGXN, MTN PX YBGG RPCY JPX BTJXVQVXJMJBCT. JPX IBVRJ ACNXYCVN BR CJPXGGC."
  puts "message:\n#{message}"
  puts
  statCrack = StatCracker.new
  receipt = statCrack.decrypt(message)
  puts "receipt:\n#{receipt}"
  puts
  statCrack.permuteKeys("TAON")
  statCrack.permuteKeys("PVJZKYB")
  statCrack.permuteKeys("GCMFWU")
  statCrack.switchKeys("I","H")
  statCrack.switchKeys("D","R")
  statCrack.switchKeys("Q","X")
  receipt = statCrack.decrypt(message)
  puts "receipt:\n#{receipt}"
  puts
end


# Rot cypher
def stage2
  puts "**** Stage 2 ****"
  message = "MHILY LZA ZBHL XBPZXBL MVYABUHL HWWPBZ JSHBKPBZ JHLJBZ FPJABT HYJHUBT LZA ULBAYVU"
  puts "message:\n#{message}"
  puts

  abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  rot = RotKey.new(abc,0)
  (1..26).each do |i|
    rot.set_offset(i)
    receipt = rot.encrypt(message)
    puts "receipt #{i}:\n#{receipt}"
  end
  puts

end


# Monoalphabetic cypher with homophones
def stage3
  puts "**** Stage 3 ****"
  message = "IXDVMUFXLFEEFXSOQXYQVXSQTUIXWF*FMXYQVFJ*FXEFQUQX
JFPTUFXMX*ISSFLQTUQXMXRPQEUMXUMTUIXYFSSFI*MXKFJ
F*FMXLQXTIEUVFXEQTEFXSOQXLQ*XVFWMTQTUQXTITXKIJ*F
MUQXTQJMVX*QEYQVFQTHMXLFVQUVIXM*XEI*XLQ*XWITLIXE
QTHGXJQTUQXSITEFLQVGUQX*GXKIEUVGXEQWQTHGXDGUFXTIT
XDIEUQXGXKFKQVXSIWQXAVPUFXWGXYQVXEQJPFVXKFVUPUQXQX
SGTIESQTHGX*FXWFQFXSIWYGJTFXDQSFIXEFXGJPUFXSITXRPQEUG
XIVGHFITXYFSSFI*CXC*XSCWWFTIXSOQXCXYQTCXYIESFCX*FXCKV
QFXVFUQTPUFXQXKI*UCXTIEUVCXYIYYCXTQ*XWCUUFTIXLQFXVQW
FXDCSQWWIXC*FXC*XDI**QXKI*IXEQWYVQXCSRPFEUCTLIXLC*X*C
UIXWCTSFTIXUPUUQX*QXEUQ**QXJFCXLQX*C*UVIXYI*IXKQLQCX*CX
TIUUQXQX*XTIEUVIXUCTUIXACEEIXSOQXTITXEPVJQCXDPIVXLQ*X
WCVFTXEPI*IXSFTRPQXKI*UQXVCSSQEIXQXUCTUIXSCEEIX*IX*PWQ
XQVZXLFXEIUUIXLZX*ZX*PTZXYIFXSOQXTUVZUFXQVZKZWXTQX*Z*
UIXYZEEIRPZTLIXTZYYZVKQXPTZXWITUZJTZXAVPTZXYQVX*ZXLFEUZT
HZXQXYZVKQWFXZ*UZXUZTUIXRPZTUIXKQLPUZXTITXZKQZ
XZ*SPTZXTIFXSFXZ**QJVNWWIXQXUIEUIXUIVTIXFTXYFNTUIXS
OQXLQX*NXTIKNXUQVVNXPTXUPVAIXTNSRPQXQXYQVSIEE
QXLQ*X*QJTIXF*XYVFWIXSNTUIXUVQXKI*UQXF*XDQXJFVBVXSI
TXUPUUQX*BSRPQXBX*BXRPBVUBX*QKBVX*BXYIYYBXFTXEPEIXQX
*BXYVIVBXFVQXFTXJFPXSIWB*UVPFXYFBSRPQFTDFTXSOQX*XWBVXDP
XEIYVBXTIFXVFSOFPEIXX*BXYBVI*BXFTXSILFSQXQXQRPBUIV"
  puts "message:\n#{message}"
  puts
  
end


# Vigenere cypher
def stage4
  puts "**** Stage 4 ****"
  message = "K Q O W E F V J P U J U U N U K G L M E K J I
N M W U X F Q M K J B G W R L F N F G H U D W
U U M B S V L P S N C M U E K Q C T E S W R E
E K O Y S S I W C T U A X Y O T A P X P L W P
N T C G O J B G F Q H T D W X I Z A Y G F F N
S X C S E Y N C T S S P N T U J N Y T G G W Z
G R W U U N E J U U Q E A P Y M E K Q H U I D
U X F P G U Y T S M T F F S H N U O C Z G M R
U W E Y T R G K M E E D C T V R E C F B D J Q
C U S W V B P N L G O Y L S K M T E F V J J T
W W M F M W P N M E M T M H R S P X F S S K F
F S T N U O C Z G M D O E O Y E E K C P J R G
P M U R S K H F R S E I U E V G O Y C W X I Z
A Y G O S A A N Y D O E O Y J L W U N H A M E
B F E L X Y V L W N O J N S I O F R W U C C E
S W K V I D G M U C G O C R U W G N M A A F F
V N S I U D E K Q H C E U C P F C M P V S U D
G A V E M N Y M A M V L F M A O Y F N T Q C U
A F V F J N X K L N E I W C W O D C C U L W R
I F T W G M U S W O V M A T N Y B U H T C O C
W F Y T N M G Y T Q M K B B N L G F B T W O J
F T W G N T E J K N E E D C L D H W T V B U V
G F B I J G Y Y I D G M V R D G M P L S W G J
L A G O E E K J O F E K N Y N O L R I V R W V
U H E I W U U R W G M U T J C D B N K G M B I
D G M E E Y G U O T D G G Q E U J Y O T V G G
B R U J Y S"
  puts "message:\n#{message}"
  puts
end


def stage5
  puts "**** Stage 5 ****"
  message = "109 182 6 11 88 214 74 77 153 177 109 195
76 37 188 166 188 73 109 158 15 208 42 5
217 78 209 147 4 81 80 169 109 22 96 169
3 29 214 215 9 198 77 112 8 30 117 124
86 96 73 177 50 161"
  puts "message:\n#{message}"
  puts
end


def stage6
  puts "**** Stage 6 ****"
  message = ""
  puts "message:\n#{message}"
  puts
end



#stage1()
#stage2()
stage3()

