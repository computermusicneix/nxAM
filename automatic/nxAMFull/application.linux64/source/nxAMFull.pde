// nxAMFull
// Miquel Parera
// 2014.04

import processing.opengl.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int width = 1440;
int height = 900;

String title = "";
PFont font;

// figure A1 - 
float A1_PositionX = random(2.0,2.0);
float A1_PositionY = random(2.0,2.0);
float A1_VelocityX = random(5.0,5.0);
float A1_VelocityY = random(5.0,5.0);
float A1_Scale = 0.0;
int A1_Angles = int(random(2,6));
float A1_alpha = random(1,10); 
float A1_beta = random(1,10); 
float A1_gamma = random(1,10); 
float A1_Opacity = random(100,100);

// figure A2 - 
float A2_PositionX = random(2.0,2.0);
float A2_PositionY = random(2.0,2.0);
float A2_VelocityX = random(5.0,5.0);
float A2_VelocityY = random(5.0,5.0);
float A2_Scale = 0.0;
int A2_Angles = int(random(2,6));
float A2_alpha = random(1,10); 
float A2_beta = random(1,10); 
float A2_gamma = random(1,10); 
float A2_Opacity = random(100,100);

// figure A3 - 
float A3_PositionX = random(2.0,2.0);
float A3_PositionY = random(2.0,2.0);
float A3_VelocityX = random(5.0,5.0);
float A3_VelocityY = random(5.0,5.0);
float A3_Scale = 0.0;
int A3_Angles = int(random(2,6));
float A3_alpha = random(1,10); 
float A3_beta = random(1,10); 
float A3_gamma = random(1,10); 
float A3_Opacity = random(100,100);

// figure A4 - 
float A4_PositionX = random(2.0,2.0);
float A4_PositionY = random(2.0,2.0);
float A4_VelocityX = random(5.0,5.0);
float A4_VelocityY = random(5.0,5.0);
float A4_Scale = 0.0;
int A4_Angles = int(random(2,6));
float A4_alpha = random(1,10); 
float A4_beta = random(1,10); 
float A4_gamma = random(1,10); 
float A4_Opacity = random(100,100);



void setup()
{
    size(width, height, OPENGL);
    frameRate(25);
    oscP5 = new OscP5(this,12000);
    font = createFont("GalapogosBRK-48", 20);
    textFont(font);
    noCursor();
}

void draw()
{
    background(0);
    
    //title
    fill(255,255,255);
    text(title, (width/20)+100, height/2);  
    
    // figure A1 - 
    pushMatrix();    
    translate( width/A1_PositionX, height/A1_PositionY, 0 );
    rotateX( PI );
    rotateY( radians( frameCount*A1_VelocityX ) );
    rotateZ( radians( frameCount*A1_VelocityY ) );
    noFill();
    stroke(255, A1_Opacity);
    strokeWeight(1.5);
    scale(A1_Scale*3);
    nxAM( A1_Angles, A1_alpha, A1_beta, A1_gamma );
    popMatrix();
     // figure A2 - 
    pushMatrix();    
    translate( width/A2_PositionX, height/A2_PositionY, 0 );
    rotateX( PI );
    rotateY( radians( frameCount*A2_VelocityX ) );
    rotateZ( radians( frameCount*A2_VelocityY ) );
    noFill();
    stroke(200, 20, 60, A2_Opacity);
    strokeWeight(1.5);
    scale(A2_Scale*4);
    nxAM( A2_Angles, A2_alpha, A2_beta, A2_gamma );
    popMatrix();
     // figure A3 - 
    pushMatrix();    
    translate( width/A3_PositionX, height/A3_PositionY, 0 );
    rotateX( PI );
    rotateY( radians( frameCount*A3_VelocityX ) );
    rotateZ( radians( frameCount*A3_VelocityY ) );
    noFill();
    stroke(0, 201, 87, A3_Opacity);
    strokeWeight(1.5);
    scale(A3_Scale*5);
    nxAM( A3_Angles, A3_alpha, A3_beta, A3_gamma );
    popMatrix();
     // figure A4 - 
    pushMatrix();    
    translate( width/A4_PositionX, height/A4_PositionY, 0 );
    rotateX( PI );
    rotateY( radians( frameCount*A4_VelocityX ) );
    rotateZ( radians( frameCount*A4_VelocityY ) );
    noFill();
    stroke(28, 134, 238, A4_Opacity);
    strokeWeight(1.5);
    scale(A4_Scale*6);
    nxAM( A4_Angles, A4_alpha, A4_beta, A4_gamma );
    popMatrix();
}

// POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, and QUAD_STRIP

void nxAM( int sides, float r1, float r2, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    beginShape(QUAD_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight); 
        vertex( y1, x2, halfHeight*2);  
    };
    endShape(CLOSE);
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/title")==true) {
    if(theOscMessage.checkTypetag("s")) {
      title = theOscMessage.get(0).stringValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A1Scale")==true) {
    if(theOscMessage.checkTypetag("f")) {
      A1_Scale = theOscMessage.get(0).floatValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A2Scale")==true) {
    if(theOscMessage.checkTypetag("f")) {
      A2_Scale = theOscMessage.get(0).floatValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A3Scale")==true) {
    if(theOscMessage.checkTypetag("f")) {
      A3_Scale = theOscMessage.get(0).floatValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A1Angles")==true) {
    if(theOscMessage.checkTypetag("i")) {
      A1_Angles = theOscMessage.get(0).intValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A2Angles")==true) {
    if(theOscMessage.checkTypetag("i")) {
      A2_Angles = theOscMessage.get(0).intValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A3Angles")==true) {
    if(theOscMessage.checkTypetag("i")) {
      A3_Angles = theOscMessage.get(0).intValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A4Angles")==true) {
    if(theOscMessage.checkTypetag("i")) {
      A4_Angles = theOscMessage.get(0).intValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A4Scale")==true) {
    if(theOscMessage.checkTypetag("f")) {
      A4_Scale = theOscMessage.get(0).floatValue();
      return;
    }  
  }
  if(theOscMessage.checkAddrPattern("/A4Opacity")==true) {
    if(theOscMessage.checkTypetag("f")) {
      A4_Opacity = theOscMessage.get(0).floatValue();
      return;
    }  
  }
}
