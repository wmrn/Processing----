//monokuro.pde
//画像をモノクロにする
//2016/01/19
class Monokuro extends Nomal{//モノクロクラスを定義
  int [] gr;

  void init() {
    super.init();//継承
    gr = new int [num];
    println("loaddone_2");
  }

  void d() {//これをdrawのとこにそのままコピペ
    background(0);
    for (int i=0; i<num; i++) {
      strokeWeight(3);
      int heikin=(r[i]+g[i]+g[i])/3;//色の平均をもとめて定義
      gr[i]=heikin;
      stroke(gr[i], gr[i], gr[i]);//R,G,Bすべてを同じ値の先ほど求めた色の平均にしてモノクロにする
      point(i%width+x, i/width, z);
    }
  }
}

