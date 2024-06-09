var scl = 20;
var cols, rows;
var inc = 0.05;
var zoff = 0.0;
var fr;


var particles = [];

// store vectors in an array
var flowField = [];

function setup() {
    createCanvas(400, 400);
    pixelDensity(1);
    cols = floor(width/scl);
    rows = floor(height/scl);
    fr = createP('');

    // pre-set size
    flowField = new Array(cols * rows);

    for (var i = 0; i < 500; i++) {
      particles[i] = new Particle();
    }

  }
  
  function draw() {
    background(243, 237, 205);
    var yoff = 0.0;
    for (var y = 0; y < rows; y++) {
      var xoff = 0.0;
      for (var x = 0; x < cols; x++) {
        // grid index of col and rows
        var index = (x + y * cols);
        var angle = noise(xoff, yoff, zoff) * TWO_PI * 8;
        var v = p5.Vector.fromAngle(angle);

        v.setMag(0.5);
        flowField[index] = v;
        xoff += inc;
        stroke(0, 50);
        strokeWeight(1);
        push();
        translate(x * scl, y * scl);
        rotate(v.heading());
        line(0, 0, scl, 0);

        pop();
        // rect(x * scl, y * scl, scl, scl);
      }
      yoff += inc;
      zoff += 0.0003;
    }

    // for (var i = 0; i < particles.length; i++) {
    //   // Appl force to particles
    //   particles[i].follow(flowField);
    //   particles[i].update();
    //   particles[i].edges();
    //   particles[i].show();
    // }
   
   
    fr.html(floor(frameRate()));
  }