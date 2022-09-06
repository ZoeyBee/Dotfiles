echo 'please put your keyboard in programming mode'
sleep 3
teensy-loader-cli -v -mmcu=atmega32u4 *.hex
