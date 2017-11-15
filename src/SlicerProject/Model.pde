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
  private ArrayList<Line>  layers;
  private String           address;
  
  private boolean isModified;
  private boolean isSynchronized;
  
  
  private PVector center;
  
  public Model(ArrayList<Facet> facets, String address)
  {
    this.facets = facets;
    this.address = address;
    isModified = true;
    scaling = new PVector(0, 0, 0);
    rotation = new PVector(0, 0, 0);
    translation = new PVector(0, 0, 0);
  }
  
  public ArrayList<Facet> getFacets()
  {
    return facets;
  }
  
  public void setFacets(ArrayList<Facet> newFacets) {
    //TODO this function must also calculate the center and reset scalling and translation
    scaling = new PVector(0, 0, 0);
    translation = new PVector(0, 0, 0);
    facets = newFacets;
  }
  
  
  public void setScaling(PVector amount)
  {
      
    // This updates the facet vertex coordinates
    // Code still needs to be added to update center
    for (Facet facet : facets) {
      PVector vertices[] = facet.getVertices();
      vertices[0] = PVector.mult(amount);
      vertices[1] = PVector.mult(amount);
      vertices[2] = PVector.mult(amount);
      facet.setVertices(vertices[0], vertices[1], vertices[2]); 
    }
    
    //TODO this function must update the value of center as well as the coordinates of each point of the facets
    isModified = checkModifications();
  }
  
  
  // Spelling fix
  public void setRotation(PVector amount)
  {
    //TODO this function must rotate all points around the center according to the X, Y, & Z rotation in amount
    
    isModified = checkModifications();
  }
  
  
  public void setTranslation(PVector amount)
  {
    //TODO this function must update the value of center and Translation as well as the coridantes of each point of the facets
    isModified = checkModifications();
  }
  
  //this function will read the gcode from the 
  //adress provided in the constuctor to sycronize the facet reprprsentation to the G-code reprprsentation
  public bool synchronize()
  {
    if(isModified){
         //TODO
    }
  }
  
  
  // This method is probably superflous, apparently a built-in
  // PVector.equals() method already exists.
  private boolean pVectorEquals(PVector a, PVector b)
  {
    return a.x == b.x && a.y == b.y && a.z == b.z;
  }
  
  //this function returns true if the facets reprsent the the current G-code
  private boolean checkModifications()
  {
    return isModified;
  }
  


