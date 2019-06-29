package 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Lazi
	 */
	public class BubbleArray 
	{
		private static var bubbles:Array;
		private static var bubble:Bitmap = new Assets.bubble;
		public static const WIDTH:int = bubble.width;
		public static const HEIGHT:int = bubble.height;
		public static function initiate():void
		{
			bubbles = new Array();	
		}
		
		public static function remove(index:int):void
		{
			for (var i:int = 0; i < bubbles.length; i++ )
			{
				if (bubbles[i].index == index)
				{
					bubbles.removeAt(i);
					return;
				}
			}
			//bubbles.removeAt(index);
		}
		public static function add(value:Bubble):void
		{
			bubbles.push(value);
		}
		public static function getArray():Array
		{
			return bubbles;
		}
		public static function getlength():int
		{
			return bubbles.length;
		}
	}
	
}