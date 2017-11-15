class Layer {
  
  private float zHeight;
  private final int id;
  private static int nextid = 0;
  private int numlines;
  
  // Should this variable have an access specifier (e.g public, private)?
  // This variable is called lines in the Slicer group's implementation
  ArrayList<Line> toolPath;
  
  public Layer(float zHeight) {
    this.zHeight = zHeight;
  }
  
  // Alternative constructor to match one found in the Slicer group's
  // implementation
  public Layer(ArrayList<Line> importLines, float inputZHeight) {
      setCoordinates(importLines);
      this.zHeight = zHeight;
  }
  
  // Default constructor added for compatibility with Slicer group
  // implementation
  
  public Layer() {
    this.zHeight = 0;
  }
  
  
  
  
  public void setToolPath(ArrayList<Line> path, int numlines) {
    this.toolPath = path;
    this.numlines = numlines;
    this.id = nextid++;
  }
  
  public void setHeight(float height) {
    this.zHeight = height;
  }
  
  public bool checkContinuity() {
    // Not yet implemented
  }
  
  public ArrayList<Line> getToolPath() {
    return this.toolPath;
  }

  // Alias to getToolPath, for compatibility with slicer group
  // implementation; either this method or getToolPath should be
  // removed later on, once a consistent name is chosen.  
  public ArrayList<Line> getCoordinates() {
    return this.toolPath;
  }
  
  // Method from the slicer group's implementation, our implemetation
  // seems to use setToolPath for the equivalent functionality.
  public void setCoordinates(ArrayList<Line> newLineList) {
    // Clear out old line segments
    toolPath.clear();
    // Copy line segments from newLineList to toolPath
    for (Line newline : newLineList) {
      toolPath.add(new Line(newline.x1, newline.y1, newline.x2, newline.y2, newline.isTravel));
    }
  }
  
  public int getNumLines() {
    return this.numlines;
  }
  
  public int getId() {
    return this.id;
  }
  
  public float getHeight() {
    return this.zHeight;
  }
}