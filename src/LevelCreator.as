package 
{
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class LevelCreator extends Sprite
	{
		private var maps:Array = new Array();
		private var mapLoader:URLLoader = new URLLoader();
		private var map:Array;
		public function LevelCreator()
		{
			mapLoader.addEventListener(Event.COMPLETE, onloaded);
			
		}
		private function onloaded(e:Event):void
		{
			var maptext:String = e.target.data;
			map = maptext.split("\r\n");
			trace("rows: " + map.length);
			for (var i:int = 0; i < map.length; i++ )
			{
				map[i] = map[i].split(" ");
				trace(i + ": ", map[i]);
			}
		}
		public function getMaps():Array
		{
			mapLoader.load(new URLRequest("Level1.txt"));
			maps.push(map);
			trace(maps);
			return maps;
		}
	}
	
}