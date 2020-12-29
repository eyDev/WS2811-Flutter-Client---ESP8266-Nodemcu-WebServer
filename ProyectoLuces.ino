#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Adafruit_NeoPixel.h>

const char* ssid = "YOURWIFISSID";
const char* password = "YOURWIFIPASS";

IPAddress local_IP(192, 168, 1, 200);
IPAddress gateway(192, 168, 1, 1);
IPAddress subnet(255, 255, 255, 0);

static const uint8_t LED_PIN = 12;
#define LED_COUNT 50
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

ESP8266WebServer server(80);
int red;
int blue;
int green;
String state;
uint32_t xmasColors[] ={ strip.Color(91, 22, 51), strip.Color(107, 20, 58), strip.Color(178, 248, 41), strip.Color(70, 234, 48), strip.Color(37, 187, 40)};

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  WiFi.config(local_IP, gateway, subnet);
  server.on("/luces", loop);
  server.onNotFound(handleNotFound);
  server.begin();
  strip.begin();
  strip.show();
  strip.setBrightness(255);
}

void handleNotFound() {
  server.send(404, "text/plain", "404: Not found");
}

void handleState() {
  server.send(200, "text/plain", "changed");
}

void getRequests(){
  server.handleClient();
  if (server.method() == HTTP_POST) {
    state = server.arg("state");
  } 
}

void handleRainbow() {
  while(true){
    rainbowCycle(15);
    if (state != "Rainbow") break;
  }
}

void rainbowCycle(int SpeedDelay) {
  byte *c;
  uint16_t i, j;
  for(j=0; j<256*5; j++) {
    for(i=0; i< 50; i++) {
      c=Wheel(((i * 256 / 50) + j) & 255);
      strip.setPixelColor(i, *c, *(c+1), *(c+2));
      getRequests();
      if (state != "Rainbow") break;
    }
    if (state != "Rainbow") break;
    strip.show();
    delay(SpeedDelay);
  }
}

byte * Wheel(byte WheelPos) {
  static byte c[3];
 
  if(WheelPos < 85) {
   c[0]=WheelPos * 3;
   c[1]=255 - WheelPos * 3;
   c[2]=0;
  } else if(WheelPos < 170) {
   WheelPos -= 85;
   c[0]=255 - WheelPos * 3;
   c[1]=0;
   c[2]=WheelPos * 3;
  } else {
   WheelPos -= 170;
   c[0]=0;
   c[1]=WheelPos * 3;
   c[2]=255 - WheelPos * 3;
  }

  return c;
}

void handleColorPuro() {
  if(state == "ColorPuro" && (server.arg("red").toInt() !=  red || server.arg("green").toInt() != green || server.arg("blue").toInt() != blue)){
    red = server.arg("red").toInt();
    green = server.arg("green").toInt();
    blue = server.arg("blue").toInt();
    strip.fill(strip.Color(green, red, blue));
    strip.show();
  }
}

void handleFade() {
  while (true) {
    for (int i = 0; i <= 255; i++) {
      strip.fill(strip.Color(i, 0, 255 - i));
      strip.show();
      delay(15);
      getRequests();
      if (state != "Fade") break;
    }
    if (state != "Fade") break;
    for (int j = 0; j <= 255; j++) {
      strip.fill(strip.Color(255 - j, j, 0));
      strip.show();
      delay(15);
      getRequests();
      if (state != "Fade") break;
    }
    if (state != "Fade") break;
    for (int k = 0; k <= 255; k++) {
      strip.fill(strip.Color(0, 255 - k, k));
      strip.show();
      delay(15);
      getRequests();
      if (state != "Fade") break;
    }
    if (state != "Fade") break;
  }
}

void handleColorWipe() {
  while (true) {
    colorWipe(strip.Color(0, 255, 0), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(127, 255, 0), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(255, 255, 0), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(255, 0, 0), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(255, 0, 127), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(255, 0, 255), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(0, 0, 255), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(0, 127, 255), 50);
    if (state != "ColorWipe") break;
    colorWipe(strip.Color(0, 255, 255), 50);
    if (state != "ColorWipe") break;
  }
}

void colorWipe(uint32_t color, int wait) {
  for (int i = 0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, color);
    strip.show();
    delay(wait);
  }
  getRequests();
}

void handleFire() {
  red = server.arg("red").toInt();
  green = server.arg("green").toInt();
  blue = server.arg("blue").toInt();
  while (true) {
    for (int x = 0; x < strip.numPixels(); x++){
      int flicker = random(0, 50);
      int r1 = red - flicker;
      int g1 = green - flicker;
      int b1 = blue - flicker;
      if (g1 < 0) g1 = 0;
      if (r1 < 0) r1 = 0;
      if (b1 < 0) b1 = 0;
      strip.setPixelColor(x, g1, r1, b1);
    }
    strip.show();
    delay(random(150, 200));
    getRequests();
    if (state != "ColorWipe") break;
    if (server.hasArg("red")) {
      if (server.arg("red").toInt() != red || server.arg("green").toInt() != green || server.arg("blue").toInt() != blue) break;
    }
  }
}

void handleSideFill() {
  red = server.arg("red").toInt();
  green = server.arg("green").toInt();
  blue = server.arg("blue").toInt();
  while (true) {
    for (uint16_t i = 0; i < (strip.numPixels() / 2); i++) {
      strip.setPixelColor(i, strip.Color(green, red, blue));
      strip.setPixelColor(strip.numPixels() - i, strip.Color(green, red, blue));
      strip.show();
      delay(30);
    }
    getRequests();
    if (state != "SideFill") break;
    if (server.hasArg("red")) {
      if (server.arg("red").toInt() != red || server.arg("green").toInt() != green || server.arg("blue").toInt() != blue) break;
    }
    for (uint16_t i = 0; i < (strip.numPixels() / 2); i++) { // reverse
      strip.setPixelColor(strip.numPixels() / 2 + i, strip.Color(0, 0, 0));
      strip.setPixelColor(strip.numPixels() / 2 - i, strip.Color(0, 0, 0));
      strip.show();
      delay(30);
    }
    getRequests();
    if (state != "SideFill") break;
    if (server.hasArg("red")) {
      if (server.arg("red").toInt() != red || server.arg("green").toInt() != green || server.arg("blue").toInt() != blue) break;
    }
  }
}

void handleXmas() {
  while (true) {
    for (int x = 0; x < strip.numPixels(); x++){
      int flicker = random(0, 5);
      strip.setPixelColor(x, xmasColors[flicker]);
    }
    strip.show();
    delay(700);
    getRequests();
    if (state != "Xmas") break;
  }
}

void handleModoOculto() {
  while (true) {
    for (int i = 0; i <= 255; i++) {
      strip.fill(strip.Color(0, 255, 255 - i));
      strip.show();
      delay(15);
      getRequests();
      if (state != "ModoOculto") break;
    }
    if (state != "ModoOculto") break;
    for (int j = 0; j <= 255; j++) {
      strip.fill(strip.Color(0, 255, j));
      strip.show();
      delay(15);
      getRequests();
      if (state != "ModoOculto") break;
    }
    if (state != "ModoOculto") break;
  }
}

void handleTurnOff() {
  strip.clear();
  strip.show();
}


void loop() {
  getRequests();
  if(state == "Rainbow"){
    handleState();
    handleRainbow();
  }else if(state == "ColorPuro"){
    handleState();
    handleColorPuro();
  }else if(state == "Fade"){
    handleState();
    handleFade();
  }else if(state == "ColorWipe"){
    handleState();
    handleColorWipe();
  }else if(state == "Fire"){
    handleState();
    handleFire();
  }else if(state == "SideFill"){
    handleState();
    handleSideFill();
  }else if(state == "Xmas"){
    handleState();
    handleXmas();
  }else if(state == "ModoOculto"){
    handleState();
    handleModoOculto();
  }else if (state == "TurnOff"){
    handleState();
    handleTurnOff();
  }else{
    handleNotFound();
  }
}
