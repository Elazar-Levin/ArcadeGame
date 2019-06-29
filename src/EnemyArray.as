package 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author Lazi
	 */
	public class EnemyArray 
	{
		private static var enemies:Array;
		private static var enemy1:Bitmap = new Assets.snakel;
		public static const WIDTH:int = enemy1.width;
		public static const HEIGHT:int = enemy1.height;
		
		public static function initiate():void
		{
			enemies = new Array();	
		}
		
		public static function remove(index:int):void
		{
			for (var i:int = 0; i < enemies.length; i++ )
			{
				if (enemies[i].index == index)
				{
					enemies.removeAt(i);
					return;
				}
			}
			//bubbles.removeAt(index);
		}
		public static function add(value:enemy):void
		{
			enemies.push(value);
		}
		public static function getArray():Array
		{
			return enemies;
		}
		public static function getlength():int
		{
			return enemies.length;
		}
	
	}
	
}