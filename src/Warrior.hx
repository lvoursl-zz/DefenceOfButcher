package ;
import openfl.display.Bitmap;
import openfl.Assets;
import openfl.display.Sprite;

/**
 * ...
 * @author ...
 */
class Warrior extends Sprite
{
	public var bmp:Bitmap;

	public function new(x:Int, y:Int) 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/warrior.png"));
		this.x = x;
		this.y = y;
		bmp.x = x;
		bmp.y = y;
		bmp.scaleX = 0.35;
		bmp.scaleY = 0.35;
	}
	
}