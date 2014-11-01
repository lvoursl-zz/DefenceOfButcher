package ;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

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
			screenText.htmlText = "You lose :( <br> Click to restart";
		}
		else if (type == "wingame") {
			screenText.htmlText = "You win :) <br> Click to restart";
		}
		screenText.autoSize = TextFieldAutoSize.CENTER;
		screenText.textColor = 0xff00ff;
		screenText.x = 360;
		screenText.y = 260;
		addChild(screenText);
	}
	
}