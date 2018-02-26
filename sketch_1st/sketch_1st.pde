// LidarScanner.pde Processing sketch
// http://www.qcontinuum.org/lidar

// Load sketch into Processing, available from:
// https://processing.org/

// This sketch accepts XYZ coordinates from Arduino LIDAR scanner
// and displays them graphically as a 3D point cloud that you can
// pan, zoom, and rotate using keyboard.

import processing.serial.*;

Serial serial;
int serialPortNumber = 0;
float angle = 6.5f;
float angleIncrement = 0;
float xOffset = 3.0;
float xOffsetIncrement = 0;
float yOffset = 152.0f;
float yOffsetIncrement = 0;
float scale = 2.6f;
float scaleIncrement = 0;
//ArrayList<PVector> vectors;
int lastPointIndex = 0;
int lastPointCount = 0;

int MAX_ROW = 1000000;
int MAX_COLUM = 3;
String[] mapForDraw;
float[][] dotData = new float[MAX_ROW][MAX_COLUM];

void setup() {
  size(800, 600, P3D);
  colorMode(RGB, 255, 255, 255);
  noSmooth();
  
  mapForDraw = loadStrings("myRoom2.csv");
  //vectors = new ArrayList<PVector>();
  
  // If the File could be opned
  if(mapForDraw != null) {
    for(int i = 0; i < mapForDraw.length; i++) {
      // Check If It Is Not Brank
      if(mapForDraw[i].length() != 0) {
        // Separate by ",".
        String[] values = split(mapForDraw[i], ',');
        // Read As Many Columns
        for(int j = 0; j < 3; j++) {
          if(values[j] != null && values[j].length() != 0) {
            dotData[i][j] = float(values[j]);
          }
        }
      }
    }
  }
  
  /*String[] serialPorts = Serial.list();
  String serialPort = serialPorts[serialPortNumber];
  println("Using serial port \"" + serialPort + "\"");
  println("To use a different serial port, change serialPortNumber:");
  printArray(serialPorts);
  serial = new Serial(this, serialPort, 115200);*/
}

void draw() {
  /*String input = mapForDraw.readStringUntil(10); //Read Until "10" means "\n" comes.
  if (input != null) {
    String[] components = split(input, ','); // Separate by ",".
    if (components.length == 3) {
      vectors.add(new PVector(float(components[0]), float(components[1]), float(components[2])));
    }
  }*/
  
  background(0); //Back Ground Color Is Black.
  translate(width/2, height/2, -50);
  rotateY(angle);
  for (int index = 0; index < mapForDraw.length; index++) {
    //PVector v = vectors.get(index);
    /*if (index == size - 1) {
      // draw red line to show recently added LIDAR scan point
      if (index == lastPointIndex) {
        lastPointCount++;
      } else {
        lastPointIndex = index;
        lastPointCount = 0;
      }
      if (lastPointCount < 10) {
        stroke(255, 0, 0);
        line(xOffset, yOffset, 0, v.x * scale + xOffset, -v.z * scale + yOffset, -v.y * scale);
      }
    }*/
    stroke(255, 255, 255);
    point(dotData[index][0] * scale + xOffset, -dotData[index][2] * scale + yOffset, -dotData[index][1] * scale);// [Attention!!]X, Z, Y
  }
  angle += angleIncrement;
  xOffset += xOffsetIncrement;
  yOffset += yOffsetIncrement;
  scale += scaleIncrement;
}

void keyPressed() {
  if (key == 'q') {
    // zoom in
    scaleIncrement = 0.02f;
  } else if (key == 'z') {
    // zoom out
    scaleIncrement = -0.02f;
  } else if (key == 'a') {
    // move left
    xOffsetIncrement = -1f;
  } else if (key == 'd') {
    // move right
    xOffsetIncrement = 1f;
  } else if (key == 'w') {
    // move up
    yOffsetIncrement = -1f;
  } else if (key == 's') {
    // move down
    yOffsetIncrement = 1f;
  } else if (key =='x') {
    // erase all points
    //dotMap.clear();
  } else if (key == CODED) {
    if (keyCode == LEFT) {
      // rotate left
      angleIncrement = -0.015f;
    } else if (keyCode == RIGHT) {
      // rotate right
      angleIncrement = 0.015f;
    }
  }
}

void keyReleased() {
  if (key == 'q') {
    scaleIncrement = 0f;
  } else if (key == 'z') {
    scaleIncrement = 0f;
  } else if (key == 'a') {
    xOffsetIncrement = 0f;
  } else if (key == 'd') {
    xOffsetIncrement = 0f;
  } else if (key == 'w') {
    yOffsetIncrement = 0f;
  } else if (key == 's') {
    yOffsetIncrement = 0f;
  } else if (key == CODED) {
    if (keyCode == LEFT) {
      angleIncrement = 0f;
    } else if (keyCode == RIGHT) {
      angleIncrement = 0f;
    }
  }
}
