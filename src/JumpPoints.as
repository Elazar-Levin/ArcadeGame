package 
{
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class JumpPoints 
	{
		public var x1:int;
		public var x2:int;
		public var y:int;
		public var dir:String;//left,right,both
		public static var jumpPoints:Array;
		public static function initiate():void
		{
			jumpPoints = new Array();
		}
		public function JumpPoints(x1:int,x2:int,y:int,dir:String="both"):void
		{
			this.x1 = x1;
			this.x2 = x2;
			this.y = y;
			this.dir = dir;
			//trace("new jumppoint");
		}
		public function checkInRange(x:int,y:int,width:int,height:int,dir:String="left"):Boolean
		{
			if (dir == "right" && this.dir == "left" || dir == "left" && this.dir == "right")
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