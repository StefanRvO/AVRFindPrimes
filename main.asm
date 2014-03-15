.include "m32def.inc"


.org    0x0060
Reset:
.include "SetupStack.asm"       ;setup the stack
.include "SetupSerial.asm"      ;setup serial connection
.include "SetupIO.asm"
jmp Main


Main:
ldi R16,0x01
ldi R17,0x00
MainLoop:
Call CheckPrime
cpi R18,0xFF
brne Nprime
;call Delay
call TRANSREPLY
Nprime:
cpi R16,0x00
brne DontC
inc R17
DontC:
inc R16
rjmp MainLoop

Delay:
push R17
push R18
push R19
ldi R17,0xff
ldi R18,0xff
ldi R19,0x01
Delayloop:
dec R17
breq R17z
rjmp Delayloop
R17z:
dec R18
breq R18z
ldi R17,0xff
rjmp Delayloop
R18z:
dec R19
breq Delayend
ldi R17,0xff
ldi R18,0xff
rjmp Delayloop
Delayend:
pop R19
pop R18
pop R17
ret

TRANSREPLY:  
push R22
;Try to make some sanity check on the data
ldi R22,0x01
transloop1:
SBIS    UCSRA,UDRE
RJMP    transloop1
out     UDR,R22
ldi R22,0x02
transloop11:
SBIS    UCSRA,UDRE
RJMP    transloop11
out     UDR,R22
ldi R22,0x03
transloop111:
SBIS    UCSRA,UDRE
RJMP    transloop111
out     UDR,R22
transloop2:
SBIS    UCSRA,UDRE
RJMP    transloop2
out     UDR,R17
t2:
SBIS    UCSRA,UDRE
RJMP    t2
out     UDR,R16
pop R22
ret

.include "CheckPrime16.asm"
.include "divide.asm"
