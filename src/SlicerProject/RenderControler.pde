/*
RenderControler.pde
This Sketchbook tab holds the definition and implementation of the RenderControler class.
The RenderControler class is used to coridinate to preform all rendering od the model and the build space

 
Authors: Rendering Team (Hunter Schloss)
*/


public class RenderControler
  {    
    private float   Width;
    private float   Length;
    private float   Height;
    
    private POV     Camera;
    
    private Renderer Visualizer;
    
    private boolean RenderFacets;
    
    
    
    
    public RenderControler(float W, float L, float H)
      {
        Width = W;
        Length = L;
        Height = H;
        
        RenderFacets = true;
        
        ResetCamera();
      }
     
    public PGraphics Render(Model Subject, PGraphics frame)
      {
        frame.beginCamera();
        Camera.setCamera(frame);
        frame = addBuildSpace(frame);
        if(Subject.isModified() && !RenderFacets)
          {
            Subject.Slice();
          }
        frame = Visualizer.Render(frame, Subject);
        return frame;
      }
  
    public PGraphics RenderBuildSpace(PGraphics frame)
      {
        frame.beginCamera();
        frame = Camera.setCamera(frame);
        frame = addBuildSpace(frame);
        return frame;
        
      }
      
    private PGraphics addBuildSpace (PGraphics frame)
      {
         frame.fill(153);
         frame.tint(255, 32);
         
         
         //front wall
         frame.beginShape();
         frame.vertex(0, 0, 0);
         frame.vertex(0, 0, Height);
         frame.vertex(Width, 0, Height);
         frame.vertex(Width, 0, 0);
         frame.endShape();
         
         //left wall
         frame.beginShape();
         frame.vertex(0, 0, 0);
         frame.vertex(0, 0, Height);
         frame.vertex(0, Length, Height);
         frame.vertex(0, Length, 0);
         frame.endShape();
         
         //right wall
         frame.beginShape();
         frame.vertex(Width, 0, 0);
         frame.vertex(Width, 0, Height);
         frame.vertex(Width, Length, Height);
         frame.vertex(Width, Length, 0);
         frame.endShape();
         
         //back wall
         frame.beginShape();
         frame.vertex(0, Length, 0);
         frame.vertex(0, Length, Height);
         frame.vertex(Width, Length, Height);
         frame.vertex(Width, Length, 0);
         frame.endShape();
         
         //floor
         frame.tint(255, 255);
         frame.beginShape();
         frame.vertex(0, 0, 0);
         frame.vertex(0, Length, 0);
         frame.vertex(Width, Length, 0);
         frame.vertex(Width, 0, 0);
         frame.endShape();
         
         return frame; 
      }
  
    public void ResetCamera()
      {
        //TODO deceied where camera starts Camera.setpos();
        //TODO deceied where focus startsCamera.setFocus(); 
        Camera.setUp(new PVector(1,1,1));
      }
     
    public void FocusOnModel(Model Subject)
      {
        Camera.setFocus(Subject.getCenter());
      }
  
    public float[] getDim()
      {
        float[] temp = new float[3];
        temp[0] = Width;
        temp[1] = Length;
        temp[2] = Height;
        return temp;
      }
  
    public void setDim(float w, float l, float h)
      {
        Width = w;
        Length = l;
        Height = h;
      }
      
    public void SetMode(boolean mode)
      {
        if(mode != RenderFacets)
          {
            RenderFacets = mode;
            if(RenderFacets)
              {
                Visualizer = new FacetRenderer();
              }
            else
              {
                //Visualizer = new LayerRendrer();
              }            
          }
      }
  }