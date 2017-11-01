class POV {
  
  private PVector location;
  private PVector direction;
  private float orientation;
  private Model subject;
  private RenderController controller;

  public POV(Model subject, RenderController controller) {
    this.subject = subject;
    this.controller = controller;
    this.location = new PVector(0, 0, 0);
    this.direction = new PVector(0, 0, 0);
  }
    
  
  public void move(PVector delta) {
    this.location.add(delta);
  }
  
  public void setpos(PVector newpos) {
    this.location = newpos;
  }
  
  // Not sure if these next two methods are implemented correctly
  public void rotate(PVector delta, float deltaUp) {
    direction.set((direction.X + delta.X) % 360, (direction.Y + delta.Y) % 360, (direction.Z + delta.Z) % 360)
  }
  
  
  // Would it make more sense for this method to take a PVector
  // rather than three floats?
  public void setAngle(Pvector point, float newUp) {
      direction.set(point.X % 360, point.Y % 360, point.Z % 360)
  }
    
   
  public PVector getLocation() {
    return this.location;
  }
  
  public PVector getDirection() {
    return this.direction;
  }
  
  public float getOrientation() {
    return this.orientation;
  }
  
}
