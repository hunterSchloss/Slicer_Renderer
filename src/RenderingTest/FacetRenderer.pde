/*
FacetRenderer.pde
 
This Sketchbook tab holds the definition and implementation of the Facet Renderer class.
 
the Facet Renderer class is an implintaion of the Renderer interface for rendering Facets 

 
 Authors:
Rendering Team
Hunter Schloss
 */

class FacetRenderer implements Renderer{  
    ArrayList<Facet> Mesh;
  
    public void Load(Model Subject)
      {
        Mesh = Subject.getFacets();
      }
      
    public int getSize()
      {
        return Mesh.getSize();
      }
      
    public PShape Render(int i) 
      {     
       PShape out = createShape();
       if(i >= Mesh.size())
         {
            return out; 
         }
       PVector[] Triangle = Mesh.at(i).getVerticies();

           
       out.beginShape();
       out.vertex(Triangle[0].x, Triangle[0].y, Triangle[0].z);     
       out.vertex(Triangle[1].x, Triangle[1].y, Triangle[1].z);   
       out.vertex(Triangle[2].x, Triangle[2].y, Triangle[2].z);  
       out.endShape();
           
       out.addChild(temp);
       return out;
     }
       
}
