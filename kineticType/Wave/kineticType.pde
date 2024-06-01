PGraphics pg;
PFont font;
 
// graphics we want to copy from
 
void setup() {
font = loadFont("./data/CalistoMT-BoldItalic-100.vlw");
//dimension of sketch. renderer avoids errors
noiseDetail(4, 0.5);
size(800, 800, P2D);
// where we put our letters
pg = createGraphics(800, 800, P2D);
}
 
void draw() {
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
  pg.text("Hello World", 0, 0);
  pg.text("Hello World", 0, 100);
  pg.text("Hello World", 0, 200);
  pg.text("Hello World", 0, 300);
 
  //pg.ellipse(x, y, 10, 10);
  pg.popMatrix();
  pg.endDraw();
  //x = map(sin(radians(frameCount) * 0.8), -1, 1, -400, 400);
  //y = map(cos(radians(frameCount)), -1, 1, -400, 400);
  //image(pg, 0, 0);
  //determine the number of x and y tiles
  int x_tiles = 25;
  int y_tiles = 25;
  // calculate height and width of tiles
  int tile_w = int(width/x_tiles);
  int tile_h = int(height/y_tiles);
  // iterate the grid using a 2d loop
  
  // 2D Diagonal Elements
  for (int y = y_tiles - 1; y >= 0; y--) {
     for (int x = x_tiles -1 ; x >= 0; x--) {  
        int wavePosition = int(map(frameCount % (400), 50, 400, 400, 50));
        int wavePosY = int(map(frameCount % (450), 150, 450, 450, 150));
        if (((x * tile_w + y * tile_h)) >= (wavePosition) - 50 && ((x * tile_w + y * tile_h)/2) <= (wavePosition) + 50 && x > 1 && y > 1) {
             // sin needs a phase or count of some sort
        
          int wave = int(map(sin(radians(frameCount * 3 + (x*13 + (y*13)))), -1, 1, -100, 100));
          int wave2 = int(map(cos(radians(frameCount) * 2 + (y*10)), -1, 1, -200, 200));
          
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
}
