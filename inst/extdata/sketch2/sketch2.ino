//
// Sketch #2
// Listen to the Serial Port for Instructions and Print Register Values
// Sketch is composed of several files that must be compiled and linked.
// Sketch both sends and receives using the serial port, so Rx and Tx LEDs
// will be flashing alternately.
//

volatile boolean start = false;  // flag to start register inspection; global

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  if (Serial) {
    Serial.println("Arduino listening...");
    Serial.println("Enter g or s at any time");  // g = go, s = stop
  }
}

void loop() {
  volatile extern boolean start;
  unsigned char data;
  if (Serial.available()) {
    data = Serial.read();
    if (data == 'g') {
      start = true;
    } else if (data == 's') {
      start = false;
    }
  }

  if (start) {
    // print the values of some registers
    Serial.print("UCSR0C register: ");
    print_bin(UCSR0C);
    Serial.print("ADCSRA register: ");
    print_bin(ADCSRA);
    Serial.println(" ");
  }
}
