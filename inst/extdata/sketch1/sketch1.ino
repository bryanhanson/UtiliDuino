//
// Sketch #1
// A simple sketch that provides visual confirmation that things are working correctly.
// You should see the built-in LED flash for 1 second, followed by a flash of the Tx LED
// on the Arduino, repeatedly.  Tx flashes because Arduino is writing 1...100 repeatedly,
// 20 numbers per line.
//

int wrap = 20;  // used to wrap output & avoid scrolling off to the right

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // flash the built-in LED to say Hi
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
  // spew some data
  Serial.println("");
  for (int i = 1; i <= 100; i++) {
    Serial.print(i);
    Serial.print(" ");
    if ((i % wrap) == 0) {
      Serial.println("");
    }
  }
}
