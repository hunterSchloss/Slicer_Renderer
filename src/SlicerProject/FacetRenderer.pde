/*
FacetRenderer.pde
 
This Sketchbook tab holds the definition and implementation of the Facet Renderer class.
 
the Facet Renderer class is an implintaion of the Renderer interface for rendering Facets 

 
 Authors:
Rendering Team
Hunter Schloss
 */

class FacetRenderer implements Renderer{

    public FacetRenderer(){
    }
    
    public Render(Model subject) {
       beginCamera();
       camera(); //TODO how to get camera
       ArrayList<Facet> temp = subject.getFacets();
       
       for (Facet facet : temp) {
              beginShape();
              PVector[] Triangle = facet.getVerticies();
              vertex(Triangle[0].x, Triangle[0].y, Triangle[0].z);
              vertex(Triangle[1].x, Triangle[1].y, Triangle[1].z);
              vertex(Triangle[2].x, Triangle[2].y, Triangle[2].z);
              endShape();    
       }
       endCamera();
    }
    
}