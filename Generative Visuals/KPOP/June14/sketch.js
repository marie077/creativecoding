function setup() {
    createCanvas(400, 400);
    pixelDensity(1);
  }
  
  function draw() {
    background(220);
    loadPixels();
    var yoff = 0.0;
    for (var y = 0; y < height; y++) {
      var xoff = 0.0;
      for (var x = 0; x < width; x++) {
        var index = (x + y * width) * 4;
        var r = noise(xoff, yoff) * 255;
        pixels[index + 0] = r;
        pixels[index + 1] = r;
        pixels[index + 2] = r;
        pixels[index + 3] = 255;
        xoff += 0.01;
      }
      yoff += 0.01;
    }
    updatePixels();
    
  }