#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Adafruit_NeoPixel.h>

const char* ssid = "YOURSSID";
const char* password = "YOURPASS";

IPAddress local_IP(192, 168, 1, 200);
IPAddress gateway(192, 168, 1, 1);
IPAddress subnet(255, 255, 255, 0);

#define LED_PIN   D6
#define LED_COUNT 50
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

ESP8266WebServer server(80);
int red;
int blue;
int green;
int redF;
int greenF;
int blueF;
int op;

void setup() {
  Serial.begin(115200);

  WiFi.begin(ssid, password);
  WiFi.config(local_IP, gateway, subnet);
  delay(100);

  server.on("/colorPuro", handleColorPuro);
  server.on("/state", handleState);
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
  server.send(200, "text/plain", "Estado Cambiado: " + op);
}

void handleColorPuro() {
  strip.clear();
  red = server.arg("red").toInt();
  green = server.arg("green").toInt();
  blue = server.arg("blue").toInt();
  strip.fill(strip.Color(green, red, blue));
  strip.show();
  op = 0;
  server.send(200, "text/plain", "handleColorPuro");
}

void handleFade() {
  //blue to green
  server.send(200, "text/plain", "fade");
  for (int i = 0; i <= 255; i++) {
    strip.fill(strip.Color(i, 0, 255 - i));
    strip.show();
    delay(15);
  }
  server.handleClient();
  if (server.hasArg("estado")) {
    op = server.arg("estado").toInt();
    if (op != 1) {
      strip.clear();
    }
  }
  //green to red
  for (int j = 0; j <= 255; j++) {
    strip.fill(strip.Color(255 - j, j, 0));
    strip.show();
    delay(15);
  }
  server.handleClient();
  if (server.hasArg("estado")) {
    op = server.arg("estado").toInt();
    if (op != 1) {
      strip.clear();
    }
  }
  //red to blue
  for (int k = 0; k <= 255; k++) {
    strip.fill(strip.Color(0, 255 - k, k));
    strip.show();
    delay(15);
  }
  server.handleClient();
  if (server.hasArg("estado")) {
    op = server.arg("estado").toInt();
    if (op != 1) {
      strip.clear();
    }
  }
}

void rainbow() {
  while (true) {
    for (long firstPixelHue = 0; firstPixelHue < 5 * 65536; firstPixelHue += 256) {
      for (int i = 0; i < strip.numPixels(); i++) { // For each pixel in strip...
        int pixelHue = firstPixelHue + (i * 65536L / strip.numPixels());
        strip.setPixelColor(i, strip.gamma32(strip.ColorHSV(pixelHue)));
      }
      strip.show(); // Update strip with new contents
      delay(15);
      server.handleClient();
      if (server.hasArg("estado")) {
        op = server.arg("estado").toInt();
        if (op != 2) {
          break;
          strip.clear();
        }
      }
    }
    if (op != 2) {
      break;
      strip.clear();
    }
  }
}

void colorWipe(uint32_t color, int wait) {
  for (int i = 0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, color);
    strip.show();
    delay(wait);
  }
}

void colorWiper() {
  while (true) {
    colorWipe(strip.Color(0, 255, 0), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(127, 255, 0), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(255, 255, 0), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(255, 0, 0), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(255, 0, 127), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(255, 0, 255), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(0, 0, 255), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(0, 127, 255), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
    colorWipe(strip.Color(0, 255, 255), 50);
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 3) {
        break;
        strip.clear();
      }
    }
  }
}

void fire() {
  redF = server.arg("redF").toInt();
  greenF = server.arg("greenF").toInt();
  blueF = server.arg("blueF").toInt();
  while (true) {
    for (int x = 0; x < strip.numPixels(); x++)
    {
      int flicker = random(0, 50);
      int r1 = redF - flicker;
      int g1 = greenF - flicker;
      int b1 = blueF - flicker;
      if (g1 < 0) g1 = 0;
      if (r1 < 0) r1 = 0;
      if (b1 < 0) b1 = 0;
      strip.setPixelColor(x, g1, r1, b1);
    }
    strip.show();
    delay(random(150, 200));
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 4) {
        break;
        strip.clear();
      }
    }
    if (server.hasArg("redF")) {
      if(server.arg("redF").toInt()!= redF || server.arg("greenF").toInt()!= greenF || server.arg("blueF").toInt()!= blueF){
        break;
        strip.clear();
      }
    }
  }
}

void sideFill() {
  redF = server.arg("redF").toInt();
  greenF = server.arg("greenF").toInt();
  blueF = server.arg("blueF").toInt();
  while (true) {
    for (uint16_t i = 0; i < (strip.numPixels() / 2); i++) { // fill strip from sides to middle
      strip.setPixelColor(i, strip.Color(greenF, redF, blueF));
      strip.setPixelColor(strip.numPixels() - i, strip.Color(greenF, redF, blueF));
      strip.show();
      delay(30);
    }

    for (uint16_t i = 0; i < (strip.numPixels() / 2); i++) { // reverse
      strip.setPixelColor(strip.numPixels() / 2 + i, strip.Color(0, 0, 0));
      strip.setPixelColor(strip.numPixels() / 2 - i, strip.Color(0, 0, 0));
      strip.show();
      delay(30);
    }
    server.handleClient();
    if (server.hasArg("estado")) {
      op = server.arg("estado").toInt();
      if (op != 5) {
        break;
        strip.clear();
      }
    }
    if (server.hasArg("redF")) {
      if(server.arg("redF").toInt()!= redF || server.arg("greenF").toInt()!= greenF || server.arg("blueF").toInt()!= blueF){
        break;
        strip.clear();
      }
    }
  }
}

void apagarLeds() {
  strip.clear();
  strip.show();
  op = 7;
}

void loop() {
  server.handleClient();
  if (server.hasArg("estado")) {
    op = server.arg("estado").toInt();
  }
  switch (op) {
    case 1:
      handleFade();
      break;
    case 2:
      rainbow();
      break;
    case 3:
      colorWiper();
      break;
    case 4:
      fire();
      break;
    case 5:
      sideFill();
      break;
    case 6:
      apagarLeds();
      break;
    default:
      server.handleClient();
      break;
  }
}
