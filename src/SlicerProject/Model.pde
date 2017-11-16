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
  
  
  private boolean FBeingRendered; //is set to true while the facets are being rendered
  private boolean GBeingRendered; //is set to true while the facets are being rendered
  
  private boolean FBeingModified; //this is set to true while the facets are being modifed 
  private boolean GBeingModified; //this is set to true while the Facets are being sliced
  private boolean LBeingModified; //this is set to true while the G-code is being simulated
  
  private boolean isModified;    //this is set to true when the facets have been modifed but 
                                 //not converted to G-code comands
                                 
  private boolean isSynchronized;//this is set to true when the layers reprsent a simulation 
                                 //of the G-code produced from the current faccets 
  
  
  private PVector center;        //gemotric center of the facets 
  
  
  public Model(ArrayList<Facet> facets)
  {
    FBeingModified = true;
    GBeingModified = false;
    LBeingModified = false;
    isModified = true;
    isSynchronized = false;
    
    this.facets = facets;
    
    //TODO must compute geometric mean of facets
  
    FBeingModified = false;
  }
  
  public Slice(float layerHeight, float infill){
      GBeingModified = true;
      Slicer alg(facets, layerHeight, infill);
      layers = alg.sliceLayers();
      G-code = alg.createGCode(layers);
      GBeingModified = false;
            
  }
  
  public Render(Renderer Alg, POV perspective){
       if(Alg.GetType()){
          GBeingRendered = true;
       }
       else{
          FBeingRendered = true;
       }
       Alg.render(perspective);
       if(GBeingRendered){
           GBeingRendered = false;
       }
       else{
          FBeingRendered = false;
       }
  }
  
  public void setFacets(ArrayList<Facet> newFacets) {
    FBeingModified = true; 
    isModified = true;
    isSynchronized = false;
    facets = newFacets;
    //TODO this function must also calculate the center
     FBeingModified = false;
  }
  
  
  public void setScaling(PVector amount)
  {
      if(!FbeingModified && amount.X == 0 && amount.Y == 0 && amount.Z == 0){
          return;
      }
      FBeingModified = true; 
      isModified = true;
      isSynchronized = false;
      
    //This updates the facet vertex coordinates
    //center does not need to be recomputed because mean of all cordnats wont change
    for (Facet facet : facets) {
      PVector vertices[] = facet.getVertices();
      vertices[0].mult(amount);
      vertices[1].mult(amount);
      vertices[2].mult(amount);
      facet.setVertices(vertices[0], vertices[1], vertices[2]); 
    }
    FBeingModified = false; 
  }
  
  
  
  public void setRotation(PVector amount)
  {
     if(!FbeingModified && amount.X == 0 && amount.Y == 0 && amount.Z == 0)
      {
          return;
      }
      FBeingModified = true; 
      isModified = true;
      isSynchronized = false;
    //TODO this function must rotate all points around the center according to the X, Y, & Z rotation in amount
    
      FBeingModified = false;
  }
  
  
  public void setTranslation(PVector amount)
  {
    if(!FbeingModified && amount.X == 0 && amount.Y == 0 && amount.Z == 0)
      {
          return;
      }
      FBeingModified = true; 
      isModified = true;
      isSynchronized = false;
    
    //TODO this function must update the value of center and Translation as well as the coridantes of each point of the facets
      FBeingModified = false;
  }
  
  //this function will read the gcode from the 
  //adress provided in the constuctor to sycronize the facet reprprsentation to the G-code reprprsentation
  public bool synchronize()
  {
    if(isModified){
         //TODO
    }
  }
  
  
  
  //this function returns true if the facets reprsent the the current G-code
  private boolean checkModifications()
  {
    return isModified;
  }
  
  public ArrayList<Facet> getFacets()
  {
    return facets;
  }
  


