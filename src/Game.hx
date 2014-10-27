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
	var hero:Hero;
	
	public function new() 
	{
		super();
		createBackground();
		createFloor();
		createHero();
		
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
	
	public function onFrame(e:Event) {
				
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
			
			hero.bmp.x = hero.x;
	}
	
}