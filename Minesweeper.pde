
import de.bezier.guido.*;
private final static int NUM_ROWS =20;
private final static int NUM_COLS =20;
private final static int NUM_MINES=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs =new ArrayList<MSButton>();
private boolean gameOver=false;
  
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r=0; r<NUM_ROWS; r++){

        for(int c=0; c<NUM_COLS; c++){

            buttons[r][c]= new MSButton(r,c);
        }
    }
    
    
    
    setBombs();
}
public void setBombs()
{
   int row,col;

    while (bombs.size() < NUM_MINES+1) {

     row = (int)(Math.random()*20);
     col = (int)(Math.random()*20);

     if(!bombs.contains(buttons[row][col])){

      bombs.add(buttons[row][col]);
     
   }
  
}
  

}

public void draw ()
{
    background( 0 );
    if(isWon()){
        displayWinningMessage();
    }
}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(bombs.contains(buttons[r][c]) && !buttons[r][c].isMarked())
                return false;
        }
    } 
    return true; 
}
public void displayLosingMessage()
{


    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c].setLabel("L");

           if(bombs.contains(buttons[r][c])&&!buttons[r][c].isClicked())
            {
                buttons[r][c].mousePressed();
                
            }
            
         }
    }


}
public void displayWinningMessage()
{


    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c].setLabel("W");
        }
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
  
    public void mousePressed () 
    {
        
          if(gameOver==true){
            return;
           }


          clicked = true;

           
           if(keyPressed==true){
            marked=!marked;
            }
            else if(isWon()==true){
                displayWinningMessage();
            }
            else if(bombs.contains(this)){

                 displayLosingMessage();
                 gameOver=true;

             }
              

            else if(countBombs(r,c)>0){

                setLabel(""+countBombs(r,c));

                  }

            else{ 

                if(isValid(r-1,c)==true&&buttons[r-1][c].isClicked()==false){

                    buttons[r-1][c].mousePressed();
                }

                if(isValid(r+1,c)==true&&buttons[r+1][c].isClicked()==false){

                    buttons[r+1][c].mousePressed();
                 }

                if(isValid(r,c-1)==true&&buttons[r][c-1].isClicked()==false){

                   buttons[r][c-1].mousePressed();
                 }

                if(isValid(r,c+1)==true&&buttons[r][c+1].isClicked()==false){

                    buttons[r][c+1].mousePressed();
                        }

                if(isValid(r+1,c-1)==true&&buttons[r+1][c-1].isClicked()==false){

                    buttons[r+1][c-1].mousePressed();
                }

                if(isValid(r+1,c+1)==true&&buttons[r+1][c+1].isClicked()==false){

                    buttons[r+1][c+1].mousePressed();
                }

                if(isValid(r-1,c-1)==true&&buttons[r-1][c-1].isClicked()==false){

                    buttons[r-1][c-1].mousePressed();
                }

                if(isValid(r-1,c+1)==true&&buttons[r-1][c+1].isClicked()==false){

                    buttons[r-1][c+1].mousePressed();
                }

            }

                       
                   
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(100);

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<NUM_ROWS&&c<NUM_COLS&&r>-1&&c>-1){
          return true;  
        }
        else{return false;}
        
    }
    public int countBombs(int r, int c)
    {
        int numBombs = 0;
       
        if(isValid(r-1,c)&& bombs.contains(buttons[r-1][c])){

            numBombs++;
        }

         if(isValid(r+1,c)&& bombs.contains(buttons[r+1][c])){

            numBombs++;
        }

         if(isValid(r,c-1)&& bombs.contains(buttons[r][c-1])){

            numBombs++;
        }

         if(isValid(r,c+1)&& bombs.contains(buttons[r][c+1])){

            numBombs++;
        }

         if(isValid(r-1,c-1)&& bombs.contains(buttons[r-1][c-1])){

            numBombs++;
        }

         if(isValid(r-1,c+1)&& bombs.contains(buttons[r-1][c+1])){

            numBombs++;
        }

         if(isValid(r+1,c-1)&& bombs.contains(buttons[r+1][c-1])){

            numBombs++;
        }

         if(isValid(r+1,c+1)&& bombs.contains(buttons[r+1][c+1])){

            numBombs++;
        }

        return numBombs;
    }
}



