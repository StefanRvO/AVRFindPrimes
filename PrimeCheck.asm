;Checks if number in R16 is a prime. If so, sets R20 to 0xFF, else 0x00
.def DivNumber=R23
.def Counter=R24
.def Divisor=R25
.def Remainder=R23
.def PrimeCounter=R17
.def PrimeNR=R16
Div:
loop1:
    inc Counter
    sub DivNumber,Divisor
    brsh loop1
add DivNumber,Divisor
dec Counter
ret

CheckPrime:

ldi R20,0x00

ldi R17,0x01
;Static results for 0x00 and 0x01
cpi R16,0x00
Breq NotPrime
cpi R16,0x01
breq Prime

CheckLoop:
    inc PrimeCounter
    cp PrimeCounter,PrimeNR
    breq Prime
    mov Divisor,PrimeCounter
    mov DivNumber,PrimeNR
    call Div
    cpi Remainder,0x00
    breq NotPrime
    rjmp CheckLoop

NotPrime:
ret

Prime:
ldi R20,0xff
ret
