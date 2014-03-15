; ********************************************
; * Division sub-routine
; ********************************************	
; Calculates division with numerator R20:R19
; and denominator R18 and puts result into
; R20:R19 and remainder into R18
.def counter = R16
.def highbyte = R20
.def lowbyte =R19
.def divisor = R18
.def remainder = R18

divide:
push    R16
out     SREG,R16
push    R16
push    R21

ldi counter,0x00
loop1:
    inc counter
    sub highbyte,divisor
    brsh loop1
add highbyte,divisor
dec counter
mov R21,counter
ldi counter,0x00
loop2:
        inc counter
        sub lowbyte,divisor
        brsh loop2
    dec highbyte
	   cpi highbyte,0xff
    brne loop2
add lowbyte,divisor
dec counter
mov remainder,lowbyte
mov highbyte,R21
mov lowbyte,counter
end:
pop R21
pop R16
out SREG,R16
pop R16
		ret

