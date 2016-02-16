//Nomal.pde
//mosaic_modeのclass
//2016/01/19
class Mosaic extends Nomal {
  int w;//mosaicの縦横
  int h;

  void init() {
    super.init();//継承
    w=40;//mosaicの縦横
    h=40;
    println("loaddone_3");
  }

  void d() {//これをdrawのとこにそのままコピペ
    background(0);
    for (int i=0; i<num; i++) {
      noStroke();
      if (i%w==0 && i%h==0) {
        fill(r[i], g[i], b[i]);//取得したrgbの値
        beginShape(QUADS);      
        vertex((i%width)+x, i/width, z);
        vertex((i%width)+w+x, i/width, z);
        vertex((i%width)+w+x, i/width+h, z);
        vertex((i%width)+x, i/width+h, z);
        endShape();
      }
    }
  }

  void mouse() {
    if (mouseX>10 && mouseY>10) {
      w=mouseX/10;
      h=mouseY/10;
    } else {
      w=1;
      h=1;
    }
  }
}

