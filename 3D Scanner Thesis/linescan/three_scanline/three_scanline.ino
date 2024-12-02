// Define pin connections & motor's steps per revolution
const int dirPin_X = 5;
const int stepPin_X = 2;

const int dirPin_Y = 6;
const int stepPin_Y = 3;

const int dirPin_Z = 7;
const int stepPin_Z = 4;

// Define the value stored for the  scanning process
int step_size_x = 0;
int steps_x = 0;

int step_size_y = 0;
int steps_y = 0;

int step_size_z = 0;
int steps_z = 0;


void setup() {
  Serial.begin(115200);
  //pinMode(LED_BUILTIN, OUTPUT);
  pinMode(stepPin_X, OUTPUT);
	pinMode(dirPin_X, OUTPUT);

  pinMode(stepPin_Y, OUTPUT);
	pinMode(dirPin_Y, OUTPUT);

  pinMode(stepPin_Z, OUTPUT);
	pinMode(dirPin_Z, OUTPUT);
  
}


// Since we want to 
void loop() {
  // helper to parse the message
  int firstComma;    
  int secondComma; 
  int thirdComma; 
  int fourthComma;

  //information for movement control

  int axis;
  int step_size;
  int dir;
  int step_amount;

  if (Serial.available() > 0) {
    
    String input = Serial.readString();

    //getting start "s" means it is the start information
    //"L" means that switch to next line scanning

    // getting start info or S
    char start_line = input.charAt(0);
    if (start_line == 's') {
        //parse as start and scan the line scan

      //position of Comma
      firstComma = input.indexOf(',');    
      secondComma = input.indexOf(',', firstComma + 1); 
      thirdComma = input.indexOf(',', secondComma + 1);
      fourthComma = input.indexOf(',', thirdComma + 1);

      //info to do line scan
      axis = input.substring(firstComma + 1, secondComma).toInt();
      step_size = input.substring(secondComma + 1, thirdComma).toInt();
      dir = input.substring(thirdComma + 1, fourthComma).toInt();
      step_amount = input.substring(fourthComma + 1).toInt();

      if (axis == 1) {
        for (int i = 0; i < step_amount; i++) {
          move_x(1,step_size,dir);
          delay(500);         // this need to be adjusted for oscilloscope data collection time
        }
      } else if (axis == 2) {
        for (int i = 0; i < step_amount; i++) {
          move_y(1,step_size,dir);
          delay(500);         // this need to be adjusted for oscilloscope data collection time
        }
      } else if (axis == 3) {
        for (int i = 0; i < step_amount; i++) {
          move_z(1, step_size,dir);
          delay(500);         // this need to be adjusted for oscilloscope data collection time
        }
      } else{

      }
      Serial.println("gota");
      Serial.println("\n");
        
}
    else if(start_line == 'L') {
        //parse and move once
      
      //position of Comma
      firstComma = input.indexOf(',');    
      secondComma = input.indexOf(',', firstComma + 1); 
      thirdComma = input.indexOf(',', secondComma + 1);

      //info to do corner move
      axis = input.substring(firstComma + 1, secondComma).toInt();
      step_size = input.substring(secondComma + 1, thirdComma).toInt();
      dir = input.substring(thirdComma + 1).toInt();

      if (axis == 1) {
        move_x(1,step_size,dir);
      } else if (axis == 2) {
        move_y(1,step_size,dir);
      } else if (axis == 3) {
        move_z(1,step_size,dir);
      } else{

      }

      Serial.println("gotb");
      Serial.println("\n");
      }
}

}

void move_x (int speed, int d,char dir){ // the speed is in milisecond/revolution
// dir = 1/0
if (dir == '1'){
  digitalWrite(dirPin_X, HIGH);
} else if (dir == '0'){
  digitalWrite(dirPin_X,LOW);
}
digitalWrite(stepPin_X, HIGH);
	for(int a = 0; a < d; a++) {
		digitalWrite(stepPin_X, HIGH);
    delayMicroseconds(125);
		digitalWrite(stepPin_X, LOW);
    delayMicroseconds(125);
    delay(speed);
	}
}


void move_y (int speed, int d,char dir){ // the speed is in milisecond/revolution
// dir = 1/0
if (dir == '1'){
  digitalWrite(dirPin_Y, HIGH);
} else if (dir == '0'){
  digitalWrite(dirPin_Y,LOW);
}
digitalWrite(stepPin_Y, HIGH);
	for(int a = 0; a < d; a++) { 
		digitalWrite(stepPin_Y, HIGH);
    delayMicroseconds(125);
		digitalWrite(stepPin_Y, LOW);
    delayMicroseconds(125);
    }
    delay(speed);
}


void move_z (int speed, int d,char dir){ // the speed is in milisecond/revolution
// dir = 1/0
if (dir == '1'){
  digitalWrite(dirPin_Z, HIGH);
} else if (dir == '0'){
  digitalWrite(dirPin_Z,LOW);
}
digitalWrite(stepPin_Z, HIGH);
	for(int a = 0; a < d; a++) {
		digitalWrite(stepPin_Z, HIGH);
    delayMicroseconds(125);
		digitalWrite(stepPin_Z, LOW);
    delayMicroseconds(125);
    delay(speed);
	}
}
