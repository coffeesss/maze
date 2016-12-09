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
          translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2);
          fill(WALL_COLOR);
          box(CASE_SIZE);
          noFill();
          break;
        case '$':
          fill(GROUND_COLOR);
          beginShape(QUADS);
          vertex(0, 0, 0);
          vertex(CASE_SIZE, 0, 0);
          vertex(CASE_SIZE, 0, CASE_SIZE);
          vertex(0, 0, CASE_SIZE);
          endShape();
          noFill();
          
          translate(CASE_SIZE / 2, -CASE_SIZE / 2, CASE_SIZE / 2);
          fill(TREE_COLOR);
          sphere(CASE_SIZE / 2);
          noFill();
          break;
        case '~':
          fill(WATER_COLOR);
          beginShape(QUADS);
          vertex(0, 0, 0);
          vertex(CASE_SIZE, 0, 0);
          vertex(CASE_SIZE, 0, CASE_SIZE);
          vertex(0, 0, CASE_SIZE);
          endShape();
          noFill();
          break;
        default:
          fill(GROUND_COLOR);
          beginShape(QUADS);
          vertex(0, 0, 0);
          vertex(CASE_SIZE, 0, 0);
          vertex(CASE_SIZE, 0, CASE_SIZE);
          vertex(0, 0, CASE_SIZE);
          endShape();
          noFill();
      }

      popMatrix();
    }
    
    popMatrix();
  }
}