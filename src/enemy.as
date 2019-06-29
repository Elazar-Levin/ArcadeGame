package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class enemy extends Sprite 
	{
		private var speed:int=4;
		private var movingleft:Boolean=false;
	
		private var movingright:Boolean = false;
		private var jumping:Boolean = false;
		private var pause:Boolean = false;
		private var snakel:Bitmap = new Assets.snakel;
		private var snaker:Bitmap = new Assets.snaker;
		private var snakebubblel:Bitmap = new Assets.snakebubblel;
		private var snakebubbler:Bitmap = new Assets.snakebubbler;
		private var movingup:Boolean=false;
		private var mymax:int = 0;
		private var myinit:int = 0;
		private var type:int=EnemyTypes.SNAKE;
		
		public var mode:int = EnemyModes.NORMAL;
		private var injump:Boolean = false;
		private var moves:Array = new Array();
		private var yvelocity:Number = 0;
		private var xvelocity:Number = 0;
		private var frame:int = 0;
		public var index:int = 0;
		private var pop:Sound = new Sound();
		private var mute:Boolean = true;
		//private var bubbles:Array = new Array;
		//private var injump:Boolean = false;
		
		
		public function enemy(type:int,index:int,x:int,y:int){
			addEventListener(Event.ADDED_TO_STAGE, go);
			this.type = type;
			this.index = index;
			this.x = x;
			this.y = y;
			
		}
		public function go(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, go);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownhandler, false, 0, true);
			addEventListener(Event.ENTER_FRAME, enterframe, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, die, false, 0, true);
			
			movingright = true;
			
			if (type == EnemyTypes.SNAKE)
			{
				addChild(snakel);
			}
			
			pop = new Assets.pop() as Sound;
			
		}
		public function keydownhandler(e:KeyboardEvent):void
		{
			
			if (e.keyCode==32) // space/pause
			{
				pause = !pause;
			}
			
		}
		public function enterframe(e:Event):void
		{
			if (!pause)
			{
				//TODO implement jumpoints, places that the enemy will possibly jump if its in them
				//right zones,left zones, makes enemy turn around
				for (var i:int = 0; i < BubbleArray.getlength(); i++ )
				{
					var bubbles:Array = BubbleArray.getArray();
					
				}
				if (mode == EnemyModes.FRANTIC)
				{
					speed = 6;
				}
				if (mode != EnemyModes.BUBBLED)
				{
					var bubble:Bitmap = new Assets.bubble; 
					for (var i:int = 0; i < BubbleArray.getlength(); i++ )
					{
						if (collides(BubbleArray.getArray()[i].x,BubbleArray.getArray()[i].y,bubble.width,bubble.height) && BubbleArray.getArray()[i].mode==BubbleMode.SIDEWAYS)
						{
							mode = EnemyModes.BUBBLED;
							
							BubbleArray.getArray()[i].pop1(1);
							break;
						}
					}
				}
				if (mode == EnemyModes.BUBBLED)
				{
					
					if (type == EnemyTypes.SNAKE)
					{
						if (frame == stage.frameRate)
						{
							frame = 0;
						}
						snakel.alpha = 0;
						snaker.alpha = 0;
						snakebubbler.alpha = 1;
						snakebubblel.alpha = 1;
						if (frame % 3 == 0 || frame % 2 == 0)
						{
							addChild(snakebubbler);
						}
						else
						{
							addChild(snakebubblel);
						}
						y-=3;
						if (y <= 0)
						{
							y = stage.stageHeight;
							//mode = EnemyModes.FRANTIC;
							//snakel.alpha = 1;
							//snaker.alpha = 1;
							//snakebubblel.alpha = 0;
							//snakebubbler.alpha = 0;
							
						}
						frame++;
						//do shit
					}
					
				}
				else
				{
					if (x >= stage.stageWidth - snaker.width)
					{
						movingright = false;
						movingleft = true;
					}
					if (x <= 0)
					{
						movingleft = false;
						movingright = true;
					}
					var dir:String;
					if (movingright)
					{
						dir = "right";
					}
					else
					{
						dir = "left";
					}
					for (var o:int = 0; o < JumpPoints.jumpPoints.length; o++ )
					{
						if (! jumping &&JumpPoints.jumpPoints[o].checkInRange(x, y, EnemyArray.WIDTH, EnemyArray.HEIGHT,dir))
						{
						
							var p:int = Math.floor(Math.random() * 12);
							//trace(p);
							if (p == 0||p==1||p==7||p==9||p==3)
							{
								
								jumping = true;
								break;
							}
						}
					}
					
					
					if (movingleft && x>0)
					{
						if (type == EnemyTypes.SNAKE)
						{
							addChild(snakel);
						}
						x -= xvelocity;
						x -= speed;
							

					}
					else if(x<=0)
					{
						x = 0;
					}
					if (movingright && x<stage.stageWidth-snaker.width)
					{
						if (type == EnemyTypes.SNAKE)
						{
							addChild(snaker);
						}
						x += xvelocity;	
						x += speed;
							
						
					}
					//be careful
					//else if (x >= stage.stageWidth - snaker.width)
					//{
					//	x = stage.stageWidth - snaker.width;
					//}
					if ((jumping))// && (y>=stage.stageHeight-snaker.height))//||(y==stage.stageHeight-snaker.height-120&&(x>=200-snaker.width && x<=300)))))//change to array for all platforms
					{
						//trace(true);
						yvelocity = 16;
						jumping = false;
						xvelocity = 1;
					}
					y -= yvelocity;
					yvelocity--;
					//x+=xvelocity;
					//if (yvelocity <= 0)
					//{
					//	
					//	if (bottomcollide(200,300,stage.stageHeight-110))
					//	{
					//		y = stage.stageHeight - snaker.height - 120;
					//		injump = false;
					//		yvelocity = 0;
					//		xvelocity = 0;
					//		
					//	}
					//	
					//}
					
					
					
				
			
				
				
					
					for (var l:int = 0; l < BlockArray.getlength(); l++ )
					{
						//add two separate options for movingleft and movingright, specifically for stairs
						
						if (bottomcollide(BlockArray.getArray()[l].x,BlockArray.getArray()[l].x+BlockArray.WIDTH,BlockArray.getArray()[l].y+10))
						{
							
							y = BlockArray.getArray()[l].y-EnemyArray.HEIGHT;
							injump = false;
							yvelocity = 0;
							xvelocity = 0;
							break;
						}
							
					}
					
		
					
					//if (y >=stage.stageHeight-snakel.height)
					//{
					//	y = stage.stageHeight - snakel.height;
					//	injump = false;
					//	yvelocity = 0;
					//	xvelocity = 0;
					//}
					/*
					if (movingright)
					{
						for (var m:int = 0; m < BlockArray.getlength();m++ )
						{
							if (x+PlayerConstants.PLAYERWIDTH>= BlockArray.getArray()[m].x && x+ PlayerConstants.PLAYERWIDTH<=BlockArray.getArray()[m].x+BlockArray.WIDTH && y+PlayerConstants.PLAYERHEIGHT> BlockArray.getArray()[m].y && y+PlayerConstants.PLAYERHEIGHT<= BlockArray.getArray()[m].y+BlockArray.HEIGHT)//on left, going right
							{
								
								x = BlockArray.getArray()[m].x - PlayerConstants.PLAYERWIDTH;
								movingleft = true;
								movingright = false;
								break;
							}
						
						
						}
					}
					if (movingleft)
					{
						for (var m:int = 0; m < BlockArray.getlength();m++ )
						{
							if (x>= BlockArray.getArray()[m].x && x <= BlockArray.getArray()[m].x+BlockArray.WIDTH && y+PlayerConstants.PLAYERHEIGHT> BlockArray.getArray()[m].y && y+PlayerConstants.PLAYERHEIGHT<= BlockArray.getArray()[m].y+BlockArray.HEIGHT)//on left, going right
							{
								x = BlockArray.getArray()[m].x +BlockArray.WIDTH;
								movingleft = false;
								movingright = true;
								break;
							}
						
							
						}
					}
					
					*/
					if (movingright)
					{
						for (var m:int = 0; m < Obstructions.obstructions.length;m++ )
						{
							if (x+EnemyArray.WIDTH>= Obstructions.obstructions[m].x && x+ EnemyArray.WIDTH<=Obstructions.obstructions[m].x+BlockArray.WIDTH && y+EnemyArray.HEIGHT> Obstructions.obstructions[m].y && y+EnemyArray.HEIGHT<= Obstructions.obstructions[m].y+BlockArray.HEIGHT)//on left, going right
							{
								
								x = Obstructions.obstructions[m].x - EnemyArray.WIDTH;
								movingleft = true;
								movingright = false;
								break;
							}
						
						
						}
					}
					if (movingleft)
					{
						for (var m:int = 0; m < Obstructions.obstructions.length;m++ )
						{
							if (x>= Obstructions.obstructions[m].x && x <= Obstructions.obstructions[m].x+BlockArray.WIDTH && y+EnemyArray.HEIGHT> Obstructions.obstructions[m].y && y+PlayerConstants.PLAYERHEIGHT<= Obstructions.obstructions[m].y+BlockArray.HEIGHT)//on left, going right
							{
								x = Obstructions.obstructions[m].x +BlockArray.WIDTH;
								movingleft = false;
								movingright = true;
													
								break;
							}
						
							
						}
					}	
				}
			}	
		}
		
		public function die(e:Event):void
		{
			
			
		}
		public function kill():void
		{
			if (!mute)
			{
				pop.play();
			}
			EnemyArray.remove(this.index);
			for (var i:int = 0; i < BubbleArray.getlength();i++  )
			{
				if (collides(BubbleArray.getArray()[i].x, BubbleArray.getArray()[i].y, BubbleArray.WIDTH, BubbleArray.HEIGHT))
				{
					BubbleArray.getArray()[i].pop1();
					break;
				}
			}
			stage.removeChild(this);
			//stage.dispatchEvent(new CustomEvents(CustomEvents.POP));
			removeEventListener(Event.ENTER_FRAME, enterframe);
			
		}
		private function bottomcollide(x1:int,x2:int, y1:int):Boolean
		{
			
			if (x+snaker.width >= x1 && x <= x2 && y+snakel.height<=y1+1 && y+snakel.height>=y1-20)
			{
				//jumping = true; trampoliny move
		
				return true;
			}
			return false;
		}
		
		private function collides(x:int,y:int,width:int,height:int):Boolean
		{
			if (x+width>=this.x-15 && x<=this.x+snakel.width+15 && y+height>=this.y-15 &&y<=this.y+snakel.height-15)
			{
				return true;
			}
			return false;
		}
	}
}



				