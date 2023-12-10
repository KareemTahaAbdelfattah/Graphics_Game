import java.util.LinkedList;
import java.util.Queue;



class bar {
  float x;
  int y;
  float width;
  bar(float x_p,int y_p,float width_p)
  {
    x=x_p;
    y=y_p;
    width=width_p;
  }

}

PImage wood;
Queue<bar> myQueue = new LinkedList<>();

void setup() {
 size(700, 900);

bar bar_1=new bar(random(0,400),0,random(150,300));
bar bar_2=new bar(random(0,400),100,random(150,300));
bar bar_3=new bar(random(0,400),200,random(150,300));
bar bar_4=new bar(random(0,400),300,random(150,300));
bar bar_5=new bar(random(0,400),400,random(150,300));
bar bar_6=new bar(random(0,400),500,random(150,300));
bar bar_7=new bar(random(0,400),600,random(150,300));
bar bar_8=new bar(random(0,400),700,random(150,300));
bar bar_9=new bar(0,830,700);

myQueue.add(bar_1);
myQueue.add(bar_2);
myQueue.add(bar_3);
myQueue.add(bar_4);
myQueue.add(bar_5);
myQueue.add(bar_6);
myQueue.add(bar_7);
myQueue.add(bar_8);
myQueue.add(bar_9);
 smooth();

 wood = loadImage("woodBar.png");
}
void display()
{
  LinkedList<bar> myList = new LinkedList<>(myQueue);
  int i=0;
  for(i=0;i<myQueue.size();i++)
  {
    image(wood, myList.get(i).x, myList.get(i).y,myList.get(i).width,40);
  }
}
void draw() {
 background(255);
 
 display();
 //shape(network, 180, 10, 280, 280);
}

//random width will be from 150 to 300
// random x from 0 to 400
