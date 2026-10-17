// Variables to store received data
String receivedPacket = "";
String receivedOrder = "";
bool sendData = false;
bool receivingPacket = false;
float controlSignal;

void setup() {
  Serial.begin(115200);  // Initialize serial communication at 9600 bps
  pinMode(13, 1);
  digitalWrite(13, 0);
}

void loop() {
  // Only send data if sendData is true
  if (sendData) {
    float SensorInput = map(analogRead(0), 0, 1023, 0, 100);
    String sentPacket = "(" + String(SensorInput) + ")";
    int length = sentPacket.length();
    char charArray[length + 1];
    sentPacket.toCharArray(charArray, length + 1);
    Serial.write(charArray);
    delay(5);  // Adjust delay as needed depending on the speed of you CPU
  }
}

// This function is called automatically when serial data is available
void serialEvent() {
  while (Serial.available()) {
    char incomingChar = Serial.read();

    // Check for the start of a packet
    if (incomingChar == '(') {
      receivingPacket = true;  // Start accumulating data
      receivedPacket = "";     // Reset packet
    }

    // Accumulate characters if within a packet
    if (receivingPacket) {
      receivedPacket += incomingChar;

      // Stop accumulating and process the packet when ')' is detected
      if (incomingChar == ')') {
        receivingPacket = false;        // End packet accumulation
        processPacket(receivedPacket);  // Process the complete packet
        receivedPacket = "";            // Reset for the next packet
      }
    }
  }
  if (receivedOrder == "turn on led 13")
    digitalWrite(13, 1);
  else if (receivedOrder == "turn off led 13")
    digitalWrite(13, 0);
}

// Function to process received packet
void processPacket(String packet) {
  // Ensure the packet format starts with '(' and ends with ')'
  if (packet.startsWith("(start") && packet.endsWith(")")) {
    sendData = true;  // Start sending data
  } else if (packet.startsWith("(stop") && packet.endsWith(")")) {
    sendData = false;  // Stop sending data
  } else if (packet.startsWith("(") && packet.endsWith(")")) {
    String input = packet.substring(1, packet.length() - 1);
    if (input.startsWith("<") && input.endsWith(">"))
      receivedOrder = input.substring(1, input.length() - 1);
    else
      controlSignal = input.toFloat();
  }
  // controlSignal
}
