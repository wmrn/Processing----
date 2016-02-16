//Real.pde
//3D_real_modeのclass
//2016/01/19
class Real extends Nomal {

  Real() {
    frameRate(500);
    smooth();
  }

  void init() {//代入
    super.init();//継承
    println("loaddone_6");
  }

  void d() {//drawの部分
    background(100);
    pushMatrix();
    translate(width/2, height/2, z);
    rotateY(radians(mouseX/2));//mouseの位置に合わせて回転
    rotateX(-radians(mouseY/2));

    for (int i=0; i<num; i++) {
      if (i>=width && i%width!=0) {
        fill(r[i-1], g[i-1], b[i-1]);
        noStroke();
        beginShape(TRIANGLE);
        vertex(i%width-width/2, i/width-150, -posz[i]/12);
        vertex(i%width-1-width/2, i/width-150, -posz[i-1]/12);
        vertex(i%width-1-width/2, i/width-1-150, -posz[i-width-1]/12);
        endShape();
        fill(r[i-width], g[i-width], b[i-width]);
        beginShape(TRIANGLE);
        vertex(i%width-width/2, i/width-150, -posz[i]/12);
        vertex(i%width-width/2, i/width-1-150, -posz[i-width]/12);
        vertex(i%width-1-width/2, i/width-1-150, -posz[i-width-1]/12);
        endShape();
      }
      stroke(r[i], g[i], b[i]);
      strokeWeight(3);
      point(i%width-width/2, i/width-150, -posz[i]/12);
    }
    popMatrix();
  }
}

