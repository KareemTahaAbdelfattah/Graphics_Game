float FireboyX, FireboyY;
float FireboySize = 50;
float jumpForce = -20;  // Negative value for upward force
float gravity = 1;      // Acceleration due to gravity
float ySpeed = 0;       // Vertical speed
float xSpeed = 0;       // Horizontal speed
boolean isJumping = false; // Flag to track if the ball can jump
PShape Fireboy;
PShape Watergirl;

void setup() {
  size(700, 900);
  FireboyX = width / 2;
  FireboyY = height - FireboySize;
  smooth();
  Fireboy = loadShape("Fireboy.svg");
  Watergirl = loadShape("Watergirl.svg");
}

void draw() {
  background(220);

  // Update ball position
  FireboyY += ySpeed;
  ySpeed += gravity;
  FireboyX += xSpeed;
  
  // Draw the ball
  fill(0, 0, 255);
  shape(Watergirl, FireboyX, FireboyY, FireboySize, FireboySize);

  // Check for ground collision
  if (FireboyY >= height - FireboySize) {
    FireboyY = height - FireboySize;
    ySpeed = 0;
    isJumping = false;  // Allow jumping when on the ground
  }

  // Keep the ball within the window bounds
  FireboyX = constrain(FireboyX, 0, width - FireboySize);
}

void keyPressed() {
  if (keyCode == ' ' && !isJumping) {
    // Jump when spacebar is pressed and not currently jumping
    ySpeed = jumpForce;
    isJumping = true;  // Set the jumping flag to true
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
