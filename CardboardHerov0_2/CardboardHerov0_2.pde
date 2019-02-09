import java.util.Arrays;
import processing.sound.*;
import gifAnimation.*;
//SoundFile CLow, D, E, F;
/* ---------------------------------------------------------------------- Note Class Starts Here ---------------------------------------------------------------------- */

// Class for the music notes.
class Note {
  float x;
  PVector location;
  float speed;
  color c;
  boolean hit = false;


  Note() {
    initialize();
  }

  void initialize() {
    hit = false;
    x = random(0, 4);
    location = new PVector(0, random(-8000, -500));
    //y = random(-1500, -500);
    speed = 5; // *** Change the speed of the notes here! ***
  }

  void run() {
    display1();
    move();
  }

  void display1() {
    // x used as randomizer. 
    if (x <= 1) {
      fill(100, 0, 0); // Colors the red note on line 1
      location.x = 8;
      rect(location.x, location.y, 100, 40, 40);
    } else if (x <= 2) {
      fill(0, 150, 0); // Colors the green note on line 2
      location.x = 110;
      rect(location.x, location.y, 100, 40, 40);
    } else if (x <= 3) {
      fill(0, 0, 200); // Colors the blue note on line 3
      location.x = 210;
      rect(location.x, location.y, 100, 40, 40);
    } else {
      fill(200, 200, 0); // Colors the yellow note on line 4
      location.x = 310;
      rect(location.x, location.y, 100, 40, 40);
    }
  }

  void move() {
    if (location.y - 40 <= height) {
      location.y += speed;
    }
  }
}


/* ---------------------------------------------------------------------- Note Class Ends Here ---------------------------------------------------------------------- */

// Sets the initial score to 0.
int score = 0;

// Timer that will track the play time (for demo purposes we can limit each player with this if needed)
int millisecs = 0;
int seconds = 0;
int minutes = 0;

// Boolean for whether the game is playing or not
Boolean winOrLose = false;

// Timer to stop game after you lose
int loseTimer = 0;

// Timer to stop game after you win
int winTimer = 0;


// Array that holds the amount of notes to be drawn. 
ArrayList<Note> n = new ArrayList<Note>();

// Background GIF
Gif mcDab;


void setup() {
  // Stage size and setup
  size(420, 800);
  mcDab = new Gif(this, "LastOneISwear.gif");
  mcDab.play();

  // Sounds for the notes
  //CLow = new SoundFile(this, "CLow.mp3");
  //D = new SoundFile(this, "D.mp3");
  //E = new SoundFile(this, "E.mp3");
  //F = new SoundFile(this, "F.mp3");
}

void draw() {
  //Background color 
  background(212, 175, 55);

  //Draw the background
  image(mcDab, 0, 0);

  Note note = new Note();
  if (frameCount % 30 == 0) {
    n.add(note);
  }

  // String Color
  fill(255);

  // Draws the strings
  rect(40, -10, 40, 900);
  rect(140, -10, 40, 900);
  rect(240, -10, 40, 900);
  rect(340, -10, 40, 900);

  // Breaks the fill effect at this point
  noFill();

  // Scoreboard
  fill(0, 0, 0);
  textSize(20);
  text("Score:" + score, 20, 20);

  // Timer
  textSize(20);
  text("Time: ", 300, 20);

  if (int(millis()/100)  % 10 != millisecs) {
    millisecs++;
  }

  if (millisecs >= 10) {
    millisecs -= 10;
    seconds++;
  }

  if (seconds >= 60) {
    seconds -= 60;
    minutes++;
  }

  text(nf(minutes, 2) + ":" + nf(seconds, 2), 360, 20);


  noFill();

  // Line where the notes will register when hit
  stroke(255, 165, 0);
  strokeWeight(3);
  line(0, 650, 800, 650);
  strokeWeight(0);
  stroke(0);

  for (int i = 0; i < n.size(); i++) {
    Note n3 = (Note) n.get(i);
    n3.run();

    if (winOrLose == false) {
      // Input Keys:
      if (key == 'a' && n3.hit == false && n3.location.y >= 630 && n3.location.y <= 670 && n3.location.x == 8 && keyPressed) {
        n3.hit=true;
        println("red key hit");
        score += 100;
        //CLow.play();
      }
      if (key == 's' && n3.hit == false && n3.location.y >= 630 && n3.location.y <= 670 && n3.location.x == 110 && keyPressed) {
        n3.hit=true;
        println("green key hit");
        score += 100;
        //D.play();
      }
      if (key == 'd' && n3.hit == false && n3.location.y >= 630 && n3.location.y <= 670 && n3.location.x == 210 && keyPressed) {
        n3.hit=true;
        println("blue key hit");
        score += 100;
        //E.play();
      }
      if (key == 'f' && n3.hit == false && n3.location.y >= 630 && n3.location.y <= 670 && n3.location.x == 310 && keyPressed) {
        n3.hit=true;
        println("yellow key hit");
        score += 100;
        //F.play();
      }
    }
    if (n3.location.y >= 750) {
      n.get(i);
      n.remove(i);
      if (winOrLose == false) {
        score += -100;
      }
    }
    if (n3.hit == true) {
      n.remove(i);
    }

    if (score <= -500) {
      winOrLose = true;
      textSize(50);
      text("You Lose!", 100, 250);
      loseTimer++;
    }

    if (loseTimer == 10000) {
      exit();
    }

    if (winTimer == 10000) {
      exit();
    }

    if (minutes >= 2) {
      winOrLose = true;
      textSize(50);
      text("You Win!", 100, 250);
      final int score2 = score;
      textSize(30);
      text("Your Score was: " + score2, 70, 350);
      winTimer++;
    }
  }
}