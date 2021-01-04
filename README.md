# Flutter Client -ESP8266 Server for WS2811 Led Strip
This project uses a little trick to break the infinite loops that originate the effects of the animations of the led strip, the infinite loop is broken every time the state changes because the incoming requests are heard within the loop.


 ## Example of a infinite loop
```cpp
void handleXmas() {
  while (true) {
    for (int x = 0; x < strip.numPixels(); x++){
      int flicker = random(0, 5);
      strip.setPixelColor(x, xmasColors[flicker]);
    }
    strip.show();
    delay(700);
    getRequests(); //Always listen all the incomming requests
    if (state != "Xmas") break; //If the state changes then the infinite loop is broken
}
```
 ## Libraries
 - You need to add ESP8266 board to your **Arduino IDE**, you can find a tutotial [HERE](https://randomnerdtutorials.com/how-to-install-esp8266-board-arduino-ide/)
	> http://arduino.esp8266.com/stable/package_esp8266com_index.json

- Also you need to install the [Adafruit NeoPixel Library](https://github.com/adafruit/Adafruit_NeoPixel)
	> https://github.com/adafruit/Adafruit_NeoPixel


# Flutter APP
### Animation Effects Page
![Animation Effects Page](https://i.ibb.co/H4yK3D1/Screenshot-1609695242.png)
In this page you can change the effects of the led strip.
#### Effect List
 - Rainbow `Rainbow style effect.`
 - Color Puro `Change to a pure color.`
 - Fade `Fades colors progressively.`
 - Color Wipe `Fill in the color strip.`
 - Fire `Fire flame effect.`
 - Side Fill `Fill the strip with a single color.`
 - Xmas `Christmas style effect.`
 - Modo Oculto `Secret mode :v`
 - Turn Off `Turn off all the leds`
### Settings Page
![Settings Page](https://i.ibb.co/rQR363V/Screenshot-1609695247.png)
In this page you can change the settings of the app.
#### Setting Options List
 - Change IP `Changes the IP of all the requests from the app, usefull if you have more than led strip working individually.`
 - Change Primary Color `Changes the primary color of the app, like the appbar and the floating action button of the app.`
 - Change Language `Changes the language of the app, English and Spanish supported at this moment.`
 - Dark Mode `Changes the brightness color of the app.`
 

## Results

 - [Rainbow](https://www.tweaking4all.com/wp-content/uploads/2015/11/LEDEffect-RainbowCycle.mp4)
- [Color Wipe](https://www.tweaking4all.com/wp-content/uploads/2015/11/LEDEffect-ColorWipe.mp4)

>[Source](https://www.tweaking4all.com/hardware/arduino/adruino-led-strip-effects/#LEDStripEffectRainbowCycle)
