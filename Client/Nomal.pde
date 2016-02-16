//Nomal.pde
//normal_modeのクラス
//このclassは画像の1ピクセルごとのrgbの値を取得するclassです
//2016/01/19
class Nomal {
  int num;
  int [] posz;//loaddataするための配列
  int [] r;
  int [] g;
  int [] b;

  int x;//写真の移動
  int z;

  void init() {//代入
    num=640*480;
    posz = new int [num];
    r = new int [num];
    g = new int [num];
    b = new int [num];
    loadFromFile();//.csvに保存してあるデータをloadする
    println("loaddone_1");
  }

  void d() {//これをdrawのとこにそのままコピペ
    background(0);
    for (int i=0; i<num; i++) {
      strokeWeight(3);
      stroke(r[i], g[i], b[i]);//取得したrgbの値
      point(i%width+x, i/width, z);//ピクセルの番号の順番に一つ一つ点を打っていく
    }
  }

  void keyp() {//keyPressedの部分
    if (key == CODED) {
      if (keyCode == UP) {
        z++;//ズーム
      } else if (keyCode == DOWN) {
        z--;//ズームアウト
      } else if (keyCode == RIGHT) {
        x++;//右
      } else if (keyCode == LEFT) {
        x--;//左
      }
    }
  }


  void loadFromFile() {//ファイルの読み取りの関数
    //送る文字列が左から「ピクセル番号・r・g・b」の順番に書いてある
    String [] lines = loadStrings("data.csv");
    for (int i=0; i<num; i++) {
      String [] data=split(lines[i], ',');//それを一行ずつ読み取って配列に保存していく
      posz[i]=int(data[0]);
      r[i]=int(data[1]);
      g[i]=int(data[2]);
      b[i]=int(data[3]);
    }
  }
}

