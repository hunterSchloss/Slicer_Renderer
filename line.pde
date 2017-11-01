
void setup()
{
}

void draw()
{
  println("Hello World");
}

class Point
{
  float x;
  float y;
}

class Line
{
  Point p1;
  Point p2;
  
  Boolean Travel;
  
  ArrayList<Point> getCoordinates()
  {
    ArrayList<Point> l1 = new ArrayList<Point>();
    l1.add(p1);
    l1.add(p2);
    
    return l1;
  }
  
  Boolean getType()
  {
    return Travel;
  }
  
}


