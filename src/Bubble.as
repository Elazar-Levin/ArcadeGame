package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Lazi
	 */
	public class Bubble extends Sprite 
	{
		private var bubble:Bitmap = new Assets.bubble; 
		private var bubblesmall:Bitmap = new Assets.bubblesmall; 
		private var distance:int = 0;
		private var goaldistance:int = 0;
		private var pause:Boolean; 
		private var dir:String;
		private var speed:int = 3;
		private var frameno:int = 0;
		private var lifespan:int = 450;
		private const xvelocity:int = 30;
		private const yvelocity:int = 3;
		private var mute:Boolean;
		private var pop:Sound = new Sound();
		public var index:int = 0;
		public var mode:int = BubbleMode.SIDEWAYS;
		public var Mode:int = BubbleMode.EMPTY;
		private static var bubbles:Array=new Array;
	
		public function Bubble(x:int, y:int, dir:String, pause:Boolean, mute:Boolean,index:int,Mode:int=BubbleMode.EMPTY,goaldistance:int = 100,lifespan:int=3600 )
		{
			
			addEventListener(Event.ADDED_TO_STAGE, go);
			this.x = x;
			this.y = y;
			this.dir = dir;
			this.pause = pause;
			this.goaldistance = goaldistance;
			this.mute = mute;
			this.index = index;
			this.Mode = Mode;
			this.lifespan = lifespan;
		}
		public function go(e:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, go);
			pop = new Assets.pop() as Sound;
			mode = BubbleMode.SIDEWAYS;
			if (x <= 0-50)
			{
				pop1();
				return;
				//x = 0;
			}
			
			else if(x+bubble.width>=stage.stageWidth+50)
			{
				pop1();
				return;
				
				//x = stage.stageWidth-bubble.width;
			}
			
			addEventListener(Event.ENTER_FRAME, enterframe, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, die, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownhandler, false, 0, true);
			addChild(bubblesmall);
		}
		public function enterframe(e:Event):void
		{
			if (!pause)
			{
				if (frameno == lifespan)//popping bubble frame1
				{
					
				}
				if (frameno == lifespan + 10)//popping bubble frame2
				{
					
				}
				if (frameno == lifespan+20)//popped bubble
				{
					
					pop1();
					return;
					//stage.removeChild(this);
					
					
				}
				
				frameno++;
				if (y<0)
				{
					y = stage.stageHeight;
					
					
				}
				if (distance <= goaldistance )
				{
					/*if (mode == BubbleMode.SIDEWAYS)
					{
						if (dir=="right")
						{
							for (var m:int = 0; m < BlockArray.getlength();m++ )
							{
								if (x+BubbleArray.WIDTH>= BlockArray.getArray()[m].x && x+ BubbleArray.WIDTH<=BlockArray.getArray()[m].x+BlockArray.WIDTH && y +BubbleArray.HEIGHT< BlockArray.getArray()[m].y && y>BlockArray.getArray()[m].y-BlockArray.HEIGHT)//on left, going right
								{
									//dont do shit
									x = BlockArray.getArray()[m].x - BubbleArray.WIDTH;
									mode = BubbleMode.GOINGUP;
									break;
								}
							
							
							}
						}
						if (dir=="left")
						{
							for (var m:int = 0; m < BlockArray.getlength();m++ )
							{
								if (x>= BlockArray.getArray()[m].x && x <= BlockArray.getArray()[m].x+BlockArray.WIDTH )//on left, going right
								{
								//	x = BlockArray.getArray()[m].x +BlockArray.WIDTH;
									//mode = BubbleMode.GOINGUP;
									//break;
								}
							
								
							}
						}
					}*/
					if (dir == "left" )
					{
						if (x - xvelocity >= 0)
						{
							x -= xvelocity;
							distance+= xvelocity;
						}
						else
						{
							x = 0;
							addChild(bubble);
							bubblesmall.alpha=0;

							//removeChild(bubblesmall);
							y -= yvelocity;
							mode = BubbleMode.GOINGUP;
						}
						/*if (mode == BubbleMode.SIDEWAYS)// works,to some extent, probably best to hardcode possible obstructions into an array and look through those
						{
							for (var m:int = 0; m < BlockArray.getlength();m++ )
							{
								if (x>= BlockArray.getArray()[m].x && x <= BlockArray.getArray()[m].x+BlockArray.WIDTH && y +BubbleArray.HEIGHT> BlockArray.getArray()[m].y && y<BlockArray.getArray()[m].y-BlockArray.HEIGHT )//on left, going right
								{
									x = BlockArray.getArray()[m].x +BlockArray.WIDTH;
									distance=goaldistance+1;
									mode = BubbleMode.GOINGUP;
									break;
								}
							
								
							}
						}*/
					}
					else if(dir=="right")
					{
						if (x + xvelocity < stage.stageWidth - bubble.width)
						{
							x += xvelocity;
							distance+= xvelocity;
						}
						else
						{
							x = stage.stageWidth - bubble.width;
							addChild(bubble);
							bubblesmall.alpha=0;

							//removeChild(bubblesmall);
							y -= yvelocity;
							mode = BubbleMode.GOINGUP;
						}
					/*	if (mode == BubbleMode.SIDEWAYS)
						{
							for (var m:int = 0; m < BlockArray.getlength();m++ )
							{
								if (x+BubbleArray.WIDTH>= BlockArray.getArray()[m].x && x+ BubbleArray.WIDTH<=BlockArray.getArray()[m].x+BlockArray.WIDTH && y +BubbleArray.HEIGHT< BlockArray.getArray()[m].y && y>BlockArray.getArray()[m].y-BlockArray.HEIGHT)//on left, going right
								{
									//dont do shit
									trace(true);
									x = BlockArray.getArray()[m].x - BubbleArray.WIDTH;
									mode = BubbleMode.GOINGUP;
									break;
								}
							
							
							}
	
						}*/
					}
				}
				else
				{
					//removeChild(this.bubblesmall);
					mode = BubbleMode.GOINGUP;
					addChild(bubble);
					
					bubblesmall.alpha=0;
					//removeChild(bubblesmall);
					y -= yvelocity;
				}
				//if (x + speed > stage.stageWidth - bubble.width)
				//{
				//	stage.removeChild(this);
				//	removeEventListener(Event.ENTER_FRAME, enterframe);
				//	return;
				//}
			}
		}
		public function keydownhandler(e:KeyboardEvent):void
		{
			if (e.keyCode==32) // space/pause
			{
				pause = !pause;
			}
		}
		public function getBubbles():Array
		{
			return bubbles;
		}
		public function pop1(p:int=0,dir:String="none"):void
		{
			if (!mute && p==0)
			{
				pop.play();
			}
			if (dir != "none" && Mode == BubbleMode.ITEMED)
			{
				stage.addChild(new Projectile(dir,x,y));
			}
			BubbleArray.remove(this.index);
			if (frameno < lifespan)
			{
				//pop connected bubbles
				for (var j:int = 0; j < BubbleArray.getlength(); j++ )
				{
					if (BubbleArray.getArray()[j].index != this.index)
					{
						if (collides(BubbleArray.getArray()[j].x, BubbleArray.getArray()[j].y, bubble.width, bubble.height))
						{
							BubbleArray.getArray()[j].pop1(p, dir);
						}
					}
				}
				for (var k:int = 0; k < EnemyArray.getlength(); k++ )
				{
					if (EnemyArray.getArray()[k].mode==EnemyModes.BUBBLED && collides(EnemyArray.getArray()[k].x, EnemyArray.getArray()[k].y, bubble.width, bubble.height))
					{
						//EnemyArray.getArray()[k].kill();
					}
				}
			}
			stage.removeChild(this);
			//stage.dispatchEvent(new CustomEvents(CustomEvents.POP));
			removeEventListener(Event.ENTER_FRAME, enterframe);
			
					
		}
		public function collides(x:int,y:int,width:int,height:int):Boolean
		{
			if (x+width>=this.x && x<=this.x+bubble.width && y+height>=this.y &&y<=this.y+bubble.height)
			{
				return true;
			}
			return false;
		}
		public function die(e:Event):void
		{
			
		}
	
	}
	
}