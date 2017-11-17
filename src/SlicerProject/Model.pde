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
  private ArrayList<String>  G-code;
  private ArrayList<Line>  layers;
  
  float layerHeight;
  float inFill;
  
  POV perspective;                //the point of view for the renderer
  
  Renderer visulizer;
  
  private PVector center;        //gemotric center of the facets
  
  
 private boolean isModified;
 private boolean RenderFacets;
                            
  
  
  public Model(ArrayList<Facet> facets, float LH, float IF, POV per, boolean mode)
  {
        isModified = true;
        RenderMode = true;
        this.facets = facets;
        this.inFill = IF;
        this.layerHeight = LH;
        this.perspective = per;
        this.RenderFacets = mode;
        if(RenderFacets){
            this.visulizer = FacetRender();
        }
        else{
            this.visulizer = LayerRender();
        }
        
        
        //TODO must compute geometric mean of facets
         
  }
  
  
  public void Slice(float layerHeight, float infill){
          if(isModified){
             Slicer alg(facets, layerHeight, infill);
             layers = alg.sliceLayers();
             G-code = alg.createGCode(layers);    
             synchronize();
             isModified = false;
          }
  }
  
  
  public void Render(){ 
       if(!RenderFacets && isModified){
          Slice();
       }
       Alg.render(perspective);
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
    Render();
  }
  
  
  
  public void setRotation(PVector amount)
  {
     if(amount.X == 0 && amount.Y == 0 && amount.Z == 0)
      {
          return;
      }
    //TODO this function must rotate all points around the center according to the X, Y, & Z rotation in amount
    isModified = true;
    Render();
  }
  
  public void setTranslation(PVector amount)
  {
    if(amount.X == 0 && amount.Y == 0 && amount.Z == 0)
      {
          return;
      }
    
    //TODO this function must update the value of center and Translation as well as the coridantes of each point of the facets
    isModified = true;
    Render();
  }
  
  public void setInfill(float newFill){
      inFill = newFill
      isModified = true;
  }
  
  public float getInFill{
       return inFill;
  }
  
   public void setLayerHeight(float newH){
      layerHeight = newH;
      isModified = true;
  }
  
  public float getGetLayerHeight(){
       return layerHeight;
  }
  
  public void setPOV(POV newPOV){
      perspective = newPOV;
      Reneder();
  }
  
  public float getGetLayerHeight(){
       return perspective;
  }
  
   public ArrayList<Facet> getFacets()
  {
    return facets;
  }
  
  //this function will read the gcode from the 
  //adress provided in the constuctor to sycronize the facet reprprsentation to the G-code reprprsentation
  private bool synchronize()
  {

  }
  
 
  


