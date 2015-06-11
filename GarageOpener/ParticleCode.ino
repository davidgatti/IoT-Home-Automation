// Variables
int isOpen = 0;
int useCount = 0;
char userName[100];

// Functions
int openCloseGarage(String string);
int updateName(String name);
int incrementUse(String string);

// Pins
int led1 = D1;

void setup() {

// Variables
Spark.variable("isopen", &isOpen, INT);
Spark.variable("usecount", &useCount, INT);
Spark.variable("username", &userName, STRING);

// Functions
Spark.function("openclose", openCloseGarage);
Spark.function("updatename", updateName);
Spark.function("incrementuse", incrementUse);

// Pins
pinMode(D1, INPUT);
}

void loop() {}

int openCloseGarage(String string) {

isOpen = !isOpen;

pinMode(D1, OUTPUT);
digitalWrite(D1, HIGH);

delay(500);
pinMode(D1, INPUT);

return 0;
}

int updateName(String name) {

strcpy(userName, name.c_str());

return 0;
}

int incrementUse(String string) {

useCount++;

return 0;
}