class POV {
  
  private PVector location;
  private PVector focus;
  private PVector orientation; //each feild must be -1, 0, 1
  Private PVector TopLeft;
  Private PVector BottomRight;
  private Model subject;

  public POV(PVector loc, PVector foc, PVector Ori, PVector TL, PVector BR)
  {
    this.location = loc;
    this.focus = foc;
    this.orientation = Ori;
    this.TopLeft = TL;
    this.BottomRight = BR;
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
  
  public void SetFoucus(PVector delta){
        focus = delta;
  }
  
  public void setUp(PVector up){
        orientation = up;
  }
  
  
  public Camera getCamera(){
    return new camera(location.X, location.Y, location.Z, foucus.X, foucus.Y, foucus.Z, orientation.X, orientation.Y, orientation.Z);
  }
  
  public PVector getTopLeft(){
        return TopLeft;
  }
  
   public void setTopLeft(Pvector in){
       TopLeft = in;
  }
  
   public PVector getBottomRight(){
        return BottomRight;
  }  
  
  public void setBottomRight(Pvector in){
       BottomRight = in;
  }
}
