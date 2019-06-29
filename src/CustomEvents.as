package 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CustomEvents extends Event 
	{
	
		public static const POP:String = "pop";
		
		
		public function CustomEvents(e:String)
		{
			super(e);
			
		}
	}
	
}