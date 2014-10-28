package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author ogyrec
 */
class Game extends Sprite
{
	var floor:Array<Floor> = [];
	var warriorsArray:Array<Warrior> = [];
	var hero:Hero;
	var frame:Int = 0;
	var frameToStopAnimation:Int = 0;

	public function new() 
	{
		super();
		createBackground();
		createFloor();
		createHero();
		createWarrior();
		addEventListener(Event.ENTER_FRAME, onFrame);
	}
	
	public function createFloor() {
		for (i in 0 ... 3) {
			var flo:Floor = new Floor((i * 250), 350);
			floor.push(flo);
			addChild(flo.bmp);
		}
	}

	public function createBackground() {
		for (i in 0 ... 4) {
			for (j in 0 ... 2) {
				var bmp = new Bitmap(Assets.getBitmapData("img/bg1.jpg"));
				bmp.x = i * 225;
				bmp.y = j * 225;
				addChild(bmp);
			}
		}
	}
	
	public function createHero() {
		hero = new Hero(200, 350);
		addChild(hero.bmp);
	}
	
	public function createWarrior() {
		var newWarrior = new Warrior(720, 350);
		warriorsArray.push(newWarrior);
		addChild(newWarrior.bmp);
	}
	
	public function onFrame(e:Event) {
		frame++;		
		moveHero();
		operationsWithWarriors();
	}
	
	public function moveHero() {
				// moving floor for future gameplay
			/*if (Main.keys[37]) {
				for (fl in floor) {
					fl.x--;
					fl.bmp.x--;
				}
			}	
			else if (Main.keys[39]) {
				for (fl in floor) {
					fl.x++;
					fl.bmp.x++;
				}
			}*/	
			
		if (Main.keys[37]) {
			hero.x--;
		}	
		else if (Main.keys[39]) {
			hero.x++;
		} 		
		else if (Main.keys[32]) {
			hero.bmp.bitmapData = Assets.getBitmapData("img/heroShout.png");
			frameToStopAnimation = frame;
			hero.axePressed = true;
		}
			
		if ((hero.bmp.bitmapData !=  Assets.getBitmapData("img/hero11.png")) && (frame - frameToStopAnimation) == 10) {
			hero.bmp.bitmapData =  Assets.getBitmapData("img/hero11.png");
			frameToStopAnimation = 0;
			hero.axePressed = false;
		}
			
		hero.bmp.x = hero.x;
	}
	
	public function operationsWithWarriors() {
		if ((frame % 200) == 0) {
			createWarrior();
		}
		
		for (warrior in warriorsArray) {
			warrior.x--;
			warrior.bmp.x--;
			if ((hero.axePressed == true) && ((hero.x - warrior.x) < 40) && ((hero.x - warrior.x) > -40)) {
				//removeChild(warrior);
				//warriorsArray.remove(warrior);
				//removeChild(warrior.bmp);
				//warrior = null;
			}
			
		}
		

	}
	
}