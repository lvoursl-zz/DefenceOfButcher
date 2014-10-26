package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author ogyrec
 */
class Game extends Sprite
{
	var floor:Array<Floor> = [];
	
	public function new() 
	{
		super();
		createBackground();
		createFloor();
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
	
}