/*
FacetRenderer.pde
 
This Sketchbook tab holds the definition and implementation of the Facet Renderer class.
 
the Facet Renderer class is an implintaion of the Renderer interface for rendering Facets 

 
 Authors:
Rendering Team
Hunter Schloss
 */

class LayerRenderer implements Renderer
  {  
    boolean[] isVisible;
    boolean RenderTravles;
    int numLayers;
    
    public LayerRenderer()
      {
        numLayers = 0;
        RenderTravles = false;
      }
    
     public PShape Render(Model Subject)
       {
         ArrayList<Layer> layers = Subject.getLayers();
         if(layers.size() != numLayers)
           {
             isVisible = new boolean[layers.size()];
             numLayers = layers.size();
             for(int i=0; i<numLayers; i++)
               {
                 isVisible[i] = true;
               }
               RenderTravles = false;
           }
         PShape out = createShape(GROUP);
         int i=0;
         for(Layer curLayer: layers)
           {
             if(isVisible[i])
               {
                 float Height = curLayer.getHeight();
                 for(Line curLine: curLayer.getCoordinates())
                   {
                     if(curLine.getIsTravle())
                       {
                         out.addChild(DrawCylinder(curLine, .2, Height));
                       }
                     else
                       {
                         //TODO implment function to render travle lines
                       }
                   }
               }         
           }
         return out;
       }
    
    
    
     private PShape DrawCylinder(Line path, float LayerHeight, float currentHeight)
       {
         PShape out = createShape();

        
         int sides = 20;
         float angle = 360 / sides;
         float[] temp = path.getPoints();
         float halfHeight =  sqrt(sq(temp[0]-temp[2]) + sq(temp[1]-temp[3]));

          // draw top of the tube
          out.beginShape();
          for (int i = 0; i < sides; i++) 
            {
              float x = cos( radians( i * angle ) ) * LayerHeight;
              float y = sin( radians( i * angle ) ) * LayerHeight;
              out.vertex( x, y, 0);
            }
          out.endShape(CLOSE);

          // draw bottom of the tube
          out.beginShape();
          for (int i = 0; i < sides; i++)
            {
              float x = cos( radians( i * angle ) ) * LayerHeight;
              float y = sin( radians( i * angle ) ) * LayerHeight;
              out.vertex( x, y, halfHeight);
            }
          out.endShape(CLOSE);
    
          // draw sides
          out.beginShape(TRIANGLE_STRIP);
          for (int i = 0; i < sides + 1; i++) 
            {
              float x = cos( radians( i * angle ) ) * LayerHeight;
              float y = sin( radians( i * angle ) ) * LayerHeight;
              out.vertex( x, y, halfHeight);
              out.vertex( x, y, 0);    
            }
          out.endShape(CLOSE);
          
          out.rotateY(radians(90));
          
          PVector placA = new PVector(temp[2] - temp[0], temp[3] - temp[1]);
          
          out.rotateZ(PVector.angleBetween(new PVector(0,1), placA));
          
          out.translate(temp[1], temp[0], currentHeight);
          return out;
       } 
       
  }