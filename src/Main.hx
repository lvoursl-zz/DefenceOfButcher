package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;

/**
 * ...
 * @author ogyrec
 */

class Main extends Sprite 
{
	var inited:Bool;
	var game:Game;
	var screen:Screen;
	public static var keys:Map<Int,Bool> = new Map();
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		screen = new Screen("helloscreen");
		addChild(screen);
		screen.addEventListener(MouseEvent.CLICK, createNewGame);
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
	
	
	public function onDown(e:KeyboardEvent) {
		keys[e.keyCode] = true;
	}
	
	public function onUp(e:KeyboardEvent) {
		keys[e.keyCode] = false;
	}
	
	public function gameover(e:Event) {
		removeChild(game);
		screen = new Screen("gameover");
		screen.addEventListener(MouseEvent.CLICK, createNewGame);
		addChild(screen);
	}
	
	public function wingame(e:Event) {
		removeChild(game);
		screen = new Screen("wingame");
		screen.addEventListener(MouseEvent.CLICK, createNewGame);
		addChild(screen);
	}
	
	public function createNewGame(e:MouseEvent) {
		removeChild(screen);
		game = new Game();
		addChild(game);
		game.addEventListener("wingame", wingame);
		game.addEventListener("gameover", gameover);
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
