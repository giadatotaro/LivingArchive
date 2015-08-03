import de.voidplus.leapmotion.*;
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

LeapMotion leap;

int id; //finger ID
float X,Y,Z; //finger position

void setup() {
  size(800, 500, OPENGL);
  background(255);

  leap = new LeapMotion(this);
  oscP5 = new OscP5(this,5432);
  myRemoteLocation = new NetAddress("127.0.0.1",5432); // OSC address, port.
}

void draw() {
  background(255);
  
  for (Hand hand : leap.getHands ()) {

    hand.draw();

    for (Finger finger : hand.getFingers()) {

      int     finger_id         = finger.getId(); 
      PVector finger_position   = finger.getPosition(); 
      
      id = finger_id % 10; // finger ID
      X = finger_position.x; // finger position X coordinate
      Y = finger_position.y; // finger position Y coordinate
      Z = finger_position.z; // finger position Z coordinate
      
      OscMessage myMessage = new OscMessage("/"+id);
      myMessage.add(X);
      myMessage.add(Y);
      myMessage.add(Z);
      oscP5.send(myMessage, myRemoteLocation); 
      
      println("finger ID: "+id+" -  X:"+X+" -  Y:"+Y+" -  Z:"+Z);

    }
   }
 }
