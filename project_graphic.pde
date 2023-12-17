import ddf.minim.*;
import java.util.LinkedList;
import java.util.Queue;
Minim minim;
AudioPlayer music;
/*----------------------------------------------------------------Classes Construction-----------------------------------------------------------------*/
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

class bar {
  float x;
  int y;
  float width;
  float coin_x;
  float coin_y;
  boolean does_coin_exist = true;
  bar(float x_p,int y_p,float width_p)
  {
    x=x_p;
    y=y_p;
    width=width_p;
    coin_y = y_p-40;
  }
}

/*----------------------------------------------------------------Variables initializations-----------------------------------------------------------------*/
//Minim minim;
//AudioPlayer music;
PFont score_font;
PImage backgroundImage1;
PImage backgroundImage2;
PImage backgroundImage3;
PImage Fireboy;
PImage Watergirl,player_choice;
PImage wood,ice,bar_choice, fire_background, water_background, ice_wall1, ice_wall2, wood_wall1, wood_wall2, stone_wall;
PImage coin;
float X, Y;
float Size = 50;
float coinSize = 50;
float gravity = 1;      // Acceleration due to gravity
float ySpeed = 0;       // Vertical speed
float xSpeed = 0;       // Horizontal speed
int vertical_bar_speed;
int horizontal_bar_speed;
int currentPage = 0;
boolean tr= true ;
boolean gameStarted = false;
boolean isJumping = false; // Flag to track if the ball can jump
int score;
int par = 0;
int level;
float fireY, waterY;
float motionSpeed = 0.02;
int gameOverOpacity = 0;
float angle = 0.0;
boolean rotateGameover1 = true;
int startTime;

Raindrop[] raindrops; // Array to store raindrop objects
LinkedList<bar> myList = new LinkedList<bar>();


void setup() {
    size(1200, 900);
    /*----------------------------------------------------------------Main window setup-----------------------------------------------------------------*/
    fireY = height/2 + 10;
    waterY = height/2 + 10;
    minim = new Minim(this);
    music = minim.loadFile("theme_song.mp3");
    music.loop();
    startTime = millis(); // Record the start time
    
    // Load the image
    backgroundImage1 = loadImage("background_menu.jpeg");  // Replace "your_image_file.jpg" with the actual file path or URL of your image
    backgroundImage1.resize(1200, 900);  // Resize the image to match the canvas size
    backgroundImage2 = loadImage("background2.jpeg");  // Replace "your_image_file.jpg" with the actual file path or URL of your image
    backgroundImage2.resize(1200, 900);  // Resize the image to match the canvas size
    backgroundImage3 = loadImage("over.jpeg"); 
    backgroundImage3.resize(1200, 900);
    raindrops = new Raindrop[100]; // Adjust the number of raindrops as needed
    // Initialize raindrop objects
    for (int i = 0; i < raindrops.length; i++) {
      raindrops[i] = new Raindrop();
    }
    /*----------------------------------------------------------------Loading game's items images -----------------------------------------------------------------*/
    Fireboy = loadImage("fire.png");
    Watergirl = loadImage("girll.png");
    coin=loadImage("coin.png");
    ice=loadImage("first_block-removebg-preview.png");
    wood = loadImage("woodBar.png");
    fire_background = loadImage("stone-wall.png");
    water_background = loadImage("stone_wall_water.png");
    ice_wall1 = loadImage("wall1.png");
    ice_wall2 = loadImage("wall2.png");
    wood_wall1 = loadImage("wood_wall1.png");
    wood_wall2 = loadImage("wood_wall2.png");
    score_font = loadFont("ArialRoundedMTBold-48.vlw");
    stone_wall = loadImage("stone_wall.png");
    textFont(score_font);
    /*----------------------------------------------------------------game setup-----------------------------------------------------------------*/
    game_init(); 
    smooth();
}

/*----------------------------------------------------------------Function of Restarting the game-----------------------------------------------------------------*/
void game_init()
{
    X = width / 2;
    Y = height - Size;
    ySpeed = 0;       
    xSpeed = 0; 
    gameStarted = false;
    isJumping = false;
    score = 0;
    level = 1;
    myList.clear();
     
    bar bar_1=new bar(random(250,650),0,random(150,300));
    bar_1.coin_x = random( bar_1.x , bar_1.x + bar_1.width -coinSize);
    bar bar_2=new bar(random(250,650),100,random(150,300));
    bar_2.coin_x = random( bar_2.x , bar_2.x + bar_2.width -coinSize);
    bar bar_3=new bar(random(250,650),200,random(150,300));
    bar_3.coin_x = random( bar_3.x , bar_3.x + bar_3.width -coinSize);
    bar bar_4=new bar(random(250,650),300,random(150,300));
    bar_4.coin_x = random( bar_4.x , bar_4.x + bar_4.width -coinSize);
    bar bar_5=new bar(random(250,650),400,random(150,300));
    bar_5.coin_x = random( bar_5.x , bar_5.x + bar_5.width -coinSize);
    bar bar_6=new bar(random(250,650),500,random(150,300));
    bar_6.coin_x = random( bar_6.x , bar_6.x + bar_6.width -coinSize);
    bar bar_7=new bar(random(250,650),600,random(150,300));
    bar_7.coin_x = random( bar_7.x , bar_7.x + bar_7.width -coinSize);
    bar bar_8=new bar(random(250,650),700,random(150,300));
    bar_8.coin_x = random( bar_8.x , bar_8.x + bar_8.width -coinSize);
    bar bar_9=new bar(250,830,700);
    bar_9.coin_x = random( bar_9.x , bar_9.x + bar_9.width -coinSize);
    
    myList.addLast(bar_1);
    myList.addLast(bar_2);
    myList.addLast(bar_3);
    myList.addLast(bar_4);
    myList.addLast(bar_5);
    myList.addLast(bar_6);
    myList.addLast(bar_7);
    myList.addLast(bar_8);
    myList.addLast(bar_9);
}

/*----------------------------------------------------------------Function of Displaying the Bars and their Coins-----------------------------------------------------------------*/
void display(int mode)
{
  if(mode==1)
  {
    bar_choice=wood;
  }
  else 
  {
    bar_choice=ice;
  }
   
  for(int i=0;i<myList.size();i++)
  {
    image(bar_choice, myList.get(i).x, myList.get(i).y, myList.get(i).width, 40);
    if(myList.get(i).does_coin_exist == true)
    {
      image(coin, myList.get(i).coin_x, myList.get(i).coin_y, coinSize, coinSize);
    }
  }
}

/*----------------------------------------------------------------Function of Moving the Player-----------------------------------------------------------------*/
void movment(int mode1)
{
   if(mode1==1)
   {
     player_choice=Fireboy;
   }
   else
   {
      player_choice=Watergirl;
   }
    
   gravity = 2;
   Y += ySpeed;
   ySpeed += gravity;
   X += xSpeed;
    
   if(player_choice == Fireboy) image(player_choice, X, Y-50, Size, Size);
   else image(player_choice, X, Y-45, Size, Size);
   
   // Keep the player within the window bounds
   X = constrain(X, 250, width - Size - 250);
}

/*----------------------------------------------------------------Function to make the Player stand on the bars when he falls on them-----------------------------------------------------------------*/
void intersection(float player_x, float player_y, LinkedList<bar> myList) {
  for (int i = 0; i < myList.size(); i++) {
    if (player_y <= myList.get(i).y + 40 && player_y >= myList.get(i).y) {
      if ((player_x + 20 >= myList.get(i).x && player_x + 20 <= myList.get(i).x + myList.get(i).width) ||
          (player_x + Size - 20 >= myList.get(i).x && player_x + Size - 20 <= myList.get(i).x + myList.get(i).width)) {
        if (ySpeed >= 0) {
          Y = myList.get(i).y;
          ySpeed = vertical_bar_speed;
          gravity = 0;
          isJumping = false;
          break;  // No need to check further
        }
      }
    }
  }
}


/*----------------------------------------------------------------Function of continues bars down movement-----------------------------------------------------------------*/
void bar_vertical_movement(LinkedList<bar> myList) {
  if(gameStarted)
  {
      if(Y < 900)
      {
          for (int i = 0; i < myList.size(); i++)
          { 
              myList.get(i).y += vertical_bar_speed;
              myList.get(i).coin_y = myList.get(i).y - coinSize;
          }
          if(myList.get(myList.size()-1).y>=900)
          {
             myList.remove(myList.size()-1);
             bar bar_new =new bar(random(250,650),0,random(150,300));
             bar_new.coin_x = random( bar_new.x , bar_new.x + bar_new.width - coinSize);
             myList.addFirst(bar_new);
          }
      }
      else
      {
        for (int i = 0; i < myList.size(); i++)
          { 
              myList.get(i).y-=10;
              myList.get(i).coin_y = myList.get(i).y-coinSize;
          }
          
          if(myList.get(myList.size()-1).y <=0)
          {
              currentPage=6;
              
          }
      }
  }
  
}

/*----------------------------------------------------------------Function of bars back and forth movement-----------------------------------------------------------------*/
void bar_horizontal_movement()
{
  for (int i = 0; i < myList.size(); i++)
  {
    double angle = Math.toRadians(myList.get(i).y); 
    double xMovement = Math.sin(angle) * horizontal_bar_speed; 
    myList.get(i).x += xMovement;
    myList.get(i).coin_x += xMovement;
    myList.get(i).x = constrain(myList.get(i).x, 240, 960-myList.get(i).width);
    myList.get(i).coin_x = constrain(myList.get(i).coin_x, 240, 960-myList.get(i).width);
  }
}

/*----------------------------------------------------------------Function of hitting coins-----------------------------------------------------------------*/
void coins_handle()
{
  for(int i=0; i<myList.size(); i++)
  {
    if( (myList.get(i).coin_y+coinSize == Y &&  X+Size > myList.get(i).coin_x  &&  X+Size <= (myList.get(i).coin_x + coinSize) && myList.get(i).does_coin_exist == true) //hits coin from left
        || (myList.get(i).coin_y+coinSize == Y  &&  X > myList.get(i).coin_x  &&  X < (myList.get(i).coin_x + coinSize) && myList.get(i).does_coin_exist == true) ) //hits coin from right
    {
      myList.get(i).does_coin_exist = false;
      score +=5;
      break;
    }
  }
}

/*----------------------------------------------------------------Drawing background theme-----------------------------------------------------------------*/
void draw_ice_wall(){
  image(stone_wall, 0, 0, 240, 900);
  image(stone_wall, 960, 0, 240, 900);
}

void draw_wood_wall(){
  image(wood_wall1, 0, 0, 240, 900);
  image(wood_wall2, 960, 0, 240, 900);
}

void score_print()
{
  textSize(50);
  fill(255,255,255);
  text("Level: " + String.valueOf(level), 150, 100);
  text("Score: " + String.valueOf(score), 150, 150);
}

/*----------------------------------------------------------------Draw Function-----------------------------------------------------------------*/
void draw() {
      // Your drawing code goes here
      fill(255, 178, 102);
      ellipse(mouseX, mouseY, 50, 50);
      
      // Display buttons based on the current page
      if (currentPage == 0) 
      {
          background(backgroundImage1);
          drawButton("Play Game", 3.25*width/4, 2.75*height/4,200, 50, 1);
          drawButton("Instructions",3.25*width/4, 3.15*height/4, 200, 50, 2);
          // Simulate rain animation
          for (Raindrop raindrop : raindrops) {
            raindrop.fall();
            raindrop.display();
          }
          drawButton("Exit",3.25*width/4, 3.55*height/4, 200, 50,3);
          
          
      } 
      else if (currentPage == 1) {
          game_init();
          background(backgroundImage2); // Page 1 background
          drawButton("Play with Fire", width/2 - 300, height/2 - 100, 200, 50, 4);
          drawButton("Play with Snow", width/2+300, height/2 - 100, 200, 50, 5);
          
          image(Fireboy, width/2 - 370, fireY, 150, 100);
          fireY += sin(frameCount * motionSpeed) * 2; // Adjust the '2' for the amplitude of the motion
      
          // Draw the water image with continuous motion
          image(Watergirl, width/2 + 230, waterY, 150, 100);
          waterY += sin(frameCount * motionSpeed) * 2;
          
          for (Raindrop raindrop : raindrops) {
            raindrop.fall();
            raindrop.display();
          }
          drawButton("Back", width - 100, height - 100, 100, 40, 0);
      } 
      else if (currentPage == 3) 
      {
          exit();
      } 
      else if (currentPage == 2) 
      {
          background(backgroundImage2); // Page 2 background
          displayPage3Title();
          displayPage3Text();
          for (Raindrop raindrop : raindrops) {
            raindrop.fall();
            raindrop.display();
          }
          drawButton("Back", width/2, 3.5*height/4, 200, 60, 0);
      } 
      else if(currentPage == 4)
      {
           background(fire_background);
           draw_wood_wall();
           display(1);
           vertical_bar_speed = level*2;
           horizontal_bar_speed = level;
           par = (level - 1) * 4;
           movment(1);
           intersection(X,Y,myList);
           coins_handle();
           bar_vertical_movement(myList);
           level = int(score/100) + 1;
           if(level > 2)
           {
             bar_horizontal_movement();
           }
           score_print();
           for (Raindrop raindrop : raindrops) {
            raindrop.fall();
            raindrop.display();
          }
           
      } 
      else if(currentPage == 5)
      {
           background(water_background);
           draw_ice_wall();
           display(2);
           vertical_bar_speed = level*2;
           horizontal_bar_speed = level;
           par = (level - 1) * 4;
           movment(2);
           intersection(X,Y,myList); 
           coins_handle();
           bar_vertical_movement(myList);
           level = int(score/100) + 1;
           if(level > 2)
           {
             bar_horizontal_movement();
           }
           score_print();
           for (Raindrop raindrop : raindrops) {
            raindrop.fall();
            raindrop.display();
          } 
      }
      else if (currentPage == 6){
        
           background(backgroundImage3);
           drawButton("Try Again", width/4, 3.55*height/4,200, 50, 1); 
           drawButton("Exit",3.25*width/4, 3.55*height/4, 200, 50,3);
           for (Raindrop raindrop : raindrops) {
            raindrop.fall();
            raindrop.display();
          }
           trans();
           score_print();
      }
}

/*----------------------------------------------------------------When a Key is Pressed Function-----------------------------------------------------------------*/
void  keyPressed() 
{
      if ((keyCode == ' ' || keyCode == UP)&& !isJumping) {
        // Jump when spacebar is pressed and not currently jumping
        ySpeed = -random(15, 30 + par);
        isJumping = true;  // Set the jumping flag to true
        gameStarted = true;
      } 
      else if (keyCode == LEFT) 
      {
        xSpeed = -10; // Move left
      } 
      else if (keyCode == RIGHT) 
      {
        xSpeed = 10; // Move right
      }
}

/*----------------------------------------------------------------When Keys are released Function-----------------------------------------------------------------*/
void keyReleased() 
{
    if (keyCode == LEFT || keyCode == RIGHT) {
      xSpeed = 0; // Stop horizontal movement when left or right arrow key is released
    }
}


/*----------------------------------------------------------------gameover-----------------------------------------------------------------*/

void trans(){
 
         if(rotateGameover1){
           
            translate(250, 200);
            rotate(angle);
            score_print();
            angle += 0.01;
            if (millis() - startTime >= 16000) {
                 rotateGameover1 = false; // Stop rotating after 5 seconds
               }
            
         }
}
           




/*----------------------------------------------------------------Main pages Displaying Functions-----------------------------------------------------------------*/
void drawButton(String label, float x, float y, float w, float h, int targetPage) 
{
    boolean isMouseOver = mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2;  //Check if the mouse is over the button
    
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
    if (mousePressed && isMouseOver) 
    {
        currentPage = targetPage;
        //music.loop();
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
      "4- When the character falls from the floors, he loses.",
      "Own to Kareem, Aya, Reem, Ahmed, Mariam"
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
