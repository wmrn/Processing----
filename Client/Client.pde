//B_9_Client.pde
//Client側
//2016/01/19
import twitter4j.conf.*;//画像tweetに必要なもの。
import twitter4j.internal.async.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.logging.*;
import twitter4j.http.*;
import twitter4j.internal.util.*;
import twitter4j.api.*;
import twitter4j.util.*;
import twitter4j.internal.http.*;
import twitter4j.*;
import java.nio.file.FileSystems;//主に画像関係かな？
import java.nio.file.FileSystem;
import java.nio.file.Path;

import processing.opengl.*;
import processing.net.*;
import java.util.List;//ArrayListをlistとして決まった数移すことができる

Client myClient = new Client(this, "127.0.01", 2222);//client

Nomal nomal;//6つのmodeのclass
Monokuro monokuro;
Mosaic mosaic;
Fusion fusion;
Ball ball;
Real real;

int num;
List<Byte> store = new ArrayList<Byte>();//readするときに必要な配列
List<Byte> image = new ArrayList<Byte>();
boolean skip = false;
byte [] all;

int [] depth;//ファイルに保存するときに使う配列
int [] r;
int [] g;
int [] b;

int mode;//どのmodeで編集するのかの判定
int num_c;//スクリーンキャプチャーの数
String [] vername = new String [7];

//ここの4行はそれぞれのアカウントに合わせて書き直す
String consumerKey = "*******";
String consumerSecret = "*******";
String accessToken = "********";
String accessSecret = "*******";

Twitter myTwitter;//twitter

void setup() {
  num=640*480;
  size(640, 480, OPENGL);

  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey(consumerKey);
  cb.setOAuthConsumerSecret(consumerSecret);
  cb.setOAuthAccessToken(accessToken);
  cb.setOAuthAccessTokenSecret(accessSecret);
  myTwitter = new TwitterFactory(cb.build()).getInstance();


  all = new byte [num*4+1];//ファイルに保存するときに使う配列
  depth = new int [num];
  r = new int [num];
  g = new int [num];
  b = new int [num];

  vername[0]="none.ver";
  vername[1]="normal.ver";
  vername[2]="monochrome.ver";
  vername[3]="mosaic.ver";
  vername[4]="horror.ver";
  vername[5]="3D_ball.ver";
  vername[6]="3D_real.ver";

  nomal = new Nomal();//6つのclass
  monokuro = new Monokuro();
  mosaic = new Mosaic();
  fusion = new Fusion();
  ball = new Ball();
  real = new Real();
}

void draw() {
  background(255);

  //ここの部分は先輩のコードコピペ。本当に申し訳ありませんでした。
  skip = true;//最初trueにしてとりあえずひたすらreadしてもらうようにしておく
  if (myClient.available()>0) {
    byte[] bytes = myClient.readBytes();//Serverから受け取る
    for (int idx = 0; idx < bytes.length; idx++) {
      store.add(bytes[idx]);//Arrayに入れておく
    }
    //一回readするだけじゃすべて受け取り切れてない。受け取る速度が違うからずれが生じる
    if (store.size() >= num*4+1) {//一旦保存しておいたsizeが本来の数に達したら
      image = store.subList(0, num*4+1);//別のArrayに保存する
      skip = false;//移せたらaddするの停止
    }
    if (!skip) {
      for (int idx = 0; idx < num*4+1; idx++) {
        all[idx] = image.get(idx);//保存したものを
      }
      store = store.subList(num*4+1, store.size());//余分にとったものは最初のArrayに入れておく
    }

    for (int i=1; i<7; i++) {
      if (all[0]==byte(i)) {
        mode=i;//最初の値を保存して置いてどのmodeに編集するのか判定させる
      }
    }
    for (int i=0; i< (all.length-1)/4; i++) {
      depth[i]=int(all[i*4+1])*16;//.csvファイルに保存するためにいったんばらけさせる
      r[i]=int(all[i*4+2]);
      g[i]=int(all[i*4+3]);
      b[i]=int(all[i*4+4]);
    }

    saveToFile();//.csvファイルに保存   
    if (mode==1) {//modeによって代入を決める
      nomal.init();
    } else if (mode==2) {
      monokuro.init();
    } else if (mode==3) {
      mosaic.init();
    } else if (mode==4) {
      fusion.init();
    } else if (mode==5) {
      ball.init();
    } else if (mode==6) {
      real.init();
    }
  }

  if (mode==0) {//初期状態
    background(0);
    fill(255);
    textSize(50);
    textMode(CENTER);
    text("none", width/2-50, height/2);
  } else if (mode==1) {//modeによって表示を変える
    nomal.d();
  } else if (mode==2) {
    monokuro.d();
  } else if (mode==3) {
    mosaic.d();
  } else if (mode==4) {
    fusion.d();
  } else if (mode==5) {
    ball.d();
  } else if (mode==6) {
    real.d();
  }
}

void mouseDragged() {
  if (mode==3) {//mosaicの時のmouse
    mosaic.mouse();
  }
}

void keyPressed() {
  if ( key == ' ' ) {//スペースで画像をtweet
    //ここら辺参考にした。
    //http://kikutaro777.hatenablog.com/entry/2014/01/30/072716
    //http://yoppa.org/blog/3972.html
    //https://groups.google.com/forum/#!topic/twitter4j-j/PO2qwDZFsUg
    CaptureToPNG(num_c);//スクリーンキャプチャー
    try {
      FileSystem fs = FileSystems.getDefault();
      Path path = fs.getPath("capture//No_"+num_c+".png");
      File file = path.toFile();
      Status status = myTwitter.updateStatus(new StatusUpdate("@null "+vername[mode]).media(file));
      println("tweet done");
      num_c++;
    }
    catch (TwitterException e) {
      println(e.getStatusCode());
    }
  }

  if (mode==1) {
    nomal.keyp();
  } else if (mode==2) {
    monokuro.keyp();
  } else if (mode==3) {
    mosaic.keyp();
  } else if (mode==4) {
    fusion.keyp();
  } else if (mode==5) {
    ball.keyp();
  } else if (mode==6) {
    real.keyp();
  }
}

void saveToFile() {//.csvファイルに保存する関数
  String [] lines = new String [num];
  for (int i=0; i<num; i++) {
    lines[i]=depth[i]+","+r[i]+","+g[i]+","+b[i];
  }
  saveStrings("data.csv", lines);
  println("savedone");
}

void CaptureToPNG(int num) {//スクリーンキャプチャする関数  
  String pngName = "capture/No_"+ str(num) +".png"; 
  save(pngName);//ウィンドに現れているものを()内の名前を付けて保存できる
}


void stop() {
  myClient.stop();
}

