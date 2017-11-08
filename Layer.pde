class Layer {
  
  private float zHeight;
  private final int id;
  private static int nextid = 0;
  private int numlines;
  ArrayList<Line> toolPath;
  
  public Layer(float zHeight) {
    this.zHeight = zHeight;
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