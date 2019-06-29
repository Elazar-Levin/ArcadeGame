package 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Lazi
	 */
	public class WallArray 
	{
		private static var walls:Array;
		
		private static var block:Bitmap = new Assets.blockblue;
		public static const WIDTH:int = block.width;
		public static const HEIGHT:int = block.height;
		public static function initiate():void
		{
			walls = new Array();	
		}
		
		public static function remove(index:int):void
		{
			for (var i:int = 0; i < walls.length; i++ )
			{
				if (walls[i].index == index)
				{
					walls.removeAt(i);
					return;
				}
			}
			//bubbles.removeAt(index);
		}
		public static function add(value:Block):void
		{
			walls.push(value);
		}
		public static function getArray():Array
		{
			return walls;
		}
		public static function getlength():int
		{
			return walls.length;
		}
	}
	
}