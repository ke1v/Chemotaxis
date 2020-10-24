import java.util.Arrays;

void expandArray(Object) {

}

Bacteria[] bacteriaArray = new Bacteria[1];
Food[] foodArray = new Food[1];

int signum(int num) {
    return (num > 0) ? 1 : ((num < 0) ? -1 : 0);
}

void setup(){
    size(700, 700);
	background(135, 206, 235);
	for (int i = 0; i < bacteriaArray.length; i++) {
		bacteriaArray[i] = new Bacteria();
	}
	for (int i = 0; i < foodArray.length; i++) {
		foodArray[i] = new Food();
	}
}

void draw() {
	background(105, 176, 205);
	for (int i = 0; i < bacteriaArray.length; i++) {
		if (bacteriaArray[i] == null) continue;
		//Breaking apart if double init. size
		if (bacteriaArray[i].size >= 30) {
			bacteriaArray[i].size = 10;
	    	//Creating another Bacteria
	    	for (int j = 0; j < bacteriaArray.length; j++) {
	    		//Check if element is empty
	    		if (bacteriaArray[j] == null) {
	    			//Add food to pos i
	    			bacteriaArray[j] = new Bacteria(bacteriaArray[i].x, bacteriaArray[i].y);
	    			break;
	    		}
    		    //Last iteration of loop & still no space -> expand array
        		if (j == bacteriaArray.length-1) {
        			//Expand array
        			Bacteria newArray[] = new Bacteria[bacteriaArray.length];
        			for (int k = 0; k < newArray.length; k++) {
        				newArray[k] = bacteriaArray[k];
        			}
        			bacteriaArray = new Bacteria[newArray.length * 2];
        			for (int k = 0; k < newArray.length; k++) {
        				bacteriaArray[k] = newArray[k];
        			}
        		}
	    	}
		}
		bacteriaArray[i].move();
		bacteriaArray[i].show();
	}
	for (int i = 0; i < foodArray.length; i++) {
		if (foodArray[i] != null) {
			foodArray[i].show();
		}
	}
}

void mousePressed() {
	//Creating another food
	for (int i = 0; i < foodArray.length; i++) {
		//Check if element is empty
		if (foodArray[i] == null) {
			//Add food to pos i
			foodArray[i] = new Food(mouseX, mouseY);
			break;
		}
		//Last iteration of loop & still no space -> expand array
		//Last iteration of loop & still no space -> expand array
		if (i == foodArray.length-1) {
			//Expand array
			Food newArray[] = new Food[foodArray.length];
			for (int k = 0; k < newArray.length; k++) {
				newArray[k] = foodArray[k];
			}
			foodArray = new Food[newArray.length * 2];
			for (int k = 0; k < newArray.length; k++) {
				foodArray[k] = newArray[k];
			}
		}
	}
}

class Food {
	
	int x, y;
	int size = 5;
	
	Food() {
		x = (int) (Math.random() * 625) + 25;
		y = (int) (Math.random() * 625) + 25;
	}
	
	Food(int x, int y) {
		this.x = x;
		this.y = y;
	}
	
	void show() {
		stroke(1);
		fill(255);
		ellipse(x, y, size, size);
	}
	
}

class Bacteria {
	
	int x, y, color, size = 10;
	
	Bacteria() {
		x = (int) (Math.random() * 700);
		y = (int) (Math.random() * 700);
		color = (int) (Math.random() * 100) + 100;
	}
	
	Bacteria(int x, int y) {
		this.x = x;
		this.y = y;
		color = (int) (Math.random() * 255);
	}
	
	void show() {
		fill(color);
		noStroke();
		ellipse(x, y, size, size);
	}
	
	void move() {
		//Finding the nearest food
		Food closest = null;
		for (int i = 0; i < foodArray.length; i++) {
			if (foodArray[i] == null) continue;
			//Init. closest to first food in array
			if (closest == null) closest = foodArray[i];
			
			//Comparing food ranges
			if (dist(x, y, closest.x, closest.y) > dist(x, y, foodArray[i].x, foodArray[i].y)) {
				closest = foodArray[i];
			}
			
			//Eating the food if in range
    		if (dist(x, y, closest.x, closest.y) < size) {
    			//Deleting target food object
    			foodArray[i] = null;
    			closest = null;
    			size += 5;
    			break;
    		}
		}
		
		int targetY, targetX;
		
		//If no food on screen
		if (closest == null) {
			//Move randomly
			targetY = (int) (Math.random() * 700);
    		targetX = (int) (Math.random() * 700);
		} else {
			targetY = closest.y;
    		targetX = closest.x;
		}
		
		//Vertical or Horizontal
		if (Math.random() < 0.5) {
			//Vertical
			y += (int) (Math.random() * 5 - 0.5f) * signum(targetY - y);
		} else {
			//Horizontal
			x += (int) (Math.random() * 5 - 0.5f) * signum(targetX - x);
		}
		
	}
	
}
 
