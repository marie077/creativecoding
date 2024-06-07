var scl = 20;
var cols, rows;
var inc = 0.05;
var fr;

function setup() {
    createCanvas(400, 400);
    pixelDensity(1);
    cols = floor(width/scl);
    rows = floor(height/scl);
    fr = createP('');
  }
  
  function draw() {
    background(220);
    var yoff = 0.0;
    for (var y = 0; y < rows; y++) {
      var xoff = 0.0;
      for (var x = 0; x < cols; x++) {
        var angle = noise(xoff, yoff) * TWO_PI;
        var v = p5.Vector.fromAngle(angle);
        xoff += inc;
        stroke(0);
        push();
        translate(x * scl, y * scl);
        rotate(v.heading());
        line(0, 0, scl, 0);

        pop();
        // rect(x * scl, y * scl, scl, scl);
      }
      yoff += inc;
    }
    fr.html(floor(frameRate()));
  }