package 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Lazi
	 */
	public class BlockArray 
	{
		private static var blocks:Array;
		
		private static var block:Bitmap = new Assets.blockblue;
		public static const WIDTH:int = block.width;
		public static const HEIGHT:int = block.height;
		public static function initiate():void
		{
			blocks = new Array();	
		}
		
		public static function remove(index:int):void
		{
			for (var i:int = 0; i < blocks.length; i++ )
			{
				if (blocks[i].index == index)
				{
					blocks.removeAt(i);
					return;
				}
			}
			//bubbles.removeAt(index);
		}
		public static function add(value:Block):void
		{
			blocks.push(value);
		}
		public static function getArray():Array
		{
			return blocks;
		}
		public static function getlength():int
		{
			return blocks.length;
		}
	}	
}