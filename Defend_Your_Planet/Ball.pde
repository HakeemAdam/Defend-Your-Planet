
// A simple ball
class Ball {

  Body body;      
  float r = 20;

  Ball(int x, int y) {
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    
    bd.linearDamping = 1;
    body = box2d.createBody(bd);

    
    CircleShape cs = new CircleShape();
    float radius = box2d.scalarPixelsToWorld(r);
    cs.m_radius = radius;

    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    
    fd.density =1;
    fd.friction = 0.5;
    fd.restitution = 0.3;  
               
    body.createFixture(fd);
    //body.setUserData(this);
  
  }

  void setImpulse(float x, float y) {
    Vec2 pos = body.getWorldCenter();
    body.applyLinearImpulse(new Vec2(x, y), pos, true);
    
  }

  boolean done() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }
  
  boolean isOnScreen() {
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    return (pos.x >= 0 && pos.x < width && pos.y >= 0 && pos.y < height);
  }

  void killBody() {
    box2d.destroyBody(body);
  }
  void display() {
    fill(#eb0132);
    noStroke();
    ellipseMode(RADIUS);
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    ellipse(pos.x, pos.y, r, r);
  }
}
