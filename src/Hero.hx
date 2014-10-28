package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author ogyrec
 */
class Hero extends Sprite
{
	//public var x:Int;
	//public var y:Int;
	public var bmp:Bitmap;
	public var axePressed:Bool = false;
	public var hp:Int = 100;
	
	public function new(x:Int, y:Int) 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/hero11.png"));
		this.x = x;
		this.y = y;
		bmp.x = x;
		bmp.y = y;
		bmp.scaleX = 0.5;
		bmp.scaleY = 0.5;
	}
	
}