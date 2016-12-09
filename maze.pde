final color SKY_COLOR = #adccff;
final color WALL_COLOR = #c43f38;
final color GROUND_COLOR = #89ff93;
final color WATER_COLOR = #325fff;
final color TREE_COLOR = #3a8725;

final float CASE_SIZE = 10;  // size of one case

char[][] map;  // loaded map

void setup() {
  size(1000, 600, P3D);
  
  /* Load map from file */
  final String[] lines = loadStrings("default.map");
  
  map = new char[lines.length][lines[0].length()];
  
  for (int row = 0; row < lines.length; row++) {
    for (int col = 0; col < lines[row].length(); col++) {
      map[row][col] = lines[row].charAt(col);
    }
  }
  
  printArray(map);
}

void draw() {
  
  /* Clear & translate */
  background(SKY_COLOR);
  translate(width / 2, height / 2, 0);
  
  /* Position camera */
  // TODO: remove it later
  final float camPosX = cos(map(mouseX, 0, width, -PI, 0)) * 200;
  final float camPosY = sin(map(mouseY, 0, height, -PI, PI)) * 200;
  final float camPosZ = cos(map(mouseY, 0, height, -PI, PI)) * 200;
  
  camera(
    camPosX, camPosY, camPosZ,
    0, 0, 0,
    0, 1, 0);
  
  /* Draw map */
  for (int row = 0; row < map.length; row++) {
    pushMatrix();
    translate(0, 0, row * CASE_SIZE);
    
    for (int col = 0; col < map[row].length; col++) {
      pushMatrix();
      translate(col * CASE_SIZE, 0, 0);
      
      switch (map[row][col]) {
        case '#':
          drawWall();
          break;
        case '$':
          drawTree();
          break;
        case '~':
          drawWater();
          break;
        default:
          drawGround();
      }

      popMatrix();
    }
    
    popMatrix();
  }
}

/**
 * Draws wall in current case.
 */
void drawWall() {
  fill(WALL_COLOR);
  drawBox();
  noFill();
}

/**
 * Draws tree in current case.
 */
void drawTree() {
  drawGround();
  
  fill(TREE_COLOR);
  drawSphere();
  noFill();
}

/**
 * Draws ground in current case.
 */
void drawGround() {
  fill(GROUND_COLOR);
  drawRect();
  noFill();
}

/**
 * Draws water in current case.
 */
void drawWater() {
  fill(WATER_COLOR);
  drawRect();
  noFill();
}

/**
 * Draws rectangle in current case.
 */
void drawRect() {
  beginShape(QUADS);
  vertex(0, 0, 0);
  vertex(CASE_SIZE, 0, 0);
  vertex(CASE_SIZE, 0, CASE_SIZE);
  vertex(0, 0, CASE_SIZE);
  endShape();
}

/**
 * Draws box in current case.
 */
void drawBox() {
  pushMatrix();
  translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2);
  box(CASE_SIZE);
  popMatrix();
}

/**
 * Draws sphere in current case.
 */
void drawSphere() {
  pushMatrix();
  translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2);
  sphere(CASE_SIZE / 2);
  popMatrix();
}