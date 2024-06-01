// This is a template for creating a looping animation in Processing/Java. 
// When you press the 'F' key, this program will export a series of images
// into a "frames" directory located in its sketch folder. 
// These can then be combined into an animated gif. 
// Known to work with Processing 3.3.6
// Prof. Golan Levin, January 2018

//===================================================
// Global variables. 
String  myNickname = "nickname"; 
int     nFramesInLoop = 400;
int     nElapsedFrames;
boolean bRecording; 

PGraphics pg;
PFont font;

//===================================================
void setup() {
  size (500, 200); 
  bRecording = false;
  nElapsedFrames = 0;
  font = loadFont("./CalistoMT-BoldItalic-100.vlw");
  //dimension of sketch. renderer avoids errors
  noiseDetail(4, 0.5);
  size(800, 800, P2D);
  // where we put our letters
  pg = createGraphics(800, 800, P2D);
}
//===================================================
void keyPressed() {
  if ((key == 'f') || (key == 'F')) {
    bRecording = true;
    nElapsedFrames = 0;
  }
}

//===================================================
void draw() {

  // Compute a percentage (0...1) representing where we are in the loop.
  float percentCompleteFraction = 0; 
  if (bRecording) {
    percentCompleteFraction = (float) nElapsedFrames / (float)nFramesInLoop;
  } else {
    percentCompleteFraction = (float) (frameCount % nFramesInLoop) / (float)nFramesInLoop;
  }

  // Render the design, based on that percentage. 
  renderMyDesign (percentCompleteFraction);

  // If we're recording the output, save the frame to a file. 
  if (bRecording) {
    saveFrame("frames/" + myNickname + "_frame_" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames >= nFramesInLoop) {
      bRecording = false;
    }
  }
}

//===================================================
void renderMyDesign (float percent) {
  //
  // YOUR ART GOES HERE.
  // This is an example of a function that renders a temporally looping design. 
  // It takes a "percent", between 0 and 1, indicating where we are in the loop. 
  // This example uses two different graphical techniques. 
  // Use or delete whatever you prefer from this example. 
  // Remember to SKETCH FIRST!

  background(0);
  //drawing letter on pgraphics element
  // open a pgraphics loop
  pg.beginDraw();
  pg.fill(255);
  pg.textFont(font);
  pg.textSize(75);
  pg.pushMatrix();
  pg.translate(width/2, height/2 - 215);
  pg.textAlign(CENTER, CENTER);
  pg.text("Hallo World", 0, 0);
  pg.text("Hallo World", 0, 100);
  pg.text("Hallo World", 0, 200);
  pg.text("Hallo World", 0, 300);
 
  //pg.ellipse(x, y, 10, 10);
  pg.popMatrix();
  pg.endDraw();
  //x = map(sin(radians(frameCount) * 0.8), -1, 1, -400, 400);
  //y = map(cos(radians(frameCount)), -1, 1, -400, 400);
  //image(pg, 0, 0);
  //determine the number of x and y tiles
  int x_tiles = 30;
  int y_tiles = 30;
  // calculate height and width of tiles
  int tile_w = int(width/x_tiles);
  int tile_h = int(height/y_tiles);
  // iterate the grid using a 2d loop
  
  // 2D Diagonal Elements
  for (int y = y_tiles - 1; y >= 0; y--) {
     for (int x = x_tiles -1 ; x >= 0; x--) {  
        int wavePosition = int(map(frameCount % (400), 50, 400, 400, 50));
        if (((x * tile_w + y * tile_h)) >= (wavePosition) - 50 && ((x * tile_w + y * tile_h)/2) <= (wavePosition) + 50 && x > 1 && y > 1) {
             // sin needs a phase or count of some sort
          int wave = int(map(sin(radians(frameCount * 3 + (x*10 + (y*10)))) + percent, -1, 1, -100, 100));
          //int wave2 = int(map(cos(radians(frameCount) * 2 + (y*10)), -1, 1, -200, 200));
          
          int sx = x * tile_w;
          int sy = y * tile_h + (wave);
          int sw = tile_w;
          int sh = tile_h;
          //destination
          int dx = x * tile_w;
          int dy = y * tile_h;
          int dw = tile_w;
          int dh = tile_h;
          copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
        } else {
        copy(pg, x*tile_w, y*tile_h, tile_w, tile_h, x*tile_w, y*tile_h, tile_w, tile_h);
        }
     }
  }
  //----------------------
  // here, I set the background and some other graphical properties
  //background (180);
  //smooth(); 
  //stroke (0, 0, 0); 
  //strokeWeight (2); 

  ////----------------------
  //// Here, I assign some handy variables. 
  //float cx = 100;
  //float cy = 100;
  
  ////----------------------
  //// Here, I use trigonometry to render a rotating element.
  //float radius = 80; 
  //float rotatingArmAngle = percent * TWO_PI; 
  //float px = cx + radius*cos(rotatingArmAngle); 
  //float py = cy + radius*sin(rotatingArmAngle); 
  //fill    (255); 
  //line    (cx, cy, px, py); 
  //ellipse (px, py, 20, 20);

  ////----------------------
  //// Here, I use graphical transformations to render a rotated square. 
  //pushMatrix(); 
  //translate (cx, cy);
  //float rotatingSquareAngle =  percent * TWO_PI * -0.25;
  //rotate (rotatingSquareAngle); 
  //fill (255, 128); 
  //rect (-40, -40, 80, 80);
  //popMatrix(); 

  ////----------------------
  //// Here's a linearly-moving white square
  //float squareSize = 20;
  //float topY = 0 - squareSize - 2;
  //float botY = height + 2;
  //float sPercent = (percent + 0.5)%1.0; // shifted by a half-loop
  //float yPosition1 = map(sPercent, 0, 1, topY, botY); 
  //fill (255, 255, 255); 
  //rect (230, yPosition1, 20, 20); 

  ////----------------------
  //// Here's a sigmoidally-moving pink square!
  //// This uses the "Double-Exponential Sigmoid" easing function 
  //// from https://github.com/golanlevin/Pattern_Master
  //float eased = function_DoubleExponentialSigmoid (percent, 0.7); 
  //eased = (eased + 0.5)%1.0; 
  //float yPosition2 = map(eased, 0, 1, topY, botY); 
  //fill (255, 200, 200); 
  //rect (260, yPosition2, 20, 20); 

  ////----------------------
  //// Here's a pulsating ellipse
  //float ellipsePulse = sin ( 3.0 * percent * TWO_PI); 
  //float ellipseW = map(ellipsePulse, -1, 1, 20, 50); 
  //float ellipseH = map(ellipsePulse, -1, 1, 50, 30); 
  //float ellipseColor = map(ellipsePulse, -1, 1, 128, 255); 
  //fill (255, ellipseColor, ellipseColor); 
  //ellipse (350, cy, ellipseW, ellipseH); 

  ////----------------------
  //// Here's a traveling sine wave, 
  //// of which a quarter is visible
  //for (int sy=0; sy <= height; sy+=4) {
  //  float t = map (sy, 0, height, 0.0, 0.25); 
  //  float sx = 450 + 25.0 * sin ((t + percent)*TWO_PI); 
  //  point (sx, sy);
  //}

  ////----------------------
  //// If we're recording, I include some visual feedback. 
  //fill (255, 0, 0);
  //textAlign (CENTER); 
  //String percentDisplayString = nf(percent, 1, 3);
  //text (percentDisplayString, cx, cy-15);
}



//===================================================
// Taken from https://github.com/golanlevin/Pattern_Master
float function_DoubleExponentialSigmoid (float x, float a) {
  // functionName = "Double-Exponential Sigmoid";

  float min_param_a = 0.0 + EPSILON;
  float max_param_a = 1.0 - EPSILON;
  a = constrain(a, min_param_a, max_param_a); 
  a = 1-a;

  float y = 0;
  if (x<=0.5) {
    y = (pow(2.0*x, 1.0/a))/2.0;
  } else {
    y = 1.0 - (pow(2.0*(1.0-x), 1.0/a))/2.0;
  }
  return y;
}
