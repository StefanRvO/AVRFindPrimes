;Checks if number in R16:R17 is a prime. If so, sets R18 to 0xFF, else 0x00
.def DivHigh=R20
.def DivLow=R19
.def PrimeCounter=R21
.def Divisor=R18
.def Remainder=R18
.def PrimeHigh=R17
.def PrimeLow=R16
.def Respone=R18
CheckPrime:
push PrimeLow
push PrimeHigh
push PrimeCounter
push DivHigh
push DivLow

ldi PrimeCounter,0x01
;Static results for 0x00 and 0x01
cpi PrimeHigh,0x00
brne CheckLoop
cpi PrimeLow,0x00
breq NotPrime
cpi PrimeLow,0x01
breq Prime


CheckLoop:
    inc PrimeCounter
    breq Prime
    cpi PrimeHigh,0x00
    brne Continue
    cp PrimeLow,PrimeCounter
    breq Prime
    Continue:
    mov Divisor,PrimeCounter
    mov DivHigh,PrimeHigh
    mov DivLow,PrimeLow
    call divide
    cpi Remainder,0x00
    breq NotPrime
    rjmp CheckLoop

Prime:
ldi Respone,0xff
pop DivLow
pop DivHigh
pop PrimeCounter
pop DivHigh
pop DivLow
ret
NotPrime:
ldi Respone,0x00
pop DivLow
pop DivHigh
pop PrimeCounter
pop DivHigh
pop DivLow
ret
