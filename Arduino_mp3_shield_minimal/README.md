# Arduino_mp3_shield_minimal

## About this example
This example is made for making it easy to get started with the Sparkfun mp3 shield for Arduino. We find this lacking in the Sparkfun instructions and the VS1053 library.
A more extensive introduction to the shield evt. can be found here...
https://learn.sparkfun.com/tutorials/mp3-player-shield-hookup-guide-v15/all
The rest of the functions and features can be found in the Arduino code examples in the VS1053 library.

## Download libraries
Use the Arduino IDEs build in library manager to install the two libraries:
- SdFat (by Bill Greiman)
- VS1053 for use with SdFat


## Prepare SD card
SD card format: MS-DOS (FAT32)

## Prepare soundfiles
Use Audacity (free software) to convert your soundfiles to the right mp3 format.

Steps:
1. Open Audacity
2. Drag file to the Audacity window
3. Go to: File -> Export -> Export as mp3
4. Setup export file settings:
- Set the export folder
- Set name of the output file with the naming convention: "trackXXX", e.g. track001, or track002 etc.
- Set quality to: medium 145-185 kbps
- Set variable speed: fast
- Set channem mode: stereo
5. Click save
6. Move the files to the SD card

## Test the code
Insert the SD card in the mp3 shield, and add the shield on top of an arduibo UNO
Insert headphones in the mini-jack output connection on the shield
Upload the code from this example "Arduino_mp3_shield_minimal.ino"
The soundfile should play when the code is done uploading...

