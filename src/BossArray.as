package 
{
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class BossArray 
	{
		private static var bosses:Array;
		public static function initiate():void
		{
			bosses = new Array();	
		}
		
		public static function remove(index:int):void
		{
			for (var i:int = 0; i < bosses.length; i++ )
			{
				if (bosses[i].index == index)
				{
					bosses.removeAt(i);
					return;
				}
			}
			//bubbles.removeAt(index);
		}
		public static function add(value:Boss):void
		{
			bosses.push(value);
		}
		public static function getArray():Array
		{
			return bosses;
		}
		public static function getlength():int
		{
			return bosses.length;
		}
	}	
}