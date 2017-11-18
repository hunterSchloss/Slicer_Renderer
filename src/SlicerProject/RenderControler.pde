/*
RenderControler.pde
This Sketchbook tab holds the definition and implementation of the RenderControler class.
The RenderControler class is used to coridinate all build space related rendering durring operation
it contains functions for rendering the build space and either STL or G-Code models
 
Authors: Rendering Team (Hunter Schloss)
*/


public class RenderControler
  {
    private PVector TopLeft;
    private PVector BottomRight;
    
    private float   Width;
    private float   Length;
    private float   Height;
    
    private POV     Camera;
    
    private boolean RenderFacets;
    
    
    
    
    public RenderControler(Pvector TL, PVector BR, float W, float L, float H)
      {
        TopLeft = TL;
        BottomRight = BR;
        Width = W;
        Length = L;
        Height = H
        
        RenderFacets = true;
        
        ResetCamera();
        RenderBuildSpace();
      }
     
    public void Render(Model Subject)
      {
        if(RenderFacets)
          {
            if(subject.getIsModified())
              {
                RenderBuildSpace();
                Subject.slice();
              }
            LayerRenderer().Render(Subect);
          }
        else
          {
            FacetRenderer().Render(Subject);
          }
          
      }
  
    public void RenderBuildSpace()
      {
        //TODO render Translucint Gray walls and ceilling as well as an opaque floor
      }
  
    public void ResetCamera()
      {
        //TODO decided where the camera should start
      }
      
  
    public PVector[] getFrame()
      {
        Pvector[] temp;
        temp[0] = TopLeft;
        temp[1] = BottomRight;
        return temp;
      }
  
    public void setFrame(Pvector TL, PVector BR)
      {
        TopLeft = TL;
        BottomRight = BR;
      }
  
    public float[] getDim()
      {
        float[] temp;
        temp[0] = Width;
        temp[1] = Length;
        temp[2] = Height;
        return temp
      }
  
    public void setDim(float w, float l, float h)
      {
        Width = w;
        Length = l
        Height = h;
      }
      
    public void SetMode(boolean mode)
      {
        RenderMode = mode;
      }
  }
