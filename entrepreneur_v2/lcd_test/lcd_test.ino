#include <LiquidCrystal.h>

//LiquidCrystal(rs, rw, enable, d4, d5, d6, d7) 
LiquidCrystal lcd(12, 11, 10, 5, 4, 3, 2);

void setup() {
  //上段
  lcd.begin(16,2);
  lcd.print("hello, world");
  //下段
  lcd.setCursor(0,1);
  lcd.print("Good Bye!");
}

void loop() {}
