import java.util.*;
int scale = 10;

class Points{
  float x ;
  float y ;
  
  Points(){
    this.x = width/2;
    this.y = height/2;
  }
  
  Points(Points obj){
    this.x = obj.x;
    this.y = obj.y;
  }
  
}


class snake {
  Points head;
  Points food = new Points();
  int xvelocity;
  int yvelocity;
  int len;
  boolean crash = false;
  Vector<Points> stail = new Vector();
  
  snake(){
    head = new Points();
    xvelocity = 1;
    yvelocity = 0;
    len = 0;
   }
   
   void pickLocation(){
       int col = width/scale;
       int row = height/scale;
      float x = random(1, col-1);
      float y = random(1, row-1);
      food.x = (int)x*scale;
      food.y = (int)y*scale;
           
   }
   
   void drawFood(){
     fill(255,0,0);
     rect(food.x, food.y, scale, scale);
   }
   
   boolean eat(){
     
       if (dist(food.x, food.y, head.x, head.y)<2){
         return true;
       }
       return false;
   }
      
   
   void drawTail(){
     fill(255);
     for(int i=0; i<len; i++){
      //print(obj.stail.get(i).x, obj.stail.get(i).y);
      rect(obj.stail.get(i).x, obj.stail.get(i).y, scale , scale);
    }
   }
   
   void updateTail(){  
          Points temp = new Points(head);
          stail.add(0, temp);
   }
   
   void increaseLen(){
       if (eat()){
          len++;
          updateTail();
          //print(stail.get(0).x, stail.get(0).y, len, "\n");
          pickLocation();
       }
       else if(len>0){
         updateTail();
         stail.remove(len);
       }
       
   }
   
   
   void move(){
     
      head.x += xvelocity*scale;
      head.y += yvelocity*scale;
      
   }
   
   boolean overLap(){
     for(int i=0; i<len; i++)
         if ( abs(head.x - obj.stail.get(i).x)<4 && abs(head.y - obj.stail.get(i).y) < 4) 
             return true;
     return false;
   }
   
   
   boolean crashed(){
    
     if (head.x <= 0 || head.x >= width){
       crash = true;
       return true;
     }
     else if(head.y <=0 || head.y>= height){
       crash = true;
       return true;
     }
     else if( overLap() ){
       crash = true;
       return true;
     }
     return false;
     
   }
   
   
   
   Vector swap(Vector x, int i, int j){
     print(i,j);
     Object temp = x.get(i);
     x.set(i, x.get(j));
     x.set(j, temp);
     return x;
   }
   
   void  drawSnake(){
     fill(255);
      rect(head.x,head.y, scale, scale); 
   }
   
   
   void GameOver(){
      background(0);
      textSize(width/10);
      text("Game Over", width/4, height/2);
      
    }


   
   boolean update(){
     if (keyCode == UP && (yvelocity==0 || len==0)) {
       yvelocity = -1;
       xvelocity = 0;
     }
     else if(keyCode == DOWN && (yvelocity==0 || len==0)){
       yvelocity = 1;
       xvelocity = 0;
     }
     else if(keyCode == LEFT && (xvelocity==0 || len==0)){
       yvelocity = 0;
       xvelocity = -1; 
     }
     else if(keyCode == RIGHT && (xvelocity==0 || len==0)){
       yvelocity = 0;
       xvelocity = 1; 
     }
     
     if (crashed()){
        println("Game Over");
        GameOver();
        return false;
     }    
     else{
       
       drawFood();
       increaseLen();
       move();
       drawSnake();
       drawTail();
       return true;
     }
     
   }
     
}

snake obj;

void setup(){
   size(800,400);
   
   reset();
   
}

void reset(){
   background(0);
   obj = new snake();
   obj.pickLocation(); 
} 


void GameOver(){
    background(0);
    textSize(width/20);
    text("Game Over", width, height/2);
    delay(5000);
}


void draw(){
   //<>//

  if (!obj.crash)
  {
    background(0);
    frameRate(10);
    fill(255);
    obj.update();
  }
   else{
     GameOver();
     reset();
   }
}
