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
    
    
  public void zoom(float delta)
    {
      if(delta > 0)
        {
          location.lerp(focus, delta/abs(PVector.dist(location, focus)));
        }
      else
        {
          delta = -delta;
          location.add(PVector.lerp(location, focus, 1).normalize().mult(delta/PVector.dist(location, focus)));
        }
      
      
    }
  
  public void move(PVector delta) 
    {
      this.location.add(delta);
    }
  
  public void setpos(PVector newpos) 
    {
      this.location = newpos;
    }
  
  // Not sure if these next two methods are implemented correctly
  public void Rotate(PVector delta) 
    {
      //the next term puts all delts in range -360 <= deg <= 360
      delta.set(delta.x - int(delta.x / 360)*360,  delta.y - int(delta.y / 360)*360, delta.z - int(delta.z / 360)*360);
    
      if(delta.x != 0)
        {
          if(delta.x < 0)
            {
             delta.x = radians(360 + delta.x); 
            }
          //rotate in x axis 
          float before = PVector.dist(focus, location);
          location.x = location.x + abs(PVector.dist(focus, location)) * sin(delta.x);
          location.z = location.z +  abs(PVector.dist(focus, location)) * (1-cos(delta.x)); 
          if(before != PVector.dist(focus, location)){
            boolean wait = true;
            while(wait){
              if(mousePressed)
                {
                  wait=false;
                }
            }
          }
        }
         
      if(delta.y != 0)
        {
          if(delta.y < 0)
            {
             delta.y = radians(360 + delta.y); 
            }
          //rotate in y axis 
          location.z = location.z +  PVector.dist(focus, location) * (1-cos(delta.y));
          location.y = location.y + PVector.dist(focus, location) * sin(delta.y);
        }
          
     if(delta.z != 0)
        {   
          if(delta.z < 0)
            {
               delta.z = radians(360 + delta.z); 
            }
          //rotate in z axis 
          location.y = location.y + PVector.dist(focus, location) * (1-cos(delta.z));
          location.z = location.z + PVector.dist(focus, location) * sin(delta.z);
        }
    }
  
  public void setFocus(PVector delta)
    {
        focus = delta;
    }
  
  public void setUp(PVector up)
    {
        orientation = up;
    }
  
  
  public PGraphics setCamera(PGraphics frame){
    frame.camera(location.x, location.y, location.z, focus.x, focus.y, focus.z, orientation.x, orientation.y, orientation.z);
    return frame;
  }
}