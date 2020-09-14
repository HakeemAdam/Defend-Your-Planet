

//Importing Box2d Libraries//
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

//Variable from state machines to switch between Gameplay modes//
int state = 0;

//Variables for countdown timer
int countDownDuration = 100000; // Total time in milliseconds
int startTime = 0; // Start time

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// Initializing the classses for the Surface and the Ball
Surface surface;
Ball ball;

//Boolan variable to toggle gravity of objects in the world
boolean gravityIsOn = true;


// A reference to our box2d world
Box2DProcessing box2d;



void setup() {

  //Screen size
  size(800, 800);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Setting custom gravity for all elements in the worl
  box2d.setGravity(0, -10);

  // Create the empty list for the Particle class
  particles = new ArrayList<Particle>();

  // Create the surface/chain shape
  surface = new Surface();

  //Creating a ball in the world
  ball = new Ball(200, 200);
}



void draw() {


  box2d.step();
  background(0);

  //Initializing Box2d in draw and setting the backgroun


  if ( state == 0) {



    background(0);
    textSize(25);
    fill(#c2dacc);
    textAlign(CENTER);
    text("Clear the Balls from your Planet!", width/2, height/2);
    text("Remember, you are in space!", width/2 + 150, height/2 +150);
    text("Press Any Key to Start!", width/2 +100, height/2 +100);
    if (keyPressed) {
      state = 1;
    }
  } else if (state == 1) {
    //State 1 or the gameplay level, where all the active elements are created and used
    //Creating 50 balls(particles at the start of the game
    //This loop also starts the countdown sequence
    // Draw the surface/chainshape
    surface.display();

    //displaying the abll in the world
    ball.display();

    // Compute timing in milliseconds:
    int currentTime = millis();
    int endOfCountDown = startTime + countDownDuration;
    int remainingTime = 0;
    if (currentTime < endOfCountDown) {
      remainingTime = endOfCountDown - currentTime;
    }

    int seconds = remainingTime / 1000;


    textSize(24);
    fill(#c2dacc);
    textAlign(RIGHT);
    text("Time Left = " + seconds, width/2, 30);

    textSize(24);
    fill(#c2dacc);
    text("Balls Left = " + particles.size(), width/2, 50);


    // Draw all particles in the world from the arraylist created
    for (Particle p : particles) {
      p.display();
    }

    if (particles.size() < 50) {

      for (int i = particles.size(); i == 50; i ++);
      float size = random(5, 10);
      particles.add(new Particle(random(width), 0, size));
      
       // Deleting the partciles that leave the screen
    for (int i = 0; i == particles.size(); i++) {
      Particle p = particles.get(i);
      if (!p.isOnScreen()) {
        if (p.done()) {
          p.killBody();
          particles.remove(i);
          i--;
        }
      }
    }
println(particles.size());
      startTime = millis(); // Set start of countdown to NOW
    }

   

    if (seconds == 0) {
      state = 2;
    }

    int finalScore = particles.size();
    if ( finalScore == 0) {
      particles.clear();
      state = 3;
    }
  } else if (state == 3) {
    background(#c2dacc);
    fill(255);
    textAlign(CENTER);
    text("You Win", width/2, height/2);
    text("Click anywhere to continue", width/2 +50, height/2 +50);
    if (mousePressed) {
      state = 0;
    }
  } else if (state ==2) {
    background(#c2dacc);
    fill(255);
    textAlign(CENTER);
    text("Game Over", width/2, height/2);
    text("Click anywhere to continue", width/2 +50, height/2 +50);
    if (mousePressed) {
      state = 0;
    }
  }
}


void keyPressed() {
  if (keyCode == UP)
    ball.setImpulse(0, 100);
  else if (keyCode == DOWN)
    ball.setImpulse(0, -100);
  else if (keyCode == RIGHT)
    ball.setImpulse(100, 0);
  else if (keyCode == LEFT)
    ball.setImpulse(-100, 0);
}
