// The idea to use the lines array with numbers intead of material names inside the project was referenced from AI as I did not have success trying to parse an external .txt file with material names

int cols = 6;
int rows;
int[][] grid;

int margin = 20;
int gap = 2;
float cellSize;

// Color palette array to prevent lots of repeating code and replace it with palette[colour index 0-5]
color[] palette = {
  color(156, 102, 31),   // 0 Wood - brown
  color(180, 180, 180),  // 1 Metal - gray
  color(135, 206, 235),  // 2 Glass - blue
  color(199, 21, 133),   // 3 Fabric -magenta
  color(255, 165, 0),    // 4 Plastic- orange
  color(112, 128, 144)   // 5 Stone - darker gray
};

// Materials collected turned into coresponding number, this way it is much easier to parse the data and make it usable for display without the use of external .txt files
String[] lines = {
  "0,1,2,3,4,5",
  "0,1,3,4,2,5",
  "0,1,4,3,2,5",
  "0,1,2,4,3,5",
  "1,0,3,2,5,4",
  "0,1,4,2,3,5",
  "1,0,2,3,4,5",
  "0,1,2,4,5,3",
  "0,1,2,4,3,5",
  "0,1,2,3,4,5",
  "1,0,2,3,4,5",
  "0,1,4,3,2,5",
  "1,0,3,2,5,4",
  "0,1,2,4,3,5",
  "0,1,4,3,2,5",
  "0,1,2,4,3,5",
  "0,1,4,2,3,5",
  "0,1,2,3,4,5",
  "0,3,2,1,4,5",
  "1,0,2,3,5,4"
};

void setup() {
  size(900, 700);
  
  rows = lines.length;
  grid = new int[rows][cols];

  // Remove any commas or spacs from the lines array to be able to only work with the numbers
  for (int i = 0; i < rows; i++) {
    String[] tokens = split(trim(lines[i].replace(',', ' ')), ' ');
    int num = min(cols, tokens.length);
    for (int j = 0; j < num; j++) {
      grid[i][j] = int(tokens[j]);
    }
    for (int j = num; j < cols; j++) {
      grid[i][j] = 0;
    }
  }
  
  cellSize = min(
    (width  - 2*margin - (rows - 1) * gap) / (float) rows,
    (height - 2*margin - (cols - 1) * gap) / (float) cols
  );
}

void draw() {
  
  background(250);
  noStroke();

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      float x = margin + i * (cellSize + gap);
      float y = 300 + margin + j * (cellSize + gap); 
      int idx = grid[i][j];                    
      fill(palette[idx]);                      
      rect(x, y, cellSize, cellSize);      
    }
  }
  
  drawLegend();
}

void drawLegend() {
  // New names array to loop through instead of positioning each label individually
  String[] names = {"Wood", "Metal", "Glass", "Fabric", "Plastic", "Stone"};
  int boxSize = 40;
  
  // Positions the legend horizontally in the middle of the screen on top of the squares 
  int startX = width / 16;
  int startY = height / 4;
  int spacing = 140;

  textSize(20);
  textAlign(LEFT, CENTER);

  for (int i = 0; i < names.length; i++) {
    fill(palette[i]);
    rect(startX + i * spacing, startY, boxSize, boxSize);
    fill(0);
    text(names[i], startX + i * spacing + boxSize + 10, startY + boxSize / 2);
  }
  
  // Description of the data display (not needed as I just found out)
  //text("Each column shows 6 different materials that were in contact throughout the day. \nThe higher the material is in the column, \nthe more often it was in contact with during that day.", 100, 80);
}
