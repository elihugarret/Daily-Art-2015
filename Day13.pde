import glitchP5.*;
GlitchP5 glitch;

int s=900,i,j;

void setup(){
  background(255);
  size(1280/2,800);
  strokeWeight(12);
  glitch = new GlitchP5(this);
}

void draw(){

 if (key == '1'){
   stroke(1.9,9);
   fill(random(255),random(55),random(255));
   ellipse(i++%1200,millis()%750+99,i%s/350.,(70+i)%199);  
  }
 
 if (key == '2'){
  translate(512,384);
  fill(random(255),0,0); 
 i=frameCount;
  while(i-->1){
    ellipse(j++%i,j%i,random(j++%i),i/9%9);
  rotate(noise(0.009));
    }
   }

 if (key == '3'){
   fill(random(255));
 for(j=0;j<199;)
 ellipse(i++%(1399+j++/2),int(i/99)%(999-j),i%12,j%16);
  }
 glitch.run();
}

void keyPressed(){

if (key == 'g'){
  glitch.glitch(400,400, 1000, 1000, 200, 1200, 1, random(1.78), 6, 20);
  }

}
