void serialEvent(Serial port) {   
  String inData = port.readStringUntil('\n');  // read the ascii data into a String
  println(inData);
  inData = trim(inData);
  if (inData.charAt(0) == 'S') {           // leading 'S' means Pulse Sensor data packet
    beatReading = convert2Int(inData);    // convert ascii string to integer
  }   

  if (inData.charAt(0) == 'T') {
    tempReading = convert2Int(inData);
  }
  
  if (inData.charAt(0) == 'G') {
    gsrReading = convert2Int(inData);
  }
}// END OF SERIAL EVENT

int convert2Int(String inData) {
  inData = inData.substring(1);
  return int(inData);
}

