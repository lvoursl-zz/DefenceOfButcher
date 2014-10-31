package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author ogyrec
 */
class Game extends Sprite
{
	var floor:Array<Floor> = [];
	
	var warriorsArray:Array<Warrior> = [];
	var newWarrior = new Warrior(720, 350, true);
	
	var hero:Hero;
	var heroHealthTextField = new TextField(); 
	
	var frame:Int = 0;
	var frameToStopAnimation:Int = 0;
	var randomNumber:Float = 0;

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
		heroHealthTextField.text = "HP :" + hero.hp;
		heroHealthTextField.x = 40;
		heroHealthTextField.y = 20;
		addChild(heroHealthTextField);
		addChild(hero.bmp);
	}
	
	public function createWarrior() {
		randomNumber = Math.random() * 10;
		if ((randomNumber - 2) > 5) {
			newWarrior = new Warrior(720, 350, false);
			warriorsArray.push(newWarrior);
			addChild(newWarrior.bmp);
		} else {
			newWarrior = new Warrior(0, 350, true);
			warriorsArray.push(newWarrior);
			addChild(newWarrior.bmp);
		}
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
			hero.x -= 3;
			hero.bmp.bitmapData = Assets.getBitmapData("img/heroLeft.png");
		}	
		else if (Main.keys[39]) {
			hero.x += 3;
			hero.bmp.bitmapData = Assets.getBitmapData("img/heroRight.png");
		} 		
		else if (Main.keys[32]) {
			if (hero.bmp.bitmapData == Assets.getBitmapData("img/heroRight.png")) {
				hero.bmp.bitmapData = Assets.getBitmapData("img/heroRightHit.png");
			}	
			if (hero.bmp.bitmapData == Assets.getBitmapData("img/heroLeft.png")){
				hero.bmp.bitmapData = Assets.getBitmapData("img/heroLeftHit.png");	
			}
			frameToStopAnimation = frame;
			hero.axePressed = true;
		}
			
		if ((hero.bmp.bitmapData ==  Assets.getBitmapData("img/heroRightHit.png")) && (frame - frameToStopAnimation) == 10) {
			hero.bmp.bitmapData =  Assets.getBitmapData("img/heroRight.png");
			frameToStopAnimation = 0;
			hero.axePressed = false;
		}
							
		if ((hero.bmp.bitmapData ==  Assets.getBitmapData("img/heroLeftHit.png")) && (frame - frameToStopAnimation) == 10) {
			hero.bmp.bitmapData =  Assets.getBitmapData("img/heroLeft.png");
			frameToStopAnimation = 0;
			hero.axePressed = false;
		}
			
		hero.bmp.x = hero.x;
	}
	
	public function operationsWithWarriors() {
		if ((frame % 100) == 0) {
			createWarrior();
		}
		
		for (warrior in warriorsArray) {
			if (warrior.leftType == false) {
				warrior.x--;
				warrior.bmp.x--;
			} else {
				warrior.x++;
				warrior.bmp.x++;
			}
			if ((hero.axePressed == true) && ((hero.x - warrior.x) < 60) && ((hero.x - warrior.x) > -40)) {
				removeChild(warrior.bmp);
				warriorsArray.remove(warrior);
			}
			if (warrior.x == hero.x) {
				removeChild(warrior.bmp);
				warriorsArray.remove(warrior);
				hero.hp -= 20;
				heroHealthTextField.text = "HP :" + hero.hp;
				if (hero.hp == 0) {
					dispatchEvent(new Event("gameover"));
				}
			}
			
			
		}
		

	}
	
}