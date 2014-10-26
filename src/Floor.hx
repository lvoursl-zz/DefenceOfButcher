package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author ogyrec
 */
class Floor extends Sprite
{

	public var xx:Int;
	public var yy:Int;
	public var bmp:Bitmap;
	
	public function new(x:Int, y:Int) 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/Floor.png"));
		this.x = x;
		this.y = y;
		bmp.x = x;
		bmp.y = y;
	}
	
}