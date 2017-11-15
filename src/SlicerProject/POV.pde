class POV {
  
  private PVector location;
  private PVector foucus;
  private PVector orientation; //each feild must be -1, 0, 1
  private Model subject;

  public POV(Model subject, PVector loc, PVector fouc, PVector Ori)
  {
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
    direction.set((direction.x + delta.x) % 360, (direction.y + delta.y) % 360, (direction.z + delta.z) % 360);
  }
  
  
  public Camera getCamera(){
    return new camera(location.X, location.Y, location.Z, foucus.X, foucus.Y, foucus.Z, orientation.X, orientation.Y, orientation.Z);
  }

    
   
 
  
}
