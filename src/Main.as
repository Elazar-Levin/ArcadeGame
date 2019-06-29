package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.StageDisplayState;
	import flash.ui.Keyboard;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author Lazi
	 */
	public class Main extends Sprite 
	{
		private var player1:Player1;
		private var snake:enemy;
		private var snake2:enemy;
		private var snake3:enemy;
		private var boss1:Boss;
		public var levelcreator:LevelCreator;
		//public static var pause:Boolean = false;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			
			//stage.displayState = StageDisplayState.FULL_SCREEN; ADD FULLSCREEN BUTTON
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownhandler, false, 0, true);
			//levelcreator = new LevelCreator();
			//stage.addChild(levelcreator);
			
			LevelArray.initiate();
			LevelArray.CurrentLevel = 1;//change later, as default is not neccesarily 1
			JumpPoints.initiate();
			if (LevelArray.CurrentLevel == 1)
			{
				
				//JumpPoints.jumpPoints.push(new JumpPoints(348, 351, stage.stageHeight));
				//JumpPoints.jumpPoints.push(new JumpPoints(256, 260, 400+EnemyArray.HEIGHT,"right"));
			}
			BubbleArray.initiate();
			EnemyArray.initiate();
			BlockArray.initiate();
			WallArray.initiate();
			BossArray.initiate();
			Obstructions.initiate();
			boss1 = new Boss();			
			player1 = new Player1();
			snake = new enemy(EnemyTypes.SNAKE,0,10,50);
			snake2= new enemy(EnemyTypes.SNAKE,1,400,20);
			snake3 = new enemy(EnemyTypes.SNAKE,2,500,100);
			EnemyArray.add(snake);
			EnemyArray.add(snake2);
			EnemyArray.add(snake3);
			//BossArray.add(boss1);
			stage.addChild(player1);
			stage.addChild(snake);
			stage.addChild(snake2);
			stage.addChild(snake3);
			//Mouse.hide();
			//stage.addChild(boss1);
		}
		private function keydownhandler(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.F)
			{
				if (stage.displayState != StageDisplayState.FULL_SCREEN)
				{
					stage.displayState = StageDisplayState.FULL_SCREEN;
				}
				else
				{
					stage.displayState=StageDisplayState.NORMAL;
				}
			}
		}
		
	}
	
}