import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 50;
public final static int NUM_COL = 50;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(1000, 500);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new Life[NUM_ROWS][NUM_COL]; 
  for(int i = 0; i < NUM_ROWS; i++){
     for(int j = 0; j < NUM_COL; j++){
       buttons[i][j] = new Life(i,j);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COL];
   for(int i= 0; i < NUM_ROWS; i++) {
    for(int j = 0; j < NUM_COL; j++) {
      buffer[i][j] = buttons[i][j].getLife();
    }
  }
}

public void draw () {
  background( 0 );
  if(running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
   for(int i = 0; i < NUM_ROWS; i++){
     for(int j = 0;j < NUM_COL; j++){
       if(countNeighbors(i,j) == 3) {
       buffer[i][j]=true;
       } 
       else if((countNeighbors(i,j)== 2) && (buttons[i][j].getLife())) {
         buffer[i][j]=true;;
       }
       else {
       buffer[i][j]=false;;
       }
       buttons[i][j].draw(); 
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if(key == 'p'){
    running = !running;
  }
}

public void copyFromBufferToButtons() {
   for(int i = 0; i < NUM_ROWS; i++){
     for(int j = 0; j < NUM_COL;j++){
       if( buffer[i][j]==true){
       buttons[i][j].setLife(true);
    }
    else { buttons[i][j].setLife(false);}
    }
  }
}

public void copyFromButtonsToBuffer() {
    for(int i = 0; i < NUM_ROWS; i++){
     for(int j = 0;j < NUM_COL;j++){
       buffer[i][j]=buttons[i][j].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if((r >=0) && (r < NUM_ROWS) && (c >=0) && (c < NUM_COL)) {
  return(true);
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  if((isValid(row-1,col)==true)&& (buttons[row-1][col]).getLife()==true) {
  neighbors++;
  }
  if((isValid(row-1,col-1)==true)&& (buttons[row-1][col-1]).getLife()==true) {
  neighbors++;
  }
  if((isValid(row-1,col+1)==true)&& (buttons[row-1][col+1]).getLife()==true) {
  neighbors++;
  }
  if((isValid(row,col+1)==true)&& (buttons[row][col+1]).getLife()==true) {
  neighbors++;
  }
  if((isValid(row,col-1)==true)&& (buttons[row][col-1]).getLife()==true) {
  neighbors++;
  }
  if((isValid(row+1,col)==true)&& (buttons[row+1][col]).getLife()==true) {
  neighbors++;
  }
  if((isValid(row+1,col-1)==true)&& (buttons[row+1][col-1]).getLife()==true) {
  neighbors++;
  }
  if((isValid(row+1,col+1)==true)&& (buttons[row+1][col+1]).getLife()==true) {
  neighbors++;
  }
  
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 1000/NUM_COL;
    height = 500/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if(alive != true)
      fill(0);
    else 
      fill(150);
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return(alive);
    //return false;
  }
  public void setLife(boolean living) {
    if(living==true) {
    alive=true;
    }
    else {
    alive=false;
    }
  }
}
