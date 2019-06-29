package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class Block extends Sprite 
	{
	
		private var blockblue:Bitmap = new Assets.blockblue ;
		public var mode:String;
		public var isLast:Boolean;
		public function Block(x:int, y:int,mode:String="normal",isLast:Boolean=false)
		{
			addEventListener(Event.ADDED_TO_STAGE, go);
			this.x = x;
			this.y = y;
			this.mode = mode;
			this.isLast = isLast;
		}
		public function go(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, go);
		//	addEventListener(Event.ENTER_FRAME, enterframe, false, 0, true);
		
			addChild(blockblue);
			
			
		}
		//public function enterframe(e:Event):void
		//{
		//	addChild(blockblue);
		//}
	}
}
	