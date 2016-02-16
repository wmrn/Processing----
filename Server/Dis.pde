//Dis.pde
//kinect以外の表示の部分のclass
//2016/01/19
class Dis {
  PFont font;//上の説明の文字
  String [] str;

  int flag;//説明文の切り替え

  int R;//上の文字の色の変化に使う変数
  int G;
  int B;
  int stage;

  int [] r_m = new int [15];//mosaicのrb
  int [] b_m = new int [15];

  int r_b;//3D_ballの部分のrgb
  int g_b;
  int b_b;

  Dis() {
    font = createFont("MS-Gothic-48.vlw", 50);
    textFont(font);
    textSize(37);
    str = new String [8];//上に表示させる説明文
    str[0]="加工無し";
    str[1]="モノクロに加工";
    str[2]="モザイクに加工";
    str[3]="ホラー風に加工";
    str[4]="ボールに画像を張り付けたように加工";
    str[5]="画像がリアルに再現されたように加工";
    str[6]="①右の6つから加工の仕方を１つ選択";
    str[7]="②image部分をクリックしてシャッターをきる";

    R=255;//上の文字の色の変化に使う変数
    G=0;
    B=0;
    stage=0;

    for (int i=0; i<15; i++) {//mosaicのrb
      r_m[i]=int(random(255));
      b_m[i]=int(random(255));
    }

    r_b=50;//3D_ballの部分のrgb
    g_b=70;
    b_b=130;
  }

  void d() {//drawに書く部分
    descrip();
    mode_1();
    mode_2();
    mode_3();
    mode_4();
    mode_5();
    mode_6();
  }

  void mouse() {//mouse判定の部分
    if (mouseX>width-250 && mouseY/80!=0) {
      flag=1;
    }
    if (mouseX<width-250 && mouseY>80 ) {
      flag=0;
    }
  }

  void colorWave() {//上の説明の部分の文字の色の変化の関数
    if (stage==0) {
      G++;
      if (G>=255) {
        stage=1;
        G=255;
      }
    }
    if (stage==1) {
      R--;
      if (R<0) {
        stage=2;
        R=0;
      }
    }

    if (stage==2) {
      B++;
      if (B>255) {
        stage=3;
        B=255;
      }
    }
    if (stage==3) {
      G--;
      if (G<0) {
        stage=4;
        G=0;
      }
    }
    if (stage==4) {
      R++;
      if (R>255) {
        B--;
        R=255;
        if (B<0) {
          stage=0;
          B=0;
        }
      }
    }
  }

  void descrip() {//上の説明文の部分
    fill(22, 46, 79);
    rect(0, 0, width, 80);
    colorWave();
    fill(R, G, B);  
    if (mouseX>width-250 && mouseY/80!=0) {
      text(str[mouseY/80-1], 0, 80-10);
    } else {
      if (flag==0) {
        text(str[6], 10, 80-10);
      } else if (flag==1) {
        text(str[7], 10, 80-10);
      }
    }
  }

  void mode_1() {//normalの部分
    fill(253, 255, 244);
    rect(width-250, 80, 250, 80);
    fill(0);
    text("normal", width-250+10, 160-10);
  }

  void mode_2() {//monochromeの部分
    fill(70);
    rect(width-250, 160, 250, 80);
    fill(229, 227, 226);
    text("monochrome", width-250+10, 240-10);
  }

  void mode_3() {//mosaicの部分
    fill(253, 255, 244);
    rect(width-250, 240, 250, 80);
    for (int i=0; i<5; i++) {
      fill(r_m[i], 255, b_m[i]);
      noStroke();
      rect(width-250+5+50*i, 240, 40, 15);
    }
    for (int i=0; i<5; i++) {
      fill(r_m[i+5], 255, b_m[i+5]);
      noStroke();
      rect(width-250+5+50*i, 265, 40, 30);
    }
    for (int i=0; i<5; i++) {
      fill(r_m[i+10], 255, b_m[i+10]);
      noStroke();
      rect(width-250+5+50*i, 305, 40, 15);
    }
    fill(255, 131, 0);
    stroke(0);
    text("mosaic", width-250+10, 320-10);
  }

  void mode_4() {//horrorの部分
    fill(0);
    rect(width-250, 320, 250, 80);
    fill(189, 0, 0);
    text("horror", width-250+10, 400-10);
  }

  void mode_5() {//3D_ballの部分
    fill(253, 255, 244);
    rect(width-250, 400, 250, 80);
    fill(58, 188, 204, 125);
    for (int i=0; i<130; i++) {   
      stroke(r_b, g_b, b_b);
      fill(r_b, g_b, b_b);
      ellipse(width-100-(i/3), 470-(i/3), 140-i, 140-i);
      r_b+=200/130;
      g_b+=180/130;
      b_b++;
    }
    r_b=54;
    g_b=70;
    b_b=130;
    stroke(0);
    fill(0, 193, 242);
    text("3D_ball", width-250+3+10, 480-10);//陰  
    fill(127, 229, 255);
    text("3D_ball", width-250+10, 480-10);
  }

  void mode_6() {//3D_realの部分
    fill(253, 255, 244);
    rect(width-250, 480, 250, 80);
    fill(244, 242, 252);
    quad(width-55, 480, width-20, 500, width-55, 520, width-90, 500);
    fill(234, 232, 242);
    quad(width-90, 500, width-55, 520, width-55, 560, width-90, 540);
    fill(219, 217, 224);
    quad(width-55, 520, width-20, 500, width-20, 540, width-55, 560);
    fill(0);
    text("3D_real", width-250+3+10, 560-10);
    fill(167, 165, 170);
    text("3D_real", width-250+10, 560-10);
  }
}

