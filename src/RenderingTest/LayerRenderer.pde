/*
LayerRenderer.pde
 
This Sketchbook tab holds the definition and implementation of the Layer Renderer class.
 
the Layer Renderer class is an implintaion of the Renderer interface for rendering a simulation of a GCode file

it contines methods to controle the visability of indvidule layers and weather or not to render the lines when the printer is not exdruding 


 
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
         float LayerHeight = Subject.getLayerHeight();
         for(Layer curLayer: layers)
           {
             if(isVisible[i])
               {
                 float Height = curLayer.getHeight();
                 ArrayList<Line> temp = curLayer.getCoordinates();
                 for(Line curLine: temp)
                   {
                     if(!curLine.getIsTravle())
                       {
                        out.addChild(DrawCylinder(curLine, LayerHeight, Height));
                       }
                     else
                       {
                         out.addChild(drawLine(curLine, Height));
                       }
                   }
               } 
               i++;
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
       
       private PShape drawLine(Line path, float Height)
         {
           PShape out = createShape();
           float[] temp = path.getPoints();
           out.beginShape(LINE);
           out.vertex(temp[0], temp[1], Height);
           out.vertex(temp[2], temp[3], Height);
           out.endShape(CLOSE);
           return out;
         }
       
  }