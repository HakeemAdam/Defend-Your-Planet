


class Surface {

  ArrayList<Vec2> surface;
  Body b;


  Surface() {
    surface = new ArrayList<Vec2>();

    for (int i=0; i<width; i++) {
      surface.add(new Vec2(i, height - noise(i/200.0)*(height/3)));
    }


    ChainShape chain = new ChainShape();


    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }

    chain.createChain(vertices, vertices.length);


    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    b = box2d.createBody(bd);
    body.createFixture(chain, 1);
    b.setUserData(this);
  }


  void display() {
    strokeWeight(1);
    stroke(0);
    fill(#deb63d);
    beginShape();
    for (Vec2 v : surface) {
      vertex(v.x, v.y);
    }
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  }
}
