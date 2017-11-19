/*
SlicerProject.pde

This Sketchbook tab contains the main code that runs the entire program. 

For more information, view the accompanying READMEs located throughout the project. 

Authors:
*/

//This function is automatically called when the project is run/executed.
// Once this function finished executing, the draw function is called (repeatedly).

PGraphics rendering;
RenderControler vis;
boolean realsed = true;

int last;

void setup() {
  size(800, 800, P3D);
  vis = new RenderControler(100,100,100);
  rendering = createGraphics(300, 300, P3D);
  vis.RenderBuildSpace(rendering);
  vis.RenderBuildSpace(rendering);
}

//After the setup function finishes, this function is called repeatedly until the
// program exits.
//Depending on how the project proceeds, we may not use this function, and instead
// treat the setup function as if it were similar to a main function in C/C++/Java.
void draw() {
  
  if(!realsed && !mousePressed)
    {
      POV temp = vis.getPOV();
      temp.Rotate(new PVector(last - mouseX,0,0));
      vis.SetPOV(temp);
      vis.RenderBuildSpace(rendering);
      realsed = true;
    }
  else if(mousePressed && realsed)
    {
      realsed = false;
      last = mouseX;
    }
    else{
      
    }
  
  image(rendering, 10 ,10);
}