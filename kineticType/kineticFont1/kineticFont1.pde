PGraphics pg;
PFont font;
float x = 0.0;
float y = 0.0;
// graphics we want to copy from
void setup() {
font = createFont("./ChakraPetch-Regular.ttf", 600);
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
  pg.translate(width/2, height/2-215);
  pg.textAlign(CENTER, CENTER);
  pg.text("World World", 0, 0);
  pg.text("World World", 0, 100);
  pg.text("World World", 0, 200);
  pg.text("World World", 0, 300);
  //pg.ellipse(x, y, 10, 10);
  pg.popMatrix();
  pg.endDraw();

  //determine the number of x and y tiles
  int x_tiles = 50;
  int y_tiles = 50;
  // calculate height and width of tiles
  int tile_w = int(width/x_tiles);
  int tile_h = int(height/y_tiles);
  // iterate the grid using a 2d loop
  int limitX = x_tiles - 1;
  for (int y = y_tiles - 1; y >= 0; y--) {
     for (int x = x_tiles -1 ; x >= 0; x--) {
       // sin needs a phase or count of some sort
       int wavePosition = int(map(frameCount % (width + height), 0, width + height, width + height, 0));
       int wavePositionY = int(map(frameCount % height, 0, height, height, 0));

       if (x * tile_w + y * tile_h >= wavePosition - 20 && x * tile_w + y * tile_h <= wavePosition + 20) {
          int wave = int(map(sin(radians(frameCount * 4 + ((x + 1) *11 + ((y - 1)*11)))), -1, 1, -150, 150));
          int wave2 = int(map(cos(radians(frameCount) * 4 + ((y - 1)*10)), -1, 1, -150, 150));
        //copy function from pg to sketch
          //source
          // we can be bold and add some randomness
          int sx = x * tile_w + wave;
          int sy = y * tile_h;
          int sw = tile_w;
          int sh = tile_h;
          //destination
          int dx = x * tile_w;
          int dy = y * tile_h;
          int dw = tile_w;
          int dh = tile_h;
          copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
       } else {
          copy(pg, x * tile_w, y * tile_h, tile_w, tile_h, x*tile_w, y* tile_h, tile_w, tile_h);
       }

     }
  }
}
