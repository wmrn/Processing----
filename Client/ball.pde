//ball.pde
//球体に画像を貼ったようなものになる
//2016/01/19
class Ball extends Nomal {
  int c=0;
  int h=0;
  int z_p;//写真の位置

  Ball() {
    frameRate(500);
    smooth();
  }

  void init() {
    super.init();
    println("loaddone_5");
  }

  void d() {
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateX(-radians(mouseY/2));//mouseの位置で向き調節
    h++;
    rotateZ(PI*h/50);

    float radius = 200;//色のついた点で球を書いて球体に貼り付けたように見せる
    for (float s = 0; s <= PI; s =s+PI/480) {
      float z = radius * cos(s);
      for (float t = 0; t < 2*PI; t =t+ 2*PI/640) {
        float x = radius * sin(s) * cos(t);
        float y = radius * sin(s) * sin(t);
        if (c>307150) {
          c=0;
        }
        c++;
        stroke(r[c], g[c], b[c]);
        strokeWeight(4);
        point(x, y, z+z_p);
      }
    }
    rotateY(radians(mouseX/360));//回転
    rotateX(radians(mouseY/360));
    popMatrix();
  }

  void keyp() {//keyPressedの部分
    if (key == CODED) {
      if (keyCode == UP) {
        z_p++;//ズーム
      } else if (keyCode == DOWN) {
        z_p--;//ズームアウト
      }
    }
  }
}

