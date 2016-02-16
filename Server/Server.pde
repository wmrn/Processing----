//B_9_Server.pde
//Server側
//2016/01/19
import processing.net.*;
Server myServer = new Server(this, 2222);//Server
import SimpleOpenNI.*;//kinect
SimpleOpenNI kinect;
Dis dis;//kinect以外をまとめたclass
int num;
byte [] all;
color [] c; 

void setup() {
  size(900, 80*7);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  dis = new Dis();
  num=640*480;//kinectのimageのsize
  all = new byte [num*4+1];//すべてのデータを1つの配列にまとめて送るための配列
  c = new color [num];//一つ一つのピクセルのcolorを保存しておく配列
}

void draw() {
  background(255);
  dis.d();
  kinect.update();//データの更新
  image(kinect.rgbImage(), 5, 80);//kinectのrgbImageの表示
  int [] depthMap = kinect.depthMap();//kinectで取得したdepthの値
  for (int i=0; i<num; i++) {
    all[i*4+1]=byte(depthMap[i]/16);//値の桁を合わせるために/16した
    c[i]=kinect.rgbImage().pixels[i];//一つ一つのcolorの保存
    all[i*4+2]=byte(red(c[i]));//それぞれのrgbの値の取得
    all[i*4+3]=byte(green(c[i]));
    all[i*4+4]=byte(blue(c[i]));
  }
}

void mousePressed() {
  dis.mouse();
  if (mouseX>width-250 && mouseY/80!=0) {
    all[0]=byte(mouseY/80);//配列の一番最初にどのmodeに編集するかを選んで代入
  }
  if (mouseX<width-250 && mouseY>80 && all[0]!=byte(0)) {
    myServer.write(all);//clientにまとめたallくを送る
  }
}

void stop() {
  myServer.stop();
}

