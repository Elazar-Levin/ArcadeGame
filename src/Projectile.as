package 
{
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.AVLoader;
	import flash.events.ProgressEvent;
	/**
	 * ...
	 * @author Lazi
	 */
	public class Projectile extends Sprite 
	{
		private var bulletl:Bitmap = new Assets.bulletl;
		private var bulletr:Bitmap = new Assets.bulletr;
		private var dir:String = "left";
		private var speed:int = 3;
		
		public function Projectile(dir:String,x:int,y:int)
		{
			addEventListener(Event.ADDED_TO_STAGE, go);
			this.dir = dir;
			this.x = x;
			this.y = y;
		}
		public function go(e:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, go);
			addEventListener(Event.ENTER_FRAME, enterframe, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, die, false, 0, true);
			if (dir=="left")
			{
				addChild(bulletl);
			}
			else
			{
				addChild(bulletr);
			}
			
		}
		public function enterframe(e:Event):void
		{
			x += speed;
		}
		public function die(e:Event):void
		{
			
		}
		
	}
	
}