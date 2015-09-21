
int brightness = 0;    // how bright the LED is
int fadeAmount = 3;
int sensorLimit = 250;

char val = '0';

const int red1 = 11;
const int red2 = 23;
const int red3 = 24;
const int red4 = 26;
const int red5 = 28;
const int red6 = 30;
const int red7 = 32;
const int red8 = 34;
const int red9 = 36;

const int green1 = 2;
const int green2 = 3;
const int green3 = 4;
const int green4 = 5;
const int green5 = 6;
const int green6 = 7;
const int green7 = 8;
const int green8 = 9;
const int green9 = 10;

int sensor1;
int sensor2;
int sensor3;
int sensor4;
int sensor5;
int sensor6;
int sensor7;
int sensor8;
int sensor9;

void setup()  { 
  pinMode(red1, OUTPUT);
  pinMode(red2, OUTPUT);
  pinMode(red3, OUTPUT);
  pinMode(red4, OUTPUT);
  pinMode(red5, OUTPUT);
  pinMode(red6, OUTPUT);
  pinMode(red7, OUTPUT);
  pinMode(red8, OUTPUT);
  pinMode(red9, OUTPUT);
  
  pinMode(green1, OUTPUT);
  pinMode(green2, OUTPUT);
  pinMode(green3, OUTPUT);
  pinMode(green4, OUTPUT);
  pinMode(green5, OUTPUT);
  pinMode(green6, OUTPUT);
  pinMode(green7, OUTPUT);
  pinMode(green8, OUTPUT);
  pinMode(green9, OUTPUT);
  
  Serial.begin(9600); 
}

void loop()  {
  
  
int sensor1 = analogRead(A0);   
int sensor2 = analogRead(A1)*2; 
int sensor3 = analogRead(A2); 
int sensor4 = analogRead(A3)*4/3; 
int sensor5 = analogRead(A4); 
int sensor6 = analogRead(A5)*2; 
int sensor7 = analogRead(A6); 
int sensor8 = analogRead(A7); 
int sensor9 = analogRead(A8);
int a = 0;

if(sensor1<sensorLimit){
  digitalWrite(red1, 1);
  analogWrite(green1, 0);
}
else{
  digitalWrite(red1, 0);
  analogWrite(green1, brightness);
}

if(sensor2<sensorLimit){
  digitalWrite(red2, 1);
  analogWrite(green2, 0);
  
}
else{
  digitalWrite(red2, 0);
  analogWrite(green2, brightness); 
}


if(sensor3<sensorLimit){
  digitalWrite(red3, 1);
  analogWrite(green3, 0); 
}
else{
  digitalWrite(red3, 0);
  analogWrite(green3, brightness);
}



if(sensor4<sensorLimit){
  digitalWrite(red4, 1);
  analogWrite(green4, 0);

}
else{
  digitalWrite(red4, 0);
  analogWrite(green4, brightness);

}


if(sensor5<sensorLimit){
  digitalWrite(red5, 1);
  analogWrite(green5, 0);

}
else{
  digitalWrite(red5, 0);
  analogWrite(green5, brightness);
}



if(sensor6<sensorLimit){
  digitalWrite(red6, 1);
  analogWrite(green6, 0);
}
else{
  digitalWrite(red6, 0);
  analogWrite(green6, brightness);
}


if(sensor7<sensorLimit){
  digitalWrite(red7, 1);
  analogWrite(green7, 0);
}
else{
  digitalWrite(red7, 0);
  analogWrite(green7, brightness);
}


if(sensor8<sensorLimit){
  digitalWrite(red8, 1);
  analogWrite(green8, 0);
}
else{
  digitalWrite(red8, 0);
  analogWrite(green8, brightness);
}


if(sensor9<sensorLimit){
  digitalWrite(red9, 1);
  analogWrite(green9, 0);
}
else{
  digitalWrite(red9, 0);
  analogWrite(green9, brightness);
}

  // change the brightness for next time through the loop:
  brightness = brightness + fadeAmount;

  // reverse the direction of the fading at the ends of the fade: 
  if (brightness == 0 || brightness == 255) {
    fadeAmount = -fadeAmount ; 
  }     
  // wait for 30 milliseconds to see the dimming effect \
  
 if (Serial.available() && val == '0') 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }

 if (val == '1'){
 Serial.print(sensor1, DEC); 
 Serial.write(-10);
 Serial.print(sensor2, DEC);
Serial.write(-11); 
 Serial.print(sensor3, DEC); 
Serial.write(-12);
 Serial.print(sensor4, DEC);
Serial.write(-13); 
 Serial.print(sensor5, DEC);
Serial.write(-14); 
 Serial.print(sensor6, DEC); 
Serial.write(-15);
 Serial.print(sensor7, DEC); 
Serial.write(-16);
 Serial.print(sensor8, DEC); 
 Serial.write(-17);
 Serial.print(sensor9, DEC); 
 Serial.write(-18);
 }
 
 delay(100);                 
}
