//Fusion.pde
//2つの画像を合わせた画像ができる
//2016/01/19
class Fusion extends Nomal {
  int [] R;
  int [] G;
  int [] B;

  void init() {
    super.init();
    R = new int [num];
    G = new int [num];
    B = new int [num];
    loadFromFile2();
    println("loaddone_4");
  }

  void d() {//これをdrawのとこにそのままコピペ
    background(0);
    for (int i=0; i<num; i++) {
      strokeWeight(3);
      stroke((r[i]+R[i])/2, (g[i]+G[i])/2, (b[i]+B[i])/2);//取得したrgbの値
      point(i%width+x, i/width, z);//ピクセルの番号の順番に一つ一つ点を打っていく
    }
  }

  void loadFromFile2() {//ファイルの読み取りの関数
    //送る文字列が左から「ピクセル番号・r・g・b」の順番に書いてある
    String [] lines2 = loadStrings("data_horr.csv");
    for (int i=0; i<num; i++) {
      String [] data=split(lines2[i], ',');//それを一行ずつ読み取って配列に保存していく
      posz[i]=int(data[0]);
      R[i]=int(data[1]);
      G[i]=int(data[2]);
      B[i]=int(data[3]);
    }
  }
}

