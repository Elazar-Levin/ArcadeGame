package 
{
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class RightZone 
	{
		public var x1:int;
		public var x2:int;
		public var y:int;
		public static var rightzones:Array;
		public static function initiate():void
		{
			rightzones= new Array();
		}
		public function RightZone(x1:int,x2:int,y:int):void
		{
			this.x1 = x1;
			this.x2 = x2;
			this.y = y;
		}
		public function checkInRange(x:int,y:int,width:int,height:int,dir:String="left"):Boolean
		{
			if (dir == "right")
			{
				return false;
			}
			if (y+height != this.y)
			{
				//trace("wrong y");
				//trace(y + height);
				return false;
			}
			if (x<this.x1)
			{
				//trace("smaller");
				return false;
			}
			if (x > this.x2)
			{
				//trace("larger");
				return false;
			}
			//trace("in range");
			return true;
			
		}
		
		
	}	
	
}