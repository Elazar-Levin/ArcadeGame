package 
{
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class Obstructions
 	{
		public var x:int;
	
		public var y:int;
		public var dir:String;//left,right,both
		public static var obstructions:Array;
		public static function initiate():void
		{
			obstructions = new Array();
		}
		public function Obstructions(x:int,y:int,dir:String):void
		{
			this.x = x;
			this.y = y;
			this.dir = dir;
			
		}
		
	}
	
}