int qty=10;

float[]bx;
float[]by;
float[]vx;
float[]vy;
float r=10;
float margin=150;
int phase=1;
float vel=3;
float deadX, deadY;


PImage live;
PImage dead;
int start;
int now = 0;

void setup() {

  size(800, 600);
  live=loadImage("1.png");
  dead=loadImage("2.png");
  live.resize(80, 0);
  dead.resize(80, 0);

  imageMode(CENTER);



  bx=new float[qty];
  by=new float[qty];
  vx=new float[qty];
  vy=new float[qty];



  for (int i=0; i<qty; i++) {

    int dir=int(random(2));


    if (dir==0) {

      bx[i]=random(width+r, width+margin);

      by[i]=random(0, height);

    } else if (dir==1) {

      bx[i]=random(0, width);

      by[i]=random(height+r, height+margin);

    } else if (dir==2) {

      bx[i]=random(-margin, -r);

      by[i]=random(0, height);

    } else {

      bx[i]=random(0, width);

      by[i]=random(-margin, -r);

    }

    float angle=atan2(mouseY-by[i], mouseX-bx[i]);

    //println(angle);

    vx[i]=cos(angle)*vel;

    vy[i]=sin(angle)*vel;

  }



  start=millis();

}



void draw() {

  if (phase==1) {

    // background(255);

    image(dead, 400, 300, 800, 600);

    fill(200);

    textSize(180);

    textAlign(CENTER, CENTER);

    text(60-(millis()-start)/1000, width/2, height/2);

    if (60-(millis()-start)/1000<=0) {

      phase=3;

    }



    if (frameCount%60==0) {

      for (int i=0; i<qty; i++) {

        vx[i]*=1.01;

        vy[i]*=1.01;

      }

    }



    for (int i=0; i<qty; i++) {

      bx[i]+=vx[i];

      by[i]+=vy[i];



      fill(20);

      noStroke();

      ellipse(bx[i], by[i], r*2, r*2);



      if (dist(bx[i], by[i], mouseX, mouseY)<40) {

        phase=2;

        deadX=mouseX;

        deadY=mouseY;

      }

    }



    for (int i=0; i<qty; i++) {

      if (bx[i]>width+margin*2 || bx[i]<-margin*2 ||

        by[i]>height+margin*2 || by[i]<-margin*2) {

        int dir=int(random(4));



        if (dir==0) {

          bx[i]=random(width+r, width+margin);

          by[i]=random(0, height);

        } else if (dir==1) {

          bx[i]=random(0, width);

          by[i]=random(height+r, height+margin);

        } else if (dir==2) {

          bx[i]=random(-margin, -r);

          by[i]=random(0, height);

        } else {

          bx[i]=random(0, width);

          by[i]=random(-margin, -r);

        }

        float angle=atan2(mouseY-by[i], mouseX-bx[i]);

        vx[i]=cos(angle)*vel;

        vy[i]=sin(angle)*vel;

      }

    }



    image(live, mouseX, mouseY);

  } else if (phase==2) {

    background(255);

    // image(dead, deadX, deadY);

    textSize(60);

    text("YOU LOSE!", width/2, height/2);

  } else {

    background(255);

    textSize(60);

    text("YOU WIN!", width/2, height/2);

  }

  if (now == 0)

  {

    background(255);

    textSize(60);

    text("START", width/2, height/2);

  }

}



void mousePressed() {

  now  = 1;

  if (phase==2 || phase==3) {

    phase=1;

    vel=3;



    for (int i=0; i<qty; i++) {



      int dir=int(random(2));



      if (dir==0) {

        bx[i]=random(width+r, width+margin);

        by[i]=random(0, height);

      } else if (dir==1) {

        bx[i]=random(0, width);

        by[i]=random(height+r, height+margin);

      } else if (dir==2) {

        bx[i]=random(-margin, -r);

        by[i]=random(0, height);

      } else {

        bx[i]=random(0, width);

        by[i]=random(-margin, -r);

      }

      float angle=atan2(mouseY-by[i], mouseX-bx[i]);

      //println(angle);

      vx[i]=cos(angle)*vel;

      vy[i]=sin(angle)*vel;

    }



    start=millis();

  }

}
