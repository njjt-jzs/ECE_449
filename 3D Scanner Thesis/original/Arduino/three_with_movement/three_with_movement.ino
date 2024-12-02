// Define pin connections & motor's steps per revolution
const int dirPin_X = 5;
const int stepPin_X = 2;

const int dirPin_Y = 6;
const int stepPin_Y = 3;

const int dirPin_Z = 7;
const int stepPin_Z = 4;
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

void loop() {
  if (Serial.available() > 0) {
    
    String receivedString = Serial.readString();

    // getting direction info
    char x_dir_info = receivedString.charAt(0);
    char y_dir_info = receivedString.charAt(5);
    char z_dir_info = receivedString.charAt(10);


    // getting distance info
    String x_dis_info = receivedString.substring(1,4);
    String y_dis_info = receivedString.substring(6,9);
    String z_dis_info = receivedString.substring(11,14);

    int distance_x = x_dis_info.toInt();
    int distance_y = y_dis_info.toInt();
    int distance_z = z_dis_info.toInt();


    char firstCharacter = receivedString[0];
    String distance_string = receivedString.substring(1);
    int distance = distance_string.toInt();
    int intfirst = firstCharacter - '0';
    //Serial.println(receivedString);


    // move the motor on each axis accordingly
    if (distance_x != 0) {
      move_x (1, distance_x,x_dir_info);

    }
    if (distance_y != 0){
      move_y (1, distance_y,y_dir_info);    
    }
    if (distance_z != 0){
      move_z(1, distance_z,z_dir_info);
    }



    Serial.println("got\n");
  } else{
    
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
