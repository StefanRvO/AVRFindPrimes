#!/usr/bin/python2
#Gets data from the ADC of the ATmega32 over serial and plots it
#Data must come as [0xBB,0x14,0x<DATA>,0x<DATA>]
import time
from serial import Serial
import sys
import pygame
from pygame.locals import *
#import math

def GetReading():
    rawin=[]
    while len(rawin)<5:
        while (serialport.inWaiting() > 0) and len(rawin)<5:
            rawin.append(serialport.read(1))
            #Try to make some sanity check on the data
            if not(ord(rawin[0])==0x01):
                rawin=[]
            if len(rawin)>1 and not(ord(rawin[1])==0x02):
                rawin=[]
            if len(rawin)>2 and not(ord(rawin[2])==0x03):
                rawin=[]
    number=(ord(rawin[3])<<8)+ord(rawin[4])
    return number
        
    

portpath=sys.argv[1]
serialport = Serial(port=portpath, baudrate=9600)
connected=1
while True:
    print(GetReading())
