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
	
	var houseBmp:Bitmap;
	var houseHpTextField = new TextField();
	var houseHp:Int = 5;
	
	var time:Int = 50;
	var timeTextField = new TextField();

	public function new() 
	{
		super();
		createBackground();
		createFloor();
		createHouse();
		createTimeTable();
		createHero();
		createWarrior();
		addEventListener(Event.ENTER_FRAME, onFrame);
	}
	
	public function createTimeTable() {
		timeTextField.x = 40;
		timeTextField.y = 40;
		timeTextField.text = "Вам осталось : " + time + " мгновений";
		timeTextField.autoSize = TextFieldAutoSize.CENTER;
		addChild(timeTextField);
	}
	
	public function createFloor() {
		for (i in 0 ... 3) {
			var flo:Floor = new Floor((i * 250), 350);
			floor.push(flo);
			addChild(flo.bmp);
		}
	}
	
	public function createHouse() {
			houseBmp = new Bitmap(Assets.getBitmapData("img/house5.png"));
			houseBmp.x = 300;
			houseBmp.y = 325;
			houseHpTextField.text = "House hp :" + houseHp;
			houseHpTextField.x = 40;
			houseHpTextField.y = 30;
			addChild(houseBmp);
			addChild(houseHpTextField);
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
		heroHealthTextField.text = "Hero hp :" + hero.hp;
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
		if ((frame % 80) == 0) {
			time--;
			timeTextField.text = "Вам осталось : " + time + " мгновений";
			if (time == 0) {
				dispatchEvent(new Event("wingame"));
			}
		}
	}
	
	public function moveHero() {

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
			
		if ((hero.bmp.bitmapData ==  Assets.getBitmapData("img/heroRightHit.png")) && (frame - frameToStopAnimation) == 5) {
			hero.bmp.bitmapData =  Assets.getBitmapData("img/heroRight.png");
			frameToStopAnimation = 0;
			hero.axePressed = false;
		}
							
		if ((hero.bmp.bitmapData ==  Assets.getBitmapData("img/heroLeftHit.png")) && (frame - frameToStopAnimation) == 5) {
			hero.bmp.bitmapData =  Assets.getBitmapData("img/heroLeft.png");
			frameToStopAnimation = 0;
			hero.axePressed = false;
		}
		
		if (hero.x > 710) hero.x = 0;
		if (hero.x < 0) hero.x = 710;
		
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
				if (warrior.leftType == true) { 
					warrior.x -= 30;
					warrior.bmp.x -= 30;
				} else {
					warrior.x += 30;
					warrior.bmp.x += 30;
				}
				warrior.hp--;
				if (warrior.hp == 0) {	
					removeChild(warrior.bmp);
					warriorsArray.remove(warrior);
				}
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
			if ((warrior.x > 720) || (warrior.x < 0)) {
				removeChild(warrior.bmp);
				warriorsArray.remove(warrior);
			}
			
			if (warrior.x == 300) {
				houseHp--;
				if (houseHp == 0) {
					dispatchEvent(new Event("gameover"));
				}
				warrior.y = 60 * houseHp;
				warrior.bmp.y = 60 * houseHp;
				warriorsArray.remove(warrior);
			}
		}
		

	}
	
}