class POV {
  
  private PVector location;
  private PVector focus;
  private PVector orientation; //each feild must be -1, 0, 1

  public POV(PVector loc, PVector foc, PVector Ori)
  {
    this.location = loc;
    this.focus = foc;
    this.orientation = Ori;
  }
    
  
  public void move(PVector delta) {
    this.location.add(delta);
  }
  
  public void setpos(PVector newpos) {
    this.location = newpos;
  }
  
  // Not sure if these next two methods are implemented correctly
  public void rotate(PVector delta) {
    //TODO
  }
  
  public void setFocus(PVector delta){
        focus = delta;
  }
  
  public void setUp(PVector up){
        orientation = up;
  }
  
  
  public PGraphics setCamera(PGraphics frame){
    frame.camera(location.x, location.y, location.z, focus.x, focus.y, focus.z, orientation.x, orientation.y, orientation.z);
    return frame;
  }
}