import ddf.minim.*;
import java.util.LinkedList;
import java.util.Queue;

Minim minim;
AudioPlayer music;


PImage backgroundImage1;
PImage backgroundImage2;

PImage fire;
PImage water;

int currentPage = 0;
boolean tr= true ;
Raindrop[] raindrops; // Array to store raindrop objects

float fireY, waterY;
float motionSpeed = 0.02;

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
float X, Y;
int flag=0;
int speed = 3;
float Size = 50;
float gravity = 2;      // Acceleration due to gravity
float ySpeed = 0;       // Vertical speed
float xSpeed = 0;       // Horizontal speed
boolean isJumping = false; // Flag to track if the ball can jump
PShape Fireboy;
PShape Watergirl,player_choice;
PImage wood,ice,bar_choice, fire_background, water_background, ice_wall1, ice_wall2, wood_wall1, wood_wall2, stone_wall;
//Queue<bar> myQueue = new LinkedList<>();
LinkedList<bar> myList = new LinkedList<>();



void setup() {
  size(1200, 900);
  fireY = height/2 + 10;
  waterY = height/2 + 10;
  minim = new Minim(this);
  music = minim.loadFile("theme_song.mp3");
  music.loop();
  
  //load fire image
  fire= loadImage("fire.png");

  //load water image
  water= loadImage("water.png");

  // Load the image
  backgroundImage1 = loadImage("background_menu.jpeg");  // Replace "your_image_file.jpg" with the actual file path or URL of your image
  backgroundImage1.resize(1200, 900);  // Resize the image to match the canvas size
  
  backgroundImage2 = loadImage("background2.jpeg");  // Replace "your_image_file.jpg" with the actual file path or URL of your image
  backgroundImage2.resize(1200, 900);  // Resize the image to match the canvas size
  
  raindrops = new Raindrop[100]; // Adjust the number of raindrops as needed
  
  // Initialize raindrop objects
  for (int i = 0; i < raindrops.length; i++) {
    raindrops[i] = new Raindrop();
  }
  
  flag=0;
  X = width / 2;
  Y = height - Size;
  smooth();
  Fireboy = loadShape("Fireboy.svg");
  Watergirl = loadShape("Watergirl.svg");
  bar bar_1=new bar(random(250,650),0,random(150,300));
  bar bar_2=new bar(random(250,650),100,random(150,300));
  bar bar_3=new bar(random(250,650),200,random(150,300));
  bar bar_4=new bar(random(250,650),300,random(150,300));
  bar bar_5=new bar(random(250,650),400,random(150,300));
  bar bar_6=new bar(random(250,650),500,random(150,300));
  bar bar_7=new bar(random(250,650),600,random(150,300));
  bar bar_8=new bar(random(250,650),700,random(150,300));
  bar bar_9=new bar(250,830,700);
  
  myList.add(bar_1);
  myList.add(bar_2);
  myList.add(bar_3);
  myList.add(bar_4);
  myList.add(bar_5);
  myList.add(bar_6);
  myList.add(bar_7);
  myList.add(bar_8);
  myList.add(bar_9);
  smooth();
  ice=loadImage("first_block-removebg-preview.png");
  wood = loadImage("woodBar.png");
  fire_background = loadImage("stone-wall.png");
  water_background = loadImage("stone_wall_water.png");
  ice_wall1 = loadImage("wall1.png");
  ice_wall2 = loadImage("wall2.png");
  wood_wall1 = loadImage("wood_wall1.png");
  wood_wall2 = loadImage("wood_wall2.png");
  stone_wall = loadImage("stone_wall.png");
 
}


void display(int mode)
{

  if(mode==1) bar_choice=wood;
  else bar_choice=ice;
   
  int i=0;
  for(i=0;i<myList.size();i++)
  {
    image(bar_choice, myList.get(i).x, myList.get(i).y,myList.get(i).width,40);
  }
}


void movment(int mode1)
{

  if(mode1==1)
  {

    player_choice=Fireboy;
  }
  else    {player_choice=Watergirl;
  
}
  Y += ySpeed;
  ySpeed += gravity;
  X += xSpeed;
  
  // Draw the ball
  fill(0, 0, 255);
  shape(player_choice, X, Y-40, Size, Size);
  


  // Check for ground collision
   // ySpeed = 0;
    //isJumping = false;  // Allow jumping when on the ground
   
  

  // Keep the ball within the window bounds
   X = constrain(X, 250, width - Size - 250);
  

}


void intersection(float player_x, float player_y, LinkedList<bar> myList) {
  for (int i = 0; i < myList.size(); i++) {
    if (player_y <= myList.get(i).y + 40 && player_y >= myList.get(i).y) {
      if ((player_x + 20 >= myList.get(i).x && player_x + 20 <= myList.get(i).x + myList.get(i).width) ||
          (player_x + Size - 20 >= myList.get(i).x && player_x + Size - 20 <= myList.get(i).x + myList.get(i).width)) {
        if (ySpeed >= 0) {
          Y = myList.get(i).y;
          ySpeed = 0;
          isJumping = false;
          break;  // No need to check further
        }
      }
    }
  }
}



void bar_movment(LinkedList<bar> myList) {
  int o=0;
  int n=0;
  if(flag==1&&ySpeed==0){
    for (int i = 0; i < myList.size(); i++)
    { 
      ySpeed = speed;
      myList.get(i).y += speed;
    }
 
    }
    else if(flag==1&&ySpeed!=0)
    {
       for (int i = 0; i < myList.size(); i++)
    {
        myList.get(i).y += speed;
    }
    }
       for (int i = 0; i < myList.size(); i++)
    {
       
      if(myList.get(i).y>900)
      {
        myList.remove(i);
        n++;
      }
    }
    for (int i = 0; i < n; i++)
    {
      
     bar  bar_i=new bar(random(250,650),o,random(150,300));
       myList.add(bar_i);
       o+=100;
    }
    o=0;
    n=0;
   // display(1);
}

void draw_ice_wall(){
  image(stone_wall, 0, 0, 240, 900);
  image(stone_wall, 960, 0, 240, 900);
}

void draw_wood_wall(){
  image(wood_wall1, 0, 0, 240, 900);
  image(wood_wall2, 960, 0, 240, 900);
}


void draw() {
  // Set the background to the loaded image
  
  // Your drawing code goes here
  fill(255, 178, 102);
  ellipse(mouseX, mouseY, 50, 50);
  
  
  // Display buttons based on the current page
  if (currentPage == 0) {
    background(backgroundImage1);
    drawButton("Play Game", 3.25*width/4, 2.75*height/4,200, 50, 1);
    drawButton("Options", 3.25*width/4, 3.15*height/4, 200, 50,2);
    drawButton("Instructions", 3.25*width/4, 3.55*height/4, 200, 50,3);
    
    // Simulate rain animation
    for (Raindrop raindrop : raindrops) {
      raindrop.fall();
      raindrop.display();
    }
    
  } else if (currentPage == 1) {
    background(backgroundImage2); // Page 3 background
    drawButton("Play with Fire", width/2 - 300, height/2 - 100, 200, 50, 4);
    drawButton("Play with Snow", width/2+300, height/2 - 100, 200, 50, 5);
    
    image(fire, width/2 - 370, fireY, 150, 100);
    fireY += sin(frameCount * motionSpeed) * 2; // Adjust the '2' for the amplitude of the motion

    // Draw the water image with continuous motion
    image(water, width/2 + 230, waterY, 150, 100);
    waterY += sin(frameCount * motionSpeed) * 2;
    
    for (Raindrop raindrop : raindrops) {
      raindrop.fall();
      raindrop.display();
    }
    drawButton("Back", width - 100, height - 100, 100, 40, 0);

  } else if (currentPage == 2) {
    background(200, 255, 200); // Page 2 background
    drawButton("Back", width/2, 3.5*height/4, 200, 60, 0);
  } else if (currentPage == 3) {
    background(backgroundImage2); // Page 3 background
    displayPage3Title();
    displayPage3Text();
    for (Raindrop raindrop : raindrops) {
      raindrop.fall();
      raindrop.display();
    }
    drawButton("Back", width/2, 3.5*height/4, 200, 60, 0);
    
  } else if(currentPage == 4){
     background(fire_background);
     draw_wood_wall();
     display(1);
     movment(1);
     intersection(X,Y,myList); 
     bar_movment(myList);
  } else if(currentPage == 5){
     background(water_background);
     draw_ice_wall();
     display(2);
     movment(2);
     intersection(X,Y,myList); 
     bar_movment(myList);
  }
}

 void  keyPressed() {
  if (keyCode == ' ' && !isJumping) {
    // Jump when spacebar is pressed and not currently jumping
    ySpeed = -random(15, 30);
    isJumping = true;  // Set the jumping flag to true
    flag=1;
  } else if (keyCode == LEFT) {
    // Move left
    xSpeed = -10;
  } else if (keyCode == RIGHT) {
    // Move right
    xSpeed = 10;
  }
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    // Stop horizontal movement when left or right arrow key is released
    xSpeed = 0;
  }
}

 //shape(network, 180, 10, 280, 280);


//random width will be from 150 to 300
// random x from 0 to 400



void drawButton(String label, float x, float y, float w, float h, int targetPage) {
 
   // Check if the mouse is over the button
  boolean isMouseOver = mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2;
  
   // Draw button
  fill(isMouseOver ? color(255,229, 204) : color(255, 178, 102)); // Highlight color if mouse is over the button
  rectMode(CENTER);
  rect(x, y, w, h, 10); // Rounded corners with a radius of 10
  
  // Draw button label
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text(label, x, y);
  
  // Check if the button is clicked
 
    if (mousePressed && isMouseOver) {
      
      currentPage = targetPage;
     
      music.loop();
    
  }

    
   
}




void displayPage3Title() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(55);
  String title = "Instructions";
  text(title, width/2, height/8);
}

void displayPage3Text() {
  fill(102,178,255);
  textAlign(LEFT, TOP);
  textSize(20);
  float textX = 20;
  float textY = 190;
  float rectWidth = 650;
  float rectHeight = 90;
  
  // Draw rectangles with rounded corners for each instruction
  drawRoundedRect(textX+280, textY , rectWidth, rectHeight, 10);
  drawRoundedRect(textX+280, textY +100, rectWidth, rectHeight, 10);
  drawRoundedRect(textX+280, textY +200, rectWidth, rectHeight, 10);
  drawRoundedRect(textX+280, textY +300, rectWidth, rectHeight, 10);

  fill(0);
  String[] instructions = {
    "1- The player starts the game on the tower's ground floor.",
    "2- To climb the tower, the player must jump from floor to floor \n    (default control: spacebar).",
    "3- The goal is to reach the highest possible floor and\n     accumulate the greatest number of points.",
    "4- When the character falls from the floors, he loses."
  };
  
  
  // Display other instructions without rectangles
  
  for (int i = 0; i < instructions.length; i++) {
    text(instructions[i], textX + 285, textY + 10);
    textY += 100;
  }
   
}

void drawRoundedRect(float x, float y, float w, float h, float r) {
  rectMode(CORNERS);
  rect(x, y, x + w, y + h, r);
}







// Raindrop class
class Raindrop {
  float x, y; // Position of the raindrop
  float speed; // Falling speed
  float diameter; // Diameter of the raindrop
  
  Raindrop() {
    x = random(width); // Random horizontal position
    y = random(-height, 0); // Random vertical position above the canvas
    speed = random(2, 5); // Random falling speed
    diameter = random(5, 15); // Random diameter
  }
  
  void fall() {
    y += speed; // Update the vertical position
    if (y > height) {
      y = random(-height, 0); // Reset the raindrop position if it goes below the canvas
    }
  }
  
  void display() {
    noStroke(); // No outline for the raindrop
    fill(255, 255); // Raindrop color with some transparency
    ellipse(x, y, diameter, diameter); // Ellipse representing the raindrop
  }
}
