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
		screenText.multiline = true;
		if (type == "gameover") {
			screenText.htmlText = "You lose :( <br> Click to restart";
		} else if (type == "wingame") {
			screenText.htmlText = "You win :) <br> Click to restart";
		} else if (type == "helloscreen") {
			screenText.htmlText = "You should defence butcher.<br> To hit - press SPACE.<br> To move - arrows (left and right)<br> Double click to start.";
		}
		screenText.autoSize = TextFieldAutoSize.CENTER;
		screenText.textColor = 0xffffff;
		screenText.x = 360;
		screenText.y = 220;
		addChild(screenText);
	}
	
}