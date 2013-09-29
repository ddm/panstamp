EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:atmega8
LIBS:atmel89cxxxx
LIBS:atmel-1
LIBS:atmel-2005
LIBS:avr
LIBS:avr-1
LIBS:avr-2
LIBS:avr-3
LIBS:avr-4
LIBS:hopf
LIBS:rfm-ash
LIBS:mycomponents
LIBS:mcp120-130
LIBS:mcp3304
LIBS:microchip_mcp2120
LIBS:microchip-mcp125x-xxx
LIBS:toshiba
LIBS:battery-board-cache
EELAYER 24 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "panStamp battery-powered board"
Date "27 Sep 2013"
Rev "V2.0"
Comp "www.panstamp.com"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	7900 4350 7600 4350
Wire Wire Line
	2800 3500 2200 3500
Wire Wire Line
	9300 4000 8950 4000
Wire Wire Line
	9200 3600 9850 3600
Wire Wire Line
	9850 3800 9750 3800
Wire Wire Line
	2800 3300 2200 3300
Wire Wire Line
	7900 4350 7900 4850
Wire Wire Line
	7900 4850 7950 4850
Wire Wire Line
	7950 5150 7900 5150
Wire Wire Line
	7900 5150 7900 5250
Wire Wire Line
	7600 4900 7600 5000
Connection ~ 7600 5000
Wire Wire Line
	7600 4350 7600 4400
Wire Wire Line
	9850 3900 9750 3900
Wire Wire Line
	9200 3700 9850 3700
Wire Wire Line
	5550 2400 5550 2550
Wire Wire Line
	3650 2100 3650 2000
Wire Wire Line
	2800 3600 2200 3600
Wire Wire Line
	9700 4000 9850 4000
Wire Wire Line
	2800 3400 2200 3400
Wire Wire Line
	7950 5000 6900 5000
Wire Wire Line
	2500 5900 2550 5900
Wire Wire Line
	2550 5900 2550 6250
$Comp
L GND #PWR2
U 1 1 4FB1156A
P 2800 6300
F 0 "#PWR2" H 2800 6300 30  0001 C CNN
F 1 "GND" H 2800 6230 30  0001 C CNN
F 2 "" H 2800 6300 60  0001 C CNN
F 3 "" H 2800 6300 60  0001 C CNN
	1    2800 6300
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 4FA10CA8
P 5650 6000
F 0 "C4" H 5700 6100 50  0000 L CNN
F 1 "100n" H 5700 5900 50  0000 L CNN
F 2 "SM0603S" H 5650 6000 60  0001 C CNN
F 3 "" H 5650 6000 60  0001 C CNN
	1    5650 6000
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 4FA10C95
P 5250 6000
F 0 "C3" H 5300 6100 50  0000 L CNN
F 1 "1u" H 5300 5900 50  0000 L CNN
F 2 "SM0603S" H 5250 6000 60  0001 C CNN
F 3 "" H 5250 6000 60  0001 C CNN
	1    5250 6000
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW1
U 1 1 4E2A75FE
P 5450 2300
F 0 "SW1" H 5550 2400 30  0000 C CNN
F 1 "SW_PUSH_SMALL" H 5450 2221 30  0000 C CNN
F 2 "switch-tact-noah" H 5450 2300 60  0001 C CNN
F 3 "" H 5450 2300 60  0001 C CNN
	1    5450 2300
	1    0    0    -1  
$EndComp
Text Label 2200 3300 0    60   ~ 0
A4
Text Label 2200 3500 0    60   ~ 0
A2
Text Label 2200 3400 0    60   ~ 0
A3
$Comp
L C C5
U 1 1 4F97D53A
P 9500 4000
F 0 "C5" H 9550 4100 50  0000 L CNN
F 1 "100n" H 9550 3900 50  0000 L CNN
F 2 "SM0603S" H 9500 4000 60  0001 C CNN
F 3 "" H 9500 4000 60  0001 C CNN
	1    9500 4000
	0    1    1    0   
$EndComp
Text Label 2200 3600 0    60   ~ 0
A1
$Comp
L GND #PWR9
U 1 1 4E2A761F
P 5550 2550
F 0 "#PWR9" H 5550 2550 30  0001 C CNN
F 1 "GND" H 5550 2480 30  0001 C CNN
F 2 "" H 5550 2550 60  0001 C CNN
F 3 "" H 5550 2550 60  0001 C CNN
	1    5550 2550
	-1   0    0    -1  
$EndComp
$Comp
L CONN_2 BAT1
U 1 1 4E292A6A
P 2150 5800
F 0 "BAT1" V 2100 5800 50  0000 C CNN
F 1 "CONN_2" V 2200 5800 40  0000 C CNN
F 2 "BAT_AA_HOLDER_02" H 2150 5800 60  0001 C CNN
F 3 "" H 2150 5800 60  0001 C CNN
	1    2150 5800
	-1   0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 4E25EB2E
P 4850 6000
F 0 "C2" H 4900 6100 50  0000 L CNN
F 1 "10u" H 4900 5900 50  0000 L CNN
F 2 "SM1206" H 4850 6000 60  0001 C CNN
F 3 "" H 4850 6000 60  0001 C CNN
	1    4850 6000
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4E25E3CF
P 2800 6000
F 0 "C1" H 2850 6100 50  0000 L CNN
F 1 "10u" H 2850 5900 50  0000 L CNN
F 2 "SM1206" H 2800 6000 60  0001 C CNN
F 3 "" H 2800 6000 60  0001 C CNN
	1    2800 6000
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR L1
U 1 1 4E2541F3
P 3400 5150
F 0 "L1" V 3350 5150 40  0000 C CNN
F 1 "4.7u" V 3500 5150 40  0000 C CNN
F 2 "SM1210L" H 3400 5150 60  0001 C CNN
F 3 "" H 3400 5150 60  0001 C CNN
	1    3400 5150
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR7
U 1 1 4E2541CE
P 4850 6300
F 0 "#PWR7" H 4850 6300 30  0001 C CNN
F 1 "GND" H 4850 6230 30  0001 C CNN
F 2 "" H 4850 6300 60  0001 C CNN
F 3 "" H 4850 6300 60  0001 C CNN
	1    4850 6300
	1    0    0    -1  
$EndComp
Text Label 9200 3600 0    60   ~ 0
TXD
Text Label 9200 3700 0    60   ~ 0
RXD
Text Label 8950 4000 0    60   ~ 0
RESET
$Comp
L GND #PWR22
U 1 1 4E204256
P 9750 3800
F 0 "#PWR22" H 9750 3800 30  0001 C CNN
F 1 "GND" H 9750 3730 30  0001 C CNN
F 2 "" H 9750 3800 60  0001 C CNN
F 3 "" H 9750 3800 60  0001 C CNN
	1    9750 3800
	0    1    1    0   
$EndComp
$Comp
L CONN_5 P1
U 1 1 4E2041F0
P 10250 3800
F 0 "P1" V 10200 3800 50  0000 C CNN
F 1 "CONN_5" V 10300 3800 50  0000 C CNN
F 2 "" H 10250 3800 60  0001 C CNN
F 3 "" H 10250 3800 60  0001 C CNN
	1    10250 3800
	1    0    0    -1  
$EndComp
Text Label 4950 2200 0    60   ~ 0
RESET
NoConn ~ 3900 4300
Text Label 6900 5000 0    60   ~ 0
SENSOR_DATA
$Comp
L R R1
U 1 1 4D108882
P 4500 6000
F 0 "R1" V 4580 6000 50  0000 C CNN
F 1 "976k" V 4500 6000 50  0000 C CNN
F 2 "SM0603S" H 4500 6000 60  0001 C CNN
F 3 "" H 4500 6000 60  0001 C CNN
	1    4500 6000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR17
U 1 1 4D10884A
P 7900 5250
F 0 "#PWR17" H 7900 5250 30  0001 C CNN
F 1 "GND" H 7900 5180 30  0001 C CNN
F 2 "" H 7900 5250 60  0001 C CNN
F 3 "" H 7900 5250 60  0001 C CNN
	1    7900 5250
	1    0    0    -1  
$EndComp
$Comp
L DHT11 U4
U 1 1 4D10882B
P 8500 5000
F 0 "U4" H 8350 5300 60  0000 C CNN
F 1 "DHT22" H 8400 4700 60  0000 C CNN
F 2 "DHT22" H 8500 5000 60  0001 C CNN
F 3 "" H 8500 5000 60  0001 C CNN
	1    8500 5000
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR11
U 1 1 4CCA967E
P 5950 5550
F 0 "#PWR11" H 5950 5510 30  0001 C CNN
F 1 "+3.3V" H 5950 5660 30  0000 C CNN
F 2 "" H 5950 5550 60  0001 C CNN
F 3 "" H 5950 5550 60  0001 C CNN
	1    5950 5550
	1    0    0    -1  
$EndComp
Text Label 5050 3700 2    60   ~ 0
RXD
Text Label 5050 3600 2    60   ~ 0
TXD
$Comp
L PANSTAMP_NRG U1
U 1 1 523E2475
P 3600 3250
F 0 "U1" H 4000 4150 60  0000 C CNN
F 1 "PANSTAMP_NRG" H 3200 4150 60  0000 C CNN
F 2 "PANSTAMP_02_NA" H 3600 3250 60  0001 C CNN
F 3 "" H 3600 3250 60  0000 C CNN
	1    3600 3250
	1    0    0    -1  
$EndComp
NoConn ~ 3750 2100
$Comp
L GND #PWR4
U 1 1 523E2498
P 3650 4450
F 0 "#PWR4" H 3650 4450 30  0001 C CNN
F 1 "GND" H 3650 4380 30  0001 C CNN
F 2 "" H 3650 4450 60  0001 C CNN
F 3 "" H 3650 4450 60  0001 C CNN
	1    3650 4450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3500 4300 3500 4400
Wire Wire Line
	3500 4400 4100 4400
Wire Wire Line
	3800 4400 3800 4300
Wire Wire Line
	3700 4300 3700 4400
Connection ~ 3700 4400
Wire Wire Line
	3600 4300 3600 4400
Connection ~ 3600 4400
Wire Wire Line
	3650 4400 3650 4450
Connection ~ 3650 4400
Wire Wire Line
	2800 3200 2200 3200
Wire Wire Line
	2800 3100 2200 3100
Text Label 2200 3200 0    60   ~ 0
SENSOR_DATA
$Comp
L COZIR_CO2 U5
U 1 1 523E33D2
P 9500 2050
F 0 "U5" H 9200 2500 60  0000 C CNN
F 1 "COZIR_CO2" H 9800 2500 60  0000 C CNN
F 2 "COZIR_AS" H 9600 2050 60  0001 C CNN
F 3 "" H 9600 2050 60  0000 C CNN
	1    9500 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR21
U 1 1 523E33DF
P 9500 2800
F 0 "#PWR21" H 9500 2800 30  0001 C CNN
F 1 "GND" H 9500 2730 30  0001 C CNN
F 2 "" H 9500 2800 60  0001 C CNN
F 3 "" H 9500 2800 60  0001 C CNN
	1    9500 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 2750 9500 2800
$Comp
L +3.3V #PWR20
U 1 1 523E35B4
P 9500 1250
F 0 "#PWR20" H 9500 1210 30  0001 C CNN
F 1 "+3.3V" H 9500 1360 30  0000 C CNN
F 2 "" H 9500 1250 60  0001 C CNN
F 3 "" H 9500 1250 60  0001 C CNN
	1    9500 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 1250 9500 1350
$Comp
L +3.3V #PWR16
U 1 1 52453EEB
P 7750 4300
F 0 "#PWR16" H 7750 4260 30  0001 C CNN
F 1 "+3.3V" H 7750 4410 30  0000 C CNN
F 2 "" H 7750 4300 60  0001 C CNN
F 3 "" H 7750 4300 60  0001 C CNN
	1    7750 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 4300 7750 4350
Connection ~ 7750 4350
Text Label 2200 3100 0    60   ~ 0
PSU_EN
$Comp
L VCC #PWR3
U 1 1 524544F1
P 3650 2000
F 0 "#PWR3" H 3650 2100 30  0001 C CNN
F 1 "VCC" H 3650 2100 30  0000 C CNN
F 2 "" H 3650 2000 60  0000 C CNN
F 3 "" H 3650 2000 60  0000 C CNN
	1    3650 2000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR1
U 1 1 5245450A
P 2550 5550
F 0 "#PWR1" H 2550 5650 30  0001 C CNN
F 1 "VCC" H 2550 5650 30  0000 C CNN
F 2 "" H 2550 5550 60  0000 C CNN
F 3 "" H 2550 5550 60  0000 C CNN
	1    2550 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 5700 3150 5700
Wire Wire Line
	2550 5700 2550 5550
$Comp
L MCP1640B U2
U 1 1 524548C6
P 3750 5850
F 0 "U2" H 3500 6200 60  0000 C CNN
F 1 "MCP1640B" H 4000 6200 60  0000 C CNN
F 2 "SOT23_6" H 3750 5850 60  0001 C CNN
F 3 "" H 3750 5850 60  0000 C CNN
	1    3750 5850
	1    0    0    -1  
$EndComp
Connection ~ 2550 5700
Wire Wire Line
	3150 6200 3150 6600
Wire Wire Line
	3150 6600 2550 6600
Text Label 2550 6600 0    60   ~ 0
PSU_EN
Wire Wire Line
	3750 5250 3750 5150
Wire Wire Line
	3750 5150 3700 5150
Wire Wire Line
	3100 5700 3100 5150
Connection ~ 3100 5700
$Comp
L R R2
U 1 1 52454C20
P 4500 6600
F 0 "R2" V 4580 6600 50  0000 C CNN
F 1 "562k" V 4500 6600 50  0000 C CNN
F 2 "SM0603S" H 4500 6600 60  0001 C CNN
F 3 "" H 4500 6600 60  0001 C CNN
	1    4500 6600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR5
U 1 1 52454DAE
P 3750 6850
F 0 "#PWR5" H 3750 6850 30  0001 C CNN
F 1 "GND" H 3750 6780 30  0001 C CNN
F 2 "" H 3750 6850 60  0001 C CNN
F 3 "" H 3750 6850 60  0001 C CNN
	1    3750 6850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR6
U 1 1 52454DB4
P 4500 6900
F 0 "#PWR6" H 4500 6900 30  0001 C CNN
F 1 "GND" H 4500 6830 30  0001 C CNN
F 2 "" H 4500 6900 60  0001 C CNN
F 3 "" H 4500 6900 60  0001 C CNN
	1    4500 6900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 6650 3750 6850
Wire Wire Line
	4500 6850 4500 6900
Wire Wire Line
	2800 5800 2800 5700
Connection ~ 2800 5700
Wire Wire Line
	2800 6200 2800 6300
Wire Wire Line
	2550 6250 2800 6250
Connection ~ 2800 6250
Wire Wire Line
	4500 6250 4500 6350
Wire Wire Line
	4350 6200 4350 6300
Wire Wire Line
	4350 6300 4500 6300
Connection ~ 4500 6300
Wire Wire Line
	4350 5700 5950 5700
Wire Wire Line
	4850 5700 4850 5800
Wire Wire Line
	4500 5750 4500 5700
Connection ~ 4500 5700
Wire Wire Line
	4850 6200 4850 6300
Wire Wire Line
	5950 5700 5950 5550
Connection ~ 4850 5700
Wire Wire Line
	5250 5800 5250 5700
Connection ~ 5250 5700
Wire Wire Line
	5650 5800 5650 5700
Connection ~ 5650 5700
$Comp
L GND #PWR8
U 1 1 5245556E
P 5250 6300
F 0 "#PWR8" H 5250 6300 30  0001 C CNN
F 1 "GND" H 5250 6230 30  0001 C CNN
F 2 "" H 5250 6300 60  0001 C CNN
F 3 "" H 5250 6300 60  0001 C CNN
	1    5250 6300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR10
U 1 1 52455574
P 5650 6300
F 0 "#PWR10" H 5650 6300 30  0001 C CNN
F 1 "GND" H 5650 6230 30  0001 C CNN
F 2 "" H 5650 6300 60  0001 C CNN
F 3 "" H 5650 6300 60  0001 C CNN
	1    5650 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 6200 5650 6300
Wire Wire Line
	5250 6200 5250 6300
$Comp
L R R3
U 1 1 524556DC
P 7600 4650
F 0 "R3" V 7680 4650 50  0000 C CNN
F 1 "10k" V 7600 4650 50  0000 C CNN
F 2 "SM0603S" H 7600 4650 60  0001 C CNN
F 3 "" H 7600 4650 60  0001 C CNN
	1    7600 4650
	1    0    0    -1  
$EndComp
NoConn ~ 10200 1950
NoConn ~ 10200 2050
NoConn ~ 10200 2150
$Comp
L M74VHC1GT08 U3
U 1 1 52456465
P 7700 1950
F 0 "U3" H 7750 1950 60  0000 C CNN
F 1 "M74VHC1GT08" H 7900 2200 60  0000 C CNN
F 2 "SOT23-5" H 7700 1950 60  0001 C CNN
F 3 "" H 7700 1950 60  0000 C CNN
	1    7700 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 3600 5050 3600
Wire Wire Line
	4650 3700 5050 3700
Wire Wire Line
	8800 1950 8300 1950
Text Label 8400 2050 0    60   ~ 0
RXD
Wire Wire Line
	8800 2050 8400 2050
Wire Wire Line
	7100 1850 7050 1850
Wire Wire Line
	7050 1850 7050 2050
Wire Wire Line
	7050 2050 7100 2050
Wire Wire Line
	7050 1950 6700 1950
Connection ~ 7050 1950
Text Label 6700 1950 0    60   ~ 0
TXD
$Comp
L +3.3V #PWR14
U 1 1 524567CA
P 7550 1500
F 0 "#PWR14" H 7550 1460 30  0001 C CNN
F 1 "+3.3V" H 7550 1610 30  0000 C CNN
F 2 "" H 7550 1500 60  0001 C CNN
F 3 "" H 7550 1500 60  0001 C CNN
	1    7550 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 1550 7550 1500
$Comp
L GND #PWR15
U 1 1 52456823
P 7550 2400
F 0 "#PWR15" H 7550 2400 30  0001 C CNN
F 1 "GND" H 7550 2330 30  0001 C CNN
F 2 "" H 7550 2400 60  0001 C CNN
F 3 "" H 7550 2400 60  0001 C CNN
	1    7550 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 2350 7550 2400
$Comp
L C C6
U 1 1 52460DBA
P 10550 2050
F 0 "C6" H 10600 2150 50  0000 L CNN
F 1 "100n" H 10600 1950 50  0000 L CNN
F 2 "SM0603S" H 10550 2050 60  0001 C CNN
F 3 "" H 10550 2050 60  0001 C CNN
	1    10550 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	10550 1850 10550 1750
$Comp
L GND #PWR25
U 1 1 52460DC1
P 10550 2350
F 0 "#PWR25" H 10550 2350 30  0001 C CNN
F 1 "GND" H 10550 2280 30  0001 C CNN
F 2 "" H 10550 2350 60  0001 C CNN
F 3 "" H 10550 2350 60  0001 C CNN
	1    10550 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	10550 2250 10550 2350
$Comp
L +3.3V #PWR24
U 1 1 52460DC8
P 10550 1750
F 0 "#PWR24" H 10550 1710 30  0001 C CNN
F 1 "+3.3V" H 10550 1860 30  0000 C CNN
F 2 "" H 10550 1750 60  0001 C CNN
F 3 "" H 10550 1750 60  0001 C CNN
	1    10550 1750
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 524610F4
P 9000 5000
F 0 "C7" H 9050 5100 50  0000 L CNN
F 1 "100n" H 9050 4900 50  0000 L CNN
F 2 "SM0603S" H 9000 5000 60  0001 C CNN
F 3 "" H 9000 5000 60  0001 C CNN
	1    9000 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 4800 9000 4700
$Comp
L GND #PWR19
U 1 1 524610FB
P 9000 5300
F 0 "#PWR19" H 9000 5300 30  0001 C CNN
F 1 "GND" H 9000 5230 30  0001 C CNN
F 2 "" H 9000 5300 60  0001 C CNN
F 3 "" H 9000 5300 60  0001 C CNN
	1    9000 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 5200 9000 5300
$Comp
L +3.3V #PWR18
U 1 1 52461102
P 9000 4700
F 0 "#PWR18" H 9000 4660 30  0001 C CNN
F 1 "+3.3V" H 9000 4810 30  0000 C CNN
F 2 "" H 9000 4700 60  0001 C CNN
F 3 "" H 9000 4700 60  0001 C CNN
	1    9000 4700
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR23
U 1 1 52461331
P 9750 3900
F 0 "#PWR23" H 9750 4000 30  0001 C CNN
F 1 "VCC" H 9750 4000 30  0000 C CNN
F 2 "" H 9750 3900 60  0000 C CNN
F 3 "" H 9750 3900 60  0000 C CNN
	1    9750 3900
	0    -1   -1   0   
$EndComp
$Comp
L C C8
U 1 1 52461463
P 7000 1200
F 0 "C8" H 7050 1300 50  0000 L CNN
F 1 "100n" H 7050 1100 50  0000 L CNN
F 2 "SM0603S" H 7000 1200 60  0001 C CNN
F 3 "" H 7000 1200 60  0001 C CNN
	1    7000 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 1000 7000 900 
$Comp
L GND #PWR13
U 1 1 5246146A
P 7000 1500
F 0 "#PWR13" H 7000 1500 30  0001 C CNN
F 1 "GND" H 7000 1430 30  0001 C CNN
F 2 "" H 7000 1500 60  0001 C CNN
F 3 "" H 7000 1500 60  0001 C CNN
	1    7000 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 1400 7000 1500
$Comp
L +3.3V #PWR12
U 1 1 52461471
P 7000 900
F 0 "#PWR12" H 7000 860 30  0001 C CNN
F 1 "+3.3V" H 7000 1010 30  0000 C CNN
F 2 "" H 7000 900 60  0001 C CNN
F 3 "" H 7000 900 60  0001 C CNN
	1    7000 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 4400 4100 4300
Connection ~ 3800 4400
Wire Wire Line
	4000 4300 4000 4400
Connection ~ 4000 4400
Wire Wire Line
	4650 2700 4950 2700
Wire Wire Line
	4950 2700 4950 2200
Wire Wire Line
	4950 2200 5350 2200
$Comp
L R R4
U 1 1 5248496A
P 4700 2150
F 0 "R4" V 4780 2150 50  0000 C CNN
F 1 "0" V 4700 2150 50  0000 C CNN
F 2 "SM0603S" H 4700 2150 60  0001 C CNN
F 3 "" H 4700 2150 60  0001 C CNN
	1    4700 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 2500 4700 2500
Wire Wire Line
	4700 2500 4700 2400
$Comp
L CONN_1 ANT1
U 1 1 52484BDE
P 4700 1650
F 0 "ANT1" H 4780 1650 40  0000 L CNN
F 1 "CONN_1" H 4700 1705 30  0001 C CNN
F 2 "" H 4700 1650 60  0000 C CNN
F 3 "" H 4700 1650 60  0000 C CNN
	1    4700 1650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4700 1900 4700 1800
$EndSCHEMATC
