void setup()
{
  size(500, 500);
  
  loadData();
  calculateSums();
  println(sums);
}

ArrayList<ArrayList<Float>> data = new ArrayList<ArrayList<Float>>();


ArrayList<Float> sums = new ArrayList<Float>();


void calculateSums()
{
  for(ArrayList<Float> lineData:data)
  {
    float sum = 0;
    for (float f:lineData)
    {
      sum += f;
    }
    sums.add(sum);
  }
}

void drawTrendLineGraph(ArrayList<Float> data, String title)
{
  background(0);
  float border = width * 0.1f;
  // Print the text 
   textAlign(CENTER, CENTER);   
   float textY = (border * 0.5f); 
   text("Yearly Important Descoveries 1860 - 1959 Trend Graph", width * 0.5f, textY);
   
  drawAxis(data, 10, 10, 15, border);   
  float windowRange = (width - (border * 2.0f));
  float dataRange = 15;      
  float lineWidth =  windowRange / (float) (data.size() - 1) ;
  
  stroke(0, 255, 255);
  for (int i = 1 ; i < data.size() ; i ++)
  {
    float x1 = map(i - 1, 0, data.size(), border, border + windowRange);
    float x2 = map(i, 0, data.size(), border, border + windowRange);
    float y1 = map(data.get(i - 1), 0, dataRange, height - border, (height - border) - windowRange);
    float y2 = map(data.get(i), 0, dataRange, height - border, (height - border) - windowRange);
    line(x1, y1, x2, y2);
  }  
}

void drawAxis(ArrayList<Float> data, int horizIntervals, int verticalIntervals, float vertDataRange, float border)
{
  stroke(200, 200, 200);
  fill(200, 200, 200);  
  
  // Draw the horizontal azis  
  line(border, height - border, width - border, height - border);
  
  float windowRange = (width - (border * 2.0f));  
  float tickSize = border * 0.1f;
      
  for (int i = 0 ; i <= horizIntervals ; i ++)
  {   
   // Draw the ticks
   float x = map(i, 0, horizIntervals, border, border + windowRange);
   line(x, height - (border - tickSize), x, (height - border));    
   textAlign(CENTER, CENTER);   
   float textY = height - (border * 0.5f); 
   text((int) map(i, 0, horizIntervals, 1980, 2012), x, textY);
   
  } 
  
  // Draw the vertical axis
  line(border, border , border, height - border);
  
  for (int i = 0 ; i <= verticalIntervals ; i ++)
  {
    float y = map(i, 0, verticalIntervals, height - border,  border);
    line(border - tickSize, y, border, y);
    float hAxisLabel = map(i, 0, verticalIntervals, 0, vertDataRange);
        
    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - (tickSize * 2.0f), y);
  }    
}

int[] angles = {35, 60, 54, 36, 28, 8, 12, 10, 9, 14, 46};

void drawPiechart(float diameter, int[] data) 
{
  background(0);
  float border = width * 0.1f;
  textAlign(CENTER, CENTER);   
  float textY = (border * 0.5f); 
  text("Yearly Important Descoveries 1860 - 1959 Bar Chart", width * 0.5f, textY);
  
  float lastAngle = 0;
  for (int i = 0; i < data.length; i++) 
  {
    float gray = map(i, 0, data.length, 255, 0);
    fill(gray);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
    lastAngle += radians(angles[i]);
  }
}


float range = 800.0f;
float theta = 0;
float thetaInc;
float speed = 200.0f;
int which = 0;
void draw()
{
  background(0);
  textAlign(CENTER, CENTER);   
  text("To view recorded data about the amount of important discoveries made per year,\n please click one for the line graph data or two for the pie hcart data.", width/2 , height / 2);
    if(keyPressed)
  {
    if (key == '1')
    {
      which = 1;
    }
    if (key == '2')
    {
      which = 2;
    }
  }
   if (which == 1)
  {
   drawTrendLineGraph(sums, "1980");
  }
  else if(which == 2)
  {
    drawPiechart(300, angles);
  }
    fill(255, 0, 0);
    translate(450,30);
    rotate(sin(theta) * radians(range));
    ellipse(10, 10, 10, 10);    
    theta += (PI / speed);
  
}



  


void loadData()
{
  String[] strings = loadStrings("discoveries.csv");
  
  for(String s:strings)
  {
    println(s);
    String[] line = s.split(",");
    
    ArrayList<Float> lineData = new ArrayList<Float>();
    
    // Start at 1, so we skip the first one 
    for (int i = 1 ; i < line.length ; i ++)
    {
      lineData.add(Float.parseFloat(line[i]));              
    }
    data.add(lineData);
  }
}
