package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Lazi
	 */
	public class Boss extends Sprite 
	{
		private var bossl:Bitmap = new Assets.boss1;
		private var bossr:Bitmap = new Assets.boss1;
		private var xspeed:Number = 6;//balance,probably use trig
		private var yspeed:Number = 4.3;//balance,probably use trig
		private var pause:Boolean = false;
		public function Boss()
		{
			addEventListener(Event.ADDED_TO_STAGE, go);
		}
		public function go(e:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, go);
			addEventListener(Event.ENTER_FRAME, enterframe, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, die, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownhandler, false, 0, true);
			x = 200;
			y = 300;
			addChild(bossr);
		}
		public function enterframe(e:Event):void
		{
			if (!pause)
			{
				x += xspeed;
				y += yspeed;
				//xspeed += 0.001;
				//yspeed -= 0.001;
				if (y + bossl.height >= stage.stageHeight || y<=0)
				{
					yspeed *=-1;
				}
				if(x<=0 ||x+bossl.width>stage.stageWidth)
				{
					xspeed *=-1;
					if (x <= 0)
					{
						addChild(bossr);
					}
					else
					{
						addChild(bossl);
					}
				}
			}
		}
		public function keydownhandler(e:KeyboardEvent):void
		{
			
			if (e.keyCode==32) // space/pause
			{
				pause = !pause;
			}
			
		}
		public function die(e:Event):void
		{
			
		}
	}
	
}