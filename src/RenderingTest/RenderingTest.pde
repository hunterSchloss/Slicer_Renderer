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
int i=0;
int j=0;

Model test;

int last;

void setup() {
  size(800, 800, P3D);
  rendering = createGraphics(700, 700, P3D);
  
  vis = new RenderControler(100,100,100);
  vis.ResetCamera();
  
  String adress = "../../40mmcube.stl";
  STLParser parser = new STLParser(adress);
  ArrayList<Facet> data = parser.parseSTL();
  test = new Model(data, .1, .1);
  
  //vis.Render(test, rendering);
  //image(rendering, 50 ,50);
  
}

//After the setup function finishes, this function is called repeatedly until the
// program exits.
//Depending on how the project proceeds, we may not use this function, and instead
// treat the setup function as if it were similar to a main function in C/C++/Java.
void draw() {
    // One and ONLY one of these function calls should be uncommented
    
    
   // modelTranslationTest(); // Seems to work
    
    //modelScalingTest(); // Seems to work
    
    rotationTest(); // Z axis rotation isn't correct
    
    //testLayerRenderer();
    testFacetRenderer();

}



void testLayerRenderer()
  {
    ArrayList<Line> testLayerRenderer = new ArrayList<Line>();
    testLayerRenderer.add(new Line(1, 1, 10, 10, false));
    testLayerRenderer.add(new Line(10, 10, 20, 15, false));
    testLayerRenderer.add(new Line(20, 15, 30, 10, false));
    testLayerRenderer.add(new Line(30, 10, 25, 5, false));
    testLayerRenderer.add(new Line(25, 5, 20, 10, false));
    testLayerRenderer.add(new Line(20, 10, 10, 5, false));
    ArrayList<Layer> temp = new ArrayList<Layer>();
    temp.add(new Layer(testLayerRenderer, 10));
    test.TestSetLayers(temp);
    vis.SetMode(false);
    vis.testLayerRenderer(test, rendering);
    
    image(rendering, 50 ,50);
    
  }
  
void testFacetRenderer()
  {
    vis.SetMode(true);
    vis.Render(test, rendering);
    image(rendering, 50 ,50);
    
  }


PVector GetPoint(int n, int k, float radius, PVector center, PVector angle)
       {
         PVector point = new PVector(center.x + radius*sin(radians((360/k)*n)), center.y, center.z + radius*cos(radians((360/k)*n))); //caculate point of the curcil to return
         PVector axisIntercept = new PVector();
         float radiusOfRotation;
         
         //rotate around the x axis
         axisIntercept.set(new PVector(point.x, point.y, center.z));
         radiusOfRotation = abs(PVector.dist(axisIntercept, point));
         point.y = point.y + radiusOfRotation * sin(angle.x);
         point.z =  center.z + radiusOfRotation * cos(angle.x);
         
         //roate around the y axis 
         axisIntercept.set(new PVector(center.x, point.y, center.z));
         radiusOfRotation = abs(PVector.dist(axisIntercept, point));
         point.x = point.y + radiusOfRotation * sin(angle.y);
         point.z =  center.z + radiusOfRotation * cos(angle.y);
         
         //roate around the z axis 
         axisIntercept.set(new PVector(center.x, center.y, point.z));
         radiusOfRotation = abs(PVector.dist(axisIntercept, point));
         point.x = center.x + radiusOfRotation * sin(angle.z);
         point.y =  center.y + radiusOfRotation * cos(angle.z);
         
         return point;
         
         
       }




void modelTranslationTest()
  {
    if(mousePressed)
    {
      test.Translate(1,1);
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
    }
    else
      {
      test.Translate(-1,-1);
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
      }
  }

void modelScalingTest()
  {
    if(mousePressed)
    {
      test.Scale(new PVector(1.01,1.01, 1.01));
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
    }
    else
      {
      test.Scale(new PVector(.99, .99, .99));
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
      }
  }



void modelRotationTest()
{
  if (mousePressed) {
    test.Rotate(5.0, 0);
  } else {
    test.Rotate(0, 5.0);
  }
  
  vis.Render(test, rendering);
  image(rendering, 50, 50);
}

void rotationTest()
  {
    if(mousePressed)
    {
      POV temp = vis.getPOV();
      temp.Rotate(1, 0);
      vis.SetPOV(temp);
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
    }
    else
      {
        POV temp = vis.getPOV();
      temp.Rotate(0, 1);
      vis.SetPOV(temp);
      vis.Render(test, rendering);
      image(rendering, 50 ,50);
      }
      
  }
    