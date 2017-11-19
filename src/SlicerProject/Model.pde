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
    private ArrayList<Facet>   facets;     
    private ArrayList<String>  GCode;
    private ArrayList<Layer>    layers;
  
    private float layerHeight;
    private float inFill;
  
  
    private PVector center;        //gemotric center of the facets
  
  
    private boolean isModified;
                            
  
  
    public Model(ArrayList<Facet> facets, float LH, float IF)
      {
        //set state variables
        isModified = true;      //facets need to be sliced to G-code       
        
        this.facets = facets;  //initilize facets
        
        //set slicing setting      
        this.inFill = IF;             
        this.layerHeight = LH;
 
        
        //compute geometric mean of facets
        float AvgX=0;
        float AvgY=0;
        float AvgZ=0;
        int n = facets.size();
        PVector[] temp;
        float tempAvg = 0;
        for (Facet facet : facets) {
           temp = facet.getVerticies();
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
        
        center = new PVector(AvgX, AvgY, AvgZ);
    }
  
  
  public void Slice()
    {
      if( isModified ) 
        {
           Slicer alg = new Slicer(facets, layerHeight, inFill);
           layers = alg.sliceLayers();
           GCode = alg.createGCode(layers);    
           synchronize();
           isModified = false;
        }
    }  
  
  
  public void Scale(PVector amount)
    {
        if(amount.x == 0 && amount.y == 0 && amount.z == 0){
            return;
        }
      
      //This updates the facet vertex coordinates
      //center does not need to be recomputed because mean of all cordnats wont change
      for (Facet facet : facets) {
        PVector vertices[] = facet.getVerticies();
        for(int i=0; i<3; i++)
          {  
            vertices[i].x *= amount.x;
            vertices[i].y *= amount.y;
            vertices[i].z *= amount.z;
          }
        facet.setVertices(vertices[0], vertices[1], vertices[2]); 
      } 
      isModified = true;
      levelModel();
    }
  
  
    //rotates the model by degrees acording to the values passed in amount
  public void Rotate(PVector amount)
    {
      if(amount.x == 0 && amount.y == 0 && amount.z == 0)
        {
          return;
        }  
     
      amount.set(radians(amount.x), radians(amount.y), radians(amount.z));
     
      //rotate each facet around the X, Y, and Z axis 
      for (Facet facet : facets) 
        {
          PVector[] temp = facet.getVerticies();
          
          for(int i=0; i<3; i++)
            {
               //get the distance of the point from the center of the model
               float distance = PVector.dist(temp[i], center); 
          
          
               //rotate around x axis 
               temp[i].z = center.z +  distance * cos(amount.x);
               temp[i].y = center.y + distance * sin(amount.x);
              
               //rotate around y axis 
               temp[i].z = center.z +  distance * cos(amount.y);
               temp[i].x = center.x + distance * sin(amount.y);
          
          
               //rotate around z axis 
               temp[i].y = center.y + distance * cos(amount.z);
               temp[i].x = center.x + distance * sin(amount.z);
            }
            facet.setVertices(temp[0], temp[1], temp[2]);
         }
       isModified = true;
       levelModel();
    }
 
  public void Translate(PVector amount)
    {
      if(amount.x == 0 && amount.y == 0 && amount.z == 0)
        {
          return;
        }
      for (Facet facet : facets) 
        {
           PVector[] temp = facet.getVerticies();
           facet.setVertices(temp[0].add(amount), temp[1].add(amount), temp[2].add(amount));
        }
      center.add(amount);
      isModified = true;
      levelModel();    
    }
  
  public void setInfill(float newFill)
    {
      inFill = newFill;
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
   
  public void TESTsetLayers(ArrayList<Layer> layers)
    {
     this.layers = layers; 
    }
    
    
  public boolean isModified()
    {
      return isModified;
    }
    
  public PVector getCenter()
    {
      return center;
    }
      

  
  public ArrayList<Facet> getFacets()
    {
      return facets;
    }
  
  public void setFacets(ArrayList<Facet> in)
    {
      facets = in;
      isModified = true;
    }
  
  public ArrayList<String> getGCode()
    {
      return GCode;
    }
  
  public ArrayList<Layer> getLayers()
    {
      return layers;
    }
  
  
  public void levelModel()
    {
      //find lowest point
      PVector min = facets.get(0).GetLowest();
      for (Facet facet : facets) 
        {
           if(facet.GetLowest().z < min.z)
             {
               min = facet.GetLowest();
             }
         }
       
       //invert the value of the lowest point 
       //models above the floor are moved down
       //models bellow are moved up
       min.z = -min.z;
       min.x=0;
       min.y=0;
       
       //update all facets 
       for (Facet facet : facets) 
         {
           PVector[] temp = facet.getVerticies();
           facet.setVertices(temp[0].add(min), temp[1].add(min), temp[2].add(min));
         }
         
         isModified = true;
    }
 
 
 
  //this function will read the gcode from the 
  //adress provided in the constuctor to sycronize the facet reprprsentation to the G-code reprprsentation
  private void synchronize()
    {
      //TODO
    }
    
  }