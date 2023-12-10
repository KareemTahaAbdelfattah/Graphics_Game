import ddf.minim.*;

Minim minim;
AudioPlayer music;


PImage backgroundImage1;
PImage backgroundImage2;
int currentPage = 0;
boolean tr= true ;
Raindrop[] raindrops; // Array to store raindrop objects




void setup() {
  size(1200, 900);
  
  minim = new Minim(this);
  music = minim.loadFile("theme_song.mp3");
  music.loop();
  
  
  
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
}

void draw() {
  // Set the background to the loaded image
  background(backgroundImage1);
  
  
  
  
  
  
  // Simulate rain animation
  for (Raindrop raindrop : raindrops) {
    raindrop.fall();
    raindrop.display();
  }
  
  // Your drawing code goes here
  fill(255, 178, 102);
  ellipse(mouseX, mouseY, 50, 50);
  
  
  // Display buttons based on the current page
  if (currentPage == 0) {
    drawButton("Play Game", 3.25*width/4, 2.75*height/4,200, 50, 1);
    drawButton("Options", 3.25*width/4, 3.15*height/4, 200, 50,2);
    drawButton("Instructions", 3.25*width/4, 3.55*height/4, 200, 50,3);
    
  } else if (currentPage == 1) {
    background(255, 178, 102); // Page 1 background
    drawButton("Back", 3*width/4, 2.5*height/4, 100, 40, 0);
  } else if (currentPage == 2) {
    background(200, 255, 200); // Page 2 background
    drawButton("Back", 3*width/4, 2.75*height/4, 100, 40,0);
  } else if (currentPage == 3) {
    background(backgroundImage2); // Page 3 background
    displayPage3Title();
    displayPage3Text();
    for (Raindrop raindrop : raindrops) {
      raindrop.fall();
      raindrop.display();
    }
    drawButton("Back", width/2, 3.5*height/4, 200, 60,0);
    
  }
  
}



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
    text(instructions[i], textX + 280, textY);
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
