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
    // Construct a new PVector, in case it isn't desirable to change
    // the original
    PVector rotatedDelta = new PVector(delta.x, delta.y, delta.z);
    rotatedDelta.rotate(radians(deltaUp % 360));
    direction.add(rotatedDelta);
  }
  
  
  // Would it make more sense for this method to take a PVector
  // rather than three floats?
  public void setAngle(float x, float y, float z, float newUp) {
    PVector newAngle = new PVector(x, y, z);
    newAngle.rotate(radians(newUp % 360));
    this.orientation = newAngle;
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