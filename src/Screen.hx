package ;
import openfl.display.Sprite;
import openfl.text.TextField;

/**
 * ...
 * @author ...
 */
class Screen extends Sprite
{
	var screenText:TextField;
	public function new(type:String) 
	{
		super();
		screenText = new TextField();
		if (type == "gameover") {
			screenText.text = "lose";
		}
		screenText.textColor = 0xff00ff;
		screenText.x = 360;
		screenText.y = 260;
		addChild(screenText);
	}
	
}