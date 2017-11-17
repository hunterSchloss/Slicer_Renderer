/*
Model.pde

This Sketchbook tab holds the definition and implementation of the Model class.

The Model class serves as a central object to hold the 3d model currently being
 processed. It also contains various methods to manipulate the model, including scaling
 and rotations. Performing these modifications results in the facets that make up the
 object being modified, along with properties that hold information about these
 modifications. Finally, the Model class also provides a method to obtain strings
 that make up an STL file that represents the current state of the model.

Authors: Slicing Team (Andrew Figueroa)
*/

public class Model
{
  private ArrayList<Facet> facets;     
  private ArrayList<String>  GCode;
  private ArrayList<Line>  layers;
  
  private float layerHeight;
  private float inFill;
  
  private RenderControler visualizer;        //the point of view for the renderer
  
  
  private PVector center;        //gemotric center of the facets
  
  
 private boolean isModified;
                            
  
  
public Model(ArrayList<Facet> facets, float LH, float IF, RenderControler visualizer)
  {
        //set state variables
        isModified = true;      //facets need to be sliced to G-code       
        
        this.facets = facets;  //initilize facets
        
        //set slicing setting      
        this.inFill = IF;             
        this.layerHeight = LH;
        
        //set Rendering settting 
        this.visualizer = visualizer;       
        
        //compute geometric mean of facets
        float AvgX=0;
        float AvgY=0;
        float AvgZ=0;
        int n = facets.size();
        Pvector[] temp;
        float tempAvg = 0;
        for (Facet facet : facets) {
           temp = facet.getVertices();
           tempAvg = 0;
           for(int i=0; i<3; i++){
              tempAvg += temp[i].x / 3;
           }
           AvgX += tempAvg/n;
           
           tempAvg = 0;
           for(int i=0; i<3; i++){
              tempAvg += temp[i].y / 3;
           }
           AvgY += tempAvg/n;
           
           tempAvg = 0;
           for(int i=0; i<3; i++){
              tempAvg += temp[i].z / 3;
           }
           AvgZ += tempAvg/n;
        }
        
        center = new Pvector(AvgX, AvgY, AvgZ);
        
        //preform initial rendering
        visualizer.Render(this);
  }
  
  
public void Slice()
  {
          if( isModified ) {
             Slicer alg(facets, layerHeight, infill);
             layers = alg.sliceLayers();
             G-code = alg.createGCode(layers);    
             synchronize();
             isModified = false;
          }
  }
  
  
public void setScaling(PVector amount)
  {
      if(amount.X == 0 && amount.Y == 0 && amount.Z == 0){
          return;
      }
      
    //This updates the facet vertex coordinates
    //center does not need to be recomputed because mean of all cordnats wont change
    for (Facet facet : facets) {
      PVector vertices[] = facet.getVertices();
      vertices[0].mult(amount);
      vertices[1].mult(amount);
      vertices[2].mult(amount);
      facet.setVertices(vertices[0], vertices[1], vertices[2]); 
    } 
    isModified = true;
    visualizer.Render(this);
  }
  
  
  //rotates the model by degrees acording to the values passed in amount
public void Rotate(PVector amount)
  {
     if(amount.X == 0 && amount.Y == 0 && amount.Z == 0)
      {
          return;
      }
      
      amount.set(radians(amount.x), radians(amount.y), radians(amount.z))
      
      //rotate each facet around the X, Y, and Z axis 
      for (Facet facet : facets) {
           PVector temp = facet.getVertices();
           
           for(int i=0; i<3; i++){
               //get the distance of the point from the center of the model
               flaot distance = PVector.dist(temp[i], center); 
           
               //rotate around X axis 
               temp[i].x += distance * cos(amount.x);
               temp[i].z = distance * sin(amount.x);
           
               //rotate around y axis 
               temp[i].y += distance * cos(amount.y);
               temp[i].x = distance * sin(amount.y);
           
               //rotate around z axis 
               temp[i].z += distance * cos(amount.z);
               temp[i].y = distance * sin(amount.z);
           }
           facet.setVertices(temp[0], temp[1], temp[2]);
      }
    isModified = true;
    visualizer.Render(this);
  }
 
public void setTranslation(PVector amount)
  {
    if(amount.X == 0 && amount.Y == 0 && amount.Z == 0)
      {
          return;
      }
    for (Facet facet : facets) 
      {
         PVector[] temp = facet.getVertices();
         facet.setVertices(temp[0].add(amount), temp[1].add(amount), temp[2].add(amount));
       }
    center.add(amount);
    isModified = true;
    visualizer.Render(this);
  }
  
public void setInfill(float newFill)
  {
      inFill = newFill
      isModified = true;
  }
  
public float getInFill()
  {
       return inFill;
  }
  
public void setLayerHeight(float newH)
  {
      layerHeight = newH;
      isModified = true;
  }
  
public float getGetLayerHeight()
  {
       return layerHeight;
  }
  
public void setPOV(POV newPOV)
  {
      perspective = newPOV;
      visualizer.Render(this);
  }
  
public ArrayList<Facet> getFacets()
  {
    return facets;
  }
  
public ArrayList<Facet> setFacets(ArrayList<Facet> in)
  {
    facets = in;
    visualizer.Render(this);
  }
  
public ArrayList<string> getGCode()
  {
    return facets;
  }
  
public ArrayList<Layer> getLayers()
  {
    return facets;
  }
  
  //this function will read the gcode from the 
  //adress provided in the constuctor to sycronize the facet reprprsentation to the G-code reprprsentation
private bool synchronize()
  {
      int PositioningMode = 0;
      float LastX = 0;
      float LastY = 0;
      layers.clear();
      
      for (String comand : GCode) 
        {
              if(comand == "G90")
                 {
                   PositioningMode = 1;
                 }
               else if(comand == "G91")
                 {
                   PositioningMode = -1;
                 }
                 else
                   {
                     if(comand.substring(0,1) == "G1")
                       {
                         if(PositioningMode == 1)
                           {
                             layers.add(new line(lastX, lastY,                
                           }
                         else if(PositioningMode == -1)
                           {
                               
                           }
                       }
                   }
            }
    }
  
 
  
