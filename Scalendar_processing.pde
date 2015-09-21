import processing.serial.*;

int[] angles = { 28, 28, 88, 28, 28, 28, 28, 28, 28, 28 };
String[] clockPointers = { "3", "4", "5", "8", "9", "10", "11", "12", "1", "2" };
String [] names = { "Elsa", "Lucas", "Hans", "Norm", "Ophelia", "Alfred",
                    "Bob", "Anna", "Lucca", "Bonnie"};
           
color bgColor = color(220, 236, 219);
color available = color(106, 210, 112);
color busy = color(204, 157, 15);
color na = color(172, 157, 145);
color textColor = color(0, 102, 153);
color[] storeOtherPiesColor = new color[81];
color[] storeMainPieColor = {available, available, na, available, available, available, available, available, available, available};
color[] randomC = {available, busy};
PieCalendar pieMain;
int pieceNo = 0;
int count = 0;
int j = 0;

boolean controlA = false, controlB = false, controlC =false, controlD = false, 
        controlE = false, controlF = false, controlG = false, controlH = false,controlI = false;

// variables for serial connection, portname and baudrate have to be set 
Serial port;
String portname; 
int baudrate = 9600;
int value = 3;
String buf=""; 

int value1 = 400;
int value2 = 400;
int value3 = 400;
int value4 = 400;
int value5 = 400;
int value6 = 400;
int value7 = 400;
int value8 = 400;
int value9 = 400;
int valueTemp = 0;

int portLoopCount = 1;
boolean output = true;
int threshold = 750;

int counter = 0;
int [] keepvaluearray = {0, 0, 0, 0, 0, 0, 0, 0, 0};

void setup() {
  size (1200, 640);
  noStroke();
  
  println(Serial.list());
  portname = Serial.list()[2];
  // Set the Serial port from the listin [] field
 
  // establish serial port connection  
  println("testing");  
  port = new Serial(this, portname, baudrate);
  
  //myPort.write("0");
  println(port);
 
}

void draw() {
  
  background (bgColor);
  stroke(0);
  strokeWeight(1);
  drawTitle();

  if (keyPressed == true){
    port.write('1');
   count++;
  }
  
  controlA = (value1 > threshold) ? true : false;
  controlB = (value2 > threshold) ? true : false;
  controlC = (value3 > threshold) ? true : false;
  controlD = (value4 > threshold) ? true : false;
  controlE = (value5 > threshold) ? true : false;
  controlF = (value6 > threshold) ? true : false;
  //below codes formore pinsusage
  controlG = (value7 > threshold) ? true : false;
  controlH = (value8 > threshold) ? true : false;
  controlI = (value9 > threshold) ? true : false;
  
  pieMain = new PieCalendar(width/10, (height-100)/4+100, 180, available,
              textColor, names[0], 12, 0, pieceNo); 
  pieMain.drawCalendar();
  
  createAndDrawOtherPies();
  
  while(port.available() > 0) {   
    value = port.read();
    println("the value read from arduino: " + value);
    serialEvent(value);
  }
}

void serialEvent(int serial) {
 
  if(serial<200) {        
    // add event to buffer
    buf += char(serial);
    //println("buf is: ", int(buf));
  }
  else {
    // if serial is line break set value1 to buff and clear it
    // if more pin values come in, will portLoopCount = 0 in value9, the codes are quite straightforward
    if (serial == 246) {
      value1 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (serial == 245) {
      value2 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (serial == 244) {
      value3 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (serial == 243) {
      value4 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (serial == 242) {
      value5 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (serial == 241) {
      value6 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum   
    }
    else if (serial == 240) {
      value7 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum  
    }
    else if (serial == 239) {
      value8 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (serial == 238) {
      value9 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum    
      
   }
    buf="";
  }
}


void serialdEvent(int serial) {
 
  if(serial<10) {        
    // add event to buffer
    buf += char(serial);
    //println("buf is: ", int(buf));
  }
  else {
    // if serial is line break set value1 to buff and clear it
    // if more pin values come in, will portLoopCount = 0 in value9, the codes are quite straightforward
    if (portLoopCount == 1) {
      value1 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (portLoopCount == 2) {
      value2 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (portLoopCount == 3) {
      value3 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (portLoopCount == 4) {
      value4 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (portLoopCount == 5) {
      value5 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (portLoopCount == 6) {
      value6 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum   
    }
    else if (portLoopCount == 7) {
      value7 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum  
    }
    else if (portLoopCount == 8) {
      value8 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum
    }
    else if (portLoopCount == 9) {
      value9 = 1023 - int(buf); // we inverse the value by subtracting it from the maximum        
   }
    portLoopCount++;
    if (portLoopCount>9) portLoopCount=1;
    buf="";
  }
}

void createAndDrawOtherPies() {
   
   float piece = width/10;
   float currentCenterX = 0, currentCenterX1 = 0;
   PieCalendar pieSam;
   for (int i = 1; i < names.length; i++) {
     if (i <= 4) {
       currentCenterX = piece + piece*i*2;
       pieSam = new PieCalendar(currentCenterX, ((height-100)/4 +100), 180, 
                   available, textColor, names[i], 12, i, 0);
       pieSam.drawCalendar();
     }
     if (i > 4){
       currentCenterX1 = piece + piece*(i-5)*2;
       pieSam = new PieCalendar(currentCenterX1, ((height-100)/4*3+100), 180, 
                   available, textColor, names[i], 12, i, 0);
       pieSam.drawCalendar();
     }
   }
   
   j = 0;
}

void drawTitle() {
    textSize(20);
    fill(0);
    text("Office Calendar", width/3, height/10);
    noStroke();
    fill(available);
    arc(width/3 + 200, height/10 - 50, 100, 100, radians(70), radians(110));
    fill(bgColor);
    arc(width/3 + 200, height/10 - 50, 70, 70, radians(65), radians(115));
    fill(busy);
    arc(width/3 + 275, height/10 - 50, 100, 100, radians(70), radians(110));
    fill(bgColor);
    arc(width/3 + 275, height/10 - 50, 70, 70, radians(65), radians(115));
    fill(na);
    arc(width/3 + 350, height/10 - 50, 100, 100, radians(70), radians(110));
    fill(bgColor);
    arc(width/3 + 350, height/10 - 50, 70, 70, radians(65), radians(115));
    
    fill(0);
    textSize(12);
    text("Available", width/3 + 175, height/10+15);
    text("Busy", width/3 + 262, height/10+15);
    text("N/A", width/3 + 337, height/10+15);
}

class PieCalendar {
  float positionX;
  float positionY;
  float diameter;
  color pieCol, textCol;
  String name;
  float nameX, nameY;
  int textS;
  int pieNo;
  int pieceNo;
  
  PieCalendar(float x, float y, float diam, color c, color c1,
              String n, int s, int i, int p) {
    positionX = x;
    positionY = y;
    diameter = diam;
    pieCol = c;
    textCol = c1;
    name = n;
    textS = s;
    pieNo = i;
    pieceNo = p;
  }
  
  void drawCalendar() {
    float lastAngle = 0;
    
    for (int i = 0; i < angles.length; i++) {
      if (i == 2) {
        fill(storeMainPieColor[i]);
      } 
      else {
        if (pieNo >= 1 && count==0){
          int index = int(random(randomC.length));
          storeOtherPiesColor[j] = randomC[index];  
          fill(storeOtherPiesColor[j]);
          j++;
        }
        else if(pieNo >= 1 && count > 0){
          fill(storeOtherPiesColor[j]);
          j++;
        }
       
        if (pieNo == 0) {
          fill(storeMainPieColor[i]);
          if (i == 3 && controlA == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 3 && controlA == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 4 && controlB == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 4 && controlB == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 5 && controlC == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 5 && controlC == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 6 && controlD == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 6 && controlD == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 7 && controlE == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 7 && controlE == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 8 && controlF == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 8 && controlF == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 9 && controlG == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 9 && controlG == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 0 && controlH == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 0 && controlH == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
          if (i == 1 && controlI == true){
            fill(busy);
            storeMainPieColor[i] = busy;
          }
          else if (i == 1 && controlI == false){
            fill(pieCol);
            storeMainPieColor[i] = pieCol;
          }
        }
      }
            
      stroke(0);
      arc(positionX, positionY, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
      lastAngle = lastAngle+radians(angles[i])+radians(2);
    }
    // draw all other things
    drawClockPointers();
    drawInsideCircle();
    drawName();
    drawClock();
  }
  
  void drawClock(){
    
    int radius = int (diameter/1.8);
    float secondsRadius = radius * 0.72;
    float minutesRadius = radius * 0.60;
    float hoursRadius = radius * 0.50;
    
    strokeWeight(2);
    float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
    float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
    float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
    float cx = positionX;
    float cy = positionY;
    // comments out second pointer since looks anoying.
    //line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
    strokeWeight(2);
    line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
    strokeWeight(4);
    line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
    
    strokeWeight(1);
    /*
    strokeWeight(2);
    beginShape(POINTS);
    for (int a = 0; a < 360; a+=6) {
      float angle = radians(a);
      float x = cx + cos(angle) * secondsRadius;
      float y = cy + sin(angle) * secondsRadius;
      vertex(x, y);
    }
    endShape();
    */
  }
  void drawClockPointers(){
    float pointerAngle = 0;
    
    for (int i = angles.length - 1; i >= 0; i--) {
      pointerAngle = pointerAngle + angles[i] + 2;
      float x1 = positionX + diameter/2* (cos(radians(pointerAngle)));
      float y1 = positionY - diameter/2* (sin(radians(pointerAngle)));
      textSize(textS);
      fill(textCol);
      if (clockPointers[i].equals("2")){  
        text( clockPointers[i], x1+5, y1 );
      }
      else if (clockPointers[i].equals("1")){  
        text( clockPointers[i], x1-5, y1-5 );
      }
      else if (clockPointers[i].equals("12")){  
        text( clockPointers[i], x1-8, y1-5 );
      }
      else if (clockPointers[i].equals("11")){  
        text( clockPointers[i], x1-12, y1-5 );
        nameX = x1+8;
      }
      else if (clockPointers[i].equals("10")){  
        text( clockPointers[i], x1-20, y1 );
      }
      else if (clockPointers[i].equals("9")){  
        text( clockPointers[i], x1-12, y1+5 );
      }
      else if (clockPointers[i].equals("8")){  
        text( clockPointers[i], x1-12, y1+10 );
        nameY = y1;
      }
      else if (clockPointers[i].equals("5")){  
        text( clockPointers[i], x1, y1+15 );
      }
      else if (clockPointers[i].equals("4")){  
        text( clockPointers[i], x1, y1+10 );
      }
      else if (clockPointers[i].equals("3")){  
        text( clockPointers[i], x1+5, y1+5 );
      }
    }
  }
  
  void drawName() {
    textSize(textS+2);
    fill(textCol);
    text(name, nameX, nameY);
  }
  
  void setPieceNo(int p) {
    pieceNo = p;
  }
  
  void drawInsideCircle() {
    fill(bgColor);
    ellipse(positionX, positionY, diameter-40, diameter-40); 
  }
  
  int getPieceNo(){
    return pieceNo;
  }
  
}

