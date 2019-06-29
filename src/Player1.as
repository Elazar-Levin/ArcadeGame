package 
{
	import flash.text.TextFormat;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Lazi
	 */
	public class Player1 extends Sprite 
	{
		
		//hardcode left and right obstructions so player doesnt do weird shit when going through floors, also will use less resources
//		make a top speed and a current speed, every couple of frames increase speed to a maximum of topspeed current speed will be force 
		private var currentSpeed:int = 3;
		private var speedframe:Number = 0;
		private var topSpeed:int = 4;
		private var speed:int=4;
		private var movingleft:Boolean=false;
		private var facingleft:Boolean=false;
		private var facingright:Boolean = false;
		private var movingright:Boolean = false;
		private var jumping:Boolean = false;
		private var blowingbubbles:Boolean = false;
		private var pause:Boolean = false;
		private var blockl:Bitmap = new Assets.blockl;
		private var blockr:Bitmap = new Assets.blockr;
		private var movingup:Boolean=false;
		private var mymax:int = 0;
		private var myinit:int = 0;
		private var bubbles:Array = new Array;
		private var xvelocity:Number = 0;
		private var yvelocity:Number = 0;
		private var injump:Boolean = false;
		private var bubbleID:int = 0;
		private var block:Block;
		private var jump:Sound = new Sound();
		//private var blocks:Array = new Array();
		private var moves:Array = new Array();
		private var jumppressed:Boolean = false;
		private var bubblerate:int = 10;
		private var myframe:int = 0;
		private var waitingbubble:int;
		private var mybubble:int = 0;
		private var mute:Boolean = true;
		private var text:TextField = new TextField();
		private var Level1:Array = new Array();
		private var force:int = 0; 
		
		public function Player1(){
			addEventListener(Event.ADDED_TO_STAGE, go);
			
			
		}
		public function go(e:Event):void
		{
			//trace("go");
			removeEventListener(Event.ADDED_TO_STAGE, go);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownhandler, false, 1, false);
			addEventListener(Event.ENTER_FRAME, enterframe, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, die, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyuphandler, false, 0, true);
			
			/*text.textColor = 0x000000;
			text.text = "Hello";
			text.x = 100;
			text.y = 100;
			var txt:TextFormat = new TextFormat();
			text.setTextFormat(txt);
			stage.addChild(text);
			*/
			
			x = 200;
			y = stage.stageHeight - 100;
			
			/*
			for (var i:int = 0; i < 300; i += 20 )
			{
				block = new Block(i, stage.stageHeight - 120);
				BlockArray.add(block);
				//blocks.push(block);
				stage.addChild(block);
			}
			
			for (var i:int = 400; i < 550; i += 20 )
			{
				block = new Block(i, stage.stageHeight - 240);
				BlockArray.add(block);
				//blocks.push(block);
				stage.addChild(block);
			}
			var j:int = 250;
			for (var i:int = 560; i <= stage.stageWidth; i += 20 )
			{
					if (i == stage.stageWidth)
					{
						block = new Block(i, stage.stageHeight - j, "stairs",true);
					}
					else
					{
						block = new Block(i, stage.stageHeight - j, "stairs");
					}
					BlockArray.add(block);
					//blocks.push(block);
					stage.addChild(block);
					j += 10;
					
			}
			
			
			*/
			
			if (LevelArray.CurrentLevel == 1)
			{
				var map:Array = LevelArray.getArray()[0];
				for (var i:int = 0; i < map.length; i++ )
				{
					for (var j:int = 0; j < map[i].length; j++ )
					{
						if (map[i][j] == 1)
						{
								block = new Block(j * 20, i * 20);
								BlockArray.add(block);
								stage.addChild(block);
								
						}
						if (map[i][j] == 2)
						{
							block = new Block(j * 20, i * 20);
							BlockArray.add(block);
							stage.addChild(block);
							Obstructions.obstructions.push(block);
						}
						if (map[i][j] == 3)
						{
							//trace(i * 20 +"  " + j * 20);
							if (j * 20 >= stage.stageWidth/2)
							{
								JumpPoints.jumpPoints.push(new JumpPoints((j * 20)+5 , (j * 20)+5+4, (i * 20) + BlockArray.HEIGHT, "left"));
							//	trace("x1" ,((j * 20) - EnemyArray.WIDTH + BlockArray.WIDTH + 10) , " x2" , ((j * 20) - EnemyArray.WIDTH + BlockArray.WIDTH + 10 + 4), " y", ((i * 20) + BlockArray.HEIGHT ) );
							}
							else
							{
								JumpPoints.jumpPoints.push(new JumpPoints((j * 20) + BlockArray.WIDTH-EnemyArray.WIDTH - 5-4 , (j * 20) + BlockArray.WIDTH -EnemyArray.WIDTH- 5 , (i * 20) + BlockArray.HEIGHT, "right"));
								trace("x1" ,((j * 20) + BlockArray.WIDTH - 5-4 ) , " x2" , ((j * 20) + BlockArray.WIDTH - 5 ), " y", ((i * 20) + BlockArray.HEIGHT ) );
							//	JumpPoints.jumpPoints.push(new JumpPoints((j*20)-BlockArray.WIDTH-8, (j*20)-BlockArray.WIDTH, (i*20)+BlockArray.HEIGHT+EnemyArray.HEIGHT,"right"));
							}
							
						}
					}
				}
			}
			//JumpPoints.jumpPoints.push(new JumpPoints(590+EnemyArray.WIDTH, 594+EnemyArray.WIDTH, 340+EnemyArray.HEIGHT,"left"));
			
			addChild(blockl);
			jump= new Assets.jump1() as Sound;
			waitingbubble = stage.frameRate / 2;//3 for upgraded speed
		
			
			facingleft = true;
			facingright = false;
		}
		public function keydownhandler(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.R)
			{
				trace("x: " + x + " y: " + y );
				trace("enemy x: " + EnemyArray.getArray()[0].x + " enemy y: " + EnemyArray.getArray()[0].y );
				
			}
			
			
			if (e.keyCode == 80)//  p/jump
			{
				jumppressed = true;
				if (!jumping && !injump)
				{
					
					jumping = true;

					injump = true;
				}
			}
			if (e.keyCode==79)// o/bubbles
			{
				blowingbubbles = true;
			}	
			if (e.keyCode==37 ||e.keyCode==Keyboard.A) //left
			{
				movingleft = true;
				movingright = false;
				facingleft = true;
				facingright = false;
				speedframe++;
				
			}
			if (e.keyCode==39 || e.keyCode==Keyboard.D) //right
			{
				movingright = true;
				movingleft = false;
				facingright = true;
				facingleft = false;
				speedframe++;
				
			}
			if (e.keyCode==32) // space/pause
			{
				if (pause)
				{
					pause = false;
				}
				else
				{
					pause = true;
				}
			}
			
		}
		public function keyuphandler(e:KeyboardEvent):void
		{
			
			//trace("keyup"+e.keyCode);
			if (e.keyCode == 79 )
			{
				
				blowingbubbles = false;
			
			}
			if (e.keyCode == 37||e.keyCode==Keyboard.A)
			{
				movingleft = false;
				speedframe = 0;
			
			}
			if (e.keyCode == 39||e.keyCode==Keyboard.D)
			{
				movingright = false;
				speedframe = 0;
			
			}
			if (e.keyCode == Keyboard.P)
			{
				jumppressed = false;
			}
		}
		public function enterframe(e:Event):void
		{
			//if (myframe == stage.frameRate)
			//{
			//	myframe = 0;
			//}
			if (!pause)
			{
				
				if (speedframe >= 1.5)
				{
					speedframe = 1.5;
				}
				if (speedframe == 1.5)
				{
					force = 5;
				}
				else
				{
					force = 1;
				}
				if (y + blockl.height <= 0)
				{
					y = stage.stageHeight + PlayerConstants.PLAYERHEIGHT;
				}
				//var bubble:Bubble = new Bubble(x, y, "left", pause, mute);
				//bubbles = bubble.getBubbles();
				/*if ((jumppressed && (y>=stage.stageHeight-blockr.height||(y==stage.stageHeight-blockr.height-120&&(x>=200-blockr.width && x<=300)))))//change to array for all platforms
				{
					if (!mute)
					{
						jump.play();
					}
					yvelocity = 16;
					jumping = false;
					xvelocity = 1;
				}
				*/
				if (jumppressed && y >= stage.stageHeight - PlayerConstants.PLAYERHEIGHT)
				{
					if (!mute)
					{
						jump.play();
					}
					yvelocity = 16;
					jumping = false;
					xvelocity = 1;
				}
				for (var k:int = 0; k < BlockArray.getlength(); k++)
				{
					if (jumppressed && y+PlayerConstants.PLAYERHEIGHT == BlockArray.getArray()[k].y && x+PlayerConstants.PLAYERWIDTH >= BlockArray.getArray()[k].x && x <= BlockArray.getArray()[k].x + BlockArray.WIDTH )
					{
						if (!mute)
						{
							jump.play();
						}
						yvelocity = 16;
						jumping = false;
						xvelocity = 1;
						break;
					}
				}
				//for (var m:int = 0; m < WallArray.getlength(); m++ )
				//{
				//	if (jumppressed && y+PlayerConstants.PLAYERHEIGHT == WallArray.getArray()[m].y && x+PlayerConstants.PLAYERWIDTH >= WallArray.getArray()[m].x && x <= WallArray.getArray()[m].x + BlockArray.WIDTH )
				//	{
				//		if (!mute)
				//		{
				//			jump.play();
				//		}
				//		yvelocity = 16;
				//		jumping = false;
				//		xvelocity = 1;
				//		break;
				//	}
				//}
				
				y -= yvelocity;
				
				if (movingleft)
				{
					x -= xvelocity;
					addChild(blockl);
					
					if(x-speed>0)
					{
						x -= speed;
						
					}
					else
					{
						x=0;
					}
				}
				if (movingright)
				{
					x += xvelocity;
					addChild(blockr);
					if(x+speed<stage.stageWidth-PlayerConstants.PLAYERWIDTH)
					{
						x += speed;
						
					}
					else
					{
						x = stage.stageWidth - PlayerConstants.PLAYERWIDTH;
					}
				}
				
					//&& stage.frameRate % myframe == 10
				
				if (blowingbubbles && myframe-mybubble>=waitingbubble )
				{
					myframe = 0;
					mybubble = myframe;
					var dir:String;
					var newx:int;
					if (facingleft)
					{
						dir = "left";
						
						 
						newx = x - BubbleArray.WIDTH;
					}
					else
					{
						dir = "right";
						newx = x+PlayerConstants.PLAYERWIDTH;
					}
					
					var bubble:Bubble = new Bubble(newx, y, dir, pause, mute, bubbleID, BubbleMode.EMPTY,200);
					BubbleArray.add(bubble);
					bubbleID++;
					
					stage.addChild(bubble);
					//stage.focus = stage;
					
					
					
				}
				
				yvelocity--;
				if (yvelocity <= 0)
				{
			
			
					for (var i:int = 0; i < BubbleArray.getlength(); i++ )
					{
						if (jumppressed && bottomcollide(BubbleArray.getArray()[i].x, BubbleArray.getArray()[i].x + BubbleArray.WIDTH, BubbleArray.getArray()[i].y))
						{
							//force = 0;
							y = BubbleArray.getArray()[i].y-PlayerConstants.PLAYERHEIGHT;
							if (!mute)
							{
								jump.play();
							}
							yvelocity = 16;
							jumping = false;
							injump=false
							xvelocity = 1;
							break;
						}
						else if (!jumppressed && bottomcollide(BubbleArray.getArray()[i].x, BubbleArray.getArray()[i].x + BubbleArray.WIDTH, BubbleArray.getArray()[i].y))
						{
							var dir1:String;
							if (BubbleArray.getArray()[i].Mode == BubbleMode.ITEMED)
							{
								
								if (movingleft || facingleft)
								{
									dir1 = "right";
								}
								else
								{
									dir1="left";
								}
								//BubbleArray.getArray()[i].addChild(new Projectile(dir1));
							}
							
							//add thingy to pop all touching bubbles 
							
							BubbleArray.getArray()[i].pop1(0,dir1);
							//force = 0;
						}
						/*else if(force<=1 && BubbleArray.getArray()[i].mode==BubbleMode.GOINGUP && collides(BubbleArray.getArray()[i].x, BubbleArray.getArray()[i].y, BubbleArray.WIDTH,BubbleArray.HEIGHT) )
						{
							if (facingleft && BubbleArray.getArray()[i].x>0)
							{
								BubbleArray.getArray()[i].x -= 1;
							}
							else if (facingright && BubbleArray.getArray()[i].x+BubbleArray.WIDTH<stage.stageWidth)
							{
								 BubbleArray.getArray()[i].x += 1;
							}
							else if (facingleft && BubbleArray.getArray()[i].x <= 0)
							{
								BubbleArray.getArray()[i].pop1(0,"right");
							}
							else if (facingright && BubbleArray.getArray()[i].x>=stage.stageWidth)
							{
								BubbleArray.getArray()[i].pop1(0,"left");
							}
						}*/
						else if (force>=0 && BubbleArray.getArray()[i].mode==BubbleMode.GOINGUP && collides(BubbleArray.getArray()[i].x, BubbleArray.getArray()[i].y, BubbleArray.WIDTH, BubbleArray.HEIGHT))
						{
							//change force to 5, instead of 0
							//add a force so that doesnt always pop when touching
							var dir1:String;
							if (BubbleArray.getArray()[i].Mode == BubbleMode.ITEMED)
							{
								
								if (movingleft || facingleft)
								{
									dir1 = "right";
								}
								else
								{
									dir1="left";
								}
								//BubbleArray.getArray()[i].addChild(new Projectile(dir1));
							}
							BubbleArray.getArray()[i].pop1(0,dir1);
						}
					}
					for (var i:int = 0; i < EnemyArray.getlength(); i++ )
					{
						if (jumppressed && EnemyArray.getArray()[i].mode==EnemyModes.BUBBLED && bottomcollide(EnemyArray.getArray()[i].x, EnemyArray.getArray()[i].x + BubbleArray.WIDTH, EnemyArray.getArray()[i].y))
						{
							//force = 0;
							y = EnemyArray.getArray()[i].y-PlayerConstants.PLAYERHEIGHT;
							if (!mute)
							{
								jump.play();
							}
							yvelocity = 16;
							jumping = false;
							injump=false
							xvelocity = 1;
							break;
						}
						else if (!jumppressed && EnemyArray.getArray()[i].mode == EnemyModes.BUBBLED && bottomcollide(EnemyArray.getArray()[i].x, EnemyArray.getArray()[i].x + BubbleArray.WIDTH, EnemyArray.getArray()[i].y))
						{
							//force = 0;
							EnemyArray.getArray()[i].kill();
						}
						else if (force>=0 && EnemyArray.getArray()[i].mode==EnemyModes.BUBBLED && collides(EnemyArray.getArray()[i].x, EnemyArray.getArray()[i].y, BubbleArray.WIDTH,BubbleArray.HEIGHT))
						{
							//change force to 5
							//add a force so that doesnt always pop when touching
							EnemyArray.getArray()[i].kill();
						}
						/*else if(force<=1 && EnemyArray.getArray()[i].mode==EnemyModes.BUBBLED && collides(EnemyArray.getArray()[i].x, EnemyArray.getArray()[i].y, BubbleArray.WIDTH,BubbleArray.HEIGHT) )
						{
							if (facingleft)
							{
								EnemyArray.getArray()[i].x -= 1;
							}
							else if (facingright)
							{
								EnemyArray.getArray()[i].x += 1;
							}
						}*/
						else if (EnemyArray.getArray()[i].mode != EnemyModes.BUBBLED && collides(EnemyArray.getArray()[i].x, EnemyArray.getArray()[i].y, EnemyArray.WIDTH, EnemyArray.HEIGHT))
						{
							//dead
						}
					}
					for (var l:int = 0; l < BlockArray.getlength(); l++ )
					{
						
						if (bottomcollide(BlockArray.getArray()[l].x,BlockArray.getArray()[l].x+BlockArray.WIDTH,BlockArray.getArray()[l].y+10))
						{
						/*	if (BlockArray.getArray()[l].mode == "stairs")
							{
								//fix first and last stairs
								if (BlockArray.getArray()[l].isLast != true)
								{
									if (facingright)
									{
										y = BlockArray.getArray()[l].y-PlayerConstants.PLAYERHEIGHT-10;
										injump = false;
										yvelocity = 0;
										xvelocity = 0;
										break;
									}
									else if(facingleft)
									{
										y = BlockArray.getArray()[l].y-PlayerConstants.PLAYERHEIGHT-10;
										injump = false;
										yvelocity = 0;
										xvelocity = 0;
										break;
									}
								}
								else
								{
									y = BlockArray.getArray()[l].y-PlayerConstants.PLAYERHEIGHT-10;
									injump = false;
									yvelocity = 0;
									xvelocity = 0;
									break;
								}
							}
							else
							{*/
								y = BlockArray.getArray()[l].y - PlayerConstants.PLAYERHEIGHT;//-BlockArray.HEIGHT;
								injump = false;
								yvelocity = 0;
								xvelocity = 0;
								break;
		//					}
						}
							
					}
					
				}
				
				
				//if (y >stage.stageHeight-PlayerConstants.PLAYERHEIGHT)
				//{
				//	
				//	y = stage.stageHeight - PlayerConstants.PLAYERHEIGHT;
				//	injump = false;
				//	//jumping = false;
				//	yvelocity = 0;
				//	xvelocity = 0;
				//}
				
				if (movingright)
				{
					for (var m:int = 0; m < Obstructions.obstructions.length;m++ )
					{
						if (x + PlayerConstants.PLAYERWIDTH >= Obstructions.obstructions[m].x && x + PlayerConstants.PLAYERWIDTH <= Obstructions.obstructions[m].x + BlockArray.WIDTH && y + PlayerConstants.PLAYERHEIGHT > Obstructions.obstructions[m].y && y + PlayerConstants.PLAYERHEIGHT <= Obstructions.obstructions[m].y + BlockArray.HEIGHT)//on left, going right
						{
							
							x = Obstructions.obstructions[m].x - PlayerConstants.PLAYERWIDTH;
							
							
							break;
						}
					
					
					}
				}
				if (movingleft)
				{
					for (var m:int = 0; m < Obstructions.obstructions.length;m++ )
					{
						if (x>= Obstructions.obstructions[m].x && x <= Obstructions.obstructions[m].x+BlockArray.WIDTH && y+PlayerConstants.PLAYERHEIGHT> Obstructions.obstructions[m].y && y+PlayerConstants.PLAYERHEIGHT<= Obstructions.obstructions[m].y+BlockArray.HEIGHT)//on left, going right
						{
							x = Obstructions.obstructions[m].x +BlockArray.WIDTH;
						
							
							break;
						}
					
						
					}
				}
				/*if (movingright)
				{
					for (var m:int = 0; m < O;m++ )
					{
						if (x+EnemyArray.WIDTH>= BlockArray.getArray()[m].x && x+ EnemyArray.WIDTH<=BlockArray.getArray()[m].x+BlockArray.WIDTH && y+PlayerConstants.PLAYERHEIGHT> BlockArray.getArray()[m].y && y+PlayerConstants.PLAYERHEIGHT<= BlockArray.getArray()[m].y+BlockArray.HEIGHT)//on left, going right
						{
							
							x = BlockArray.getArray()[m].x - EnemyArray.WIDTH;
							
							
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
						
							
							break;
						}
					
						
					}
				}*/
				/*for (var m:int = 0; m < WallArray.getlength();m++ )//needs work, leaving this for now
				{
					if (y + PlayerConstants.PLAYERHEIGHT > WallArray.getArray()[m].y && y + PlayerConstants.PLAYERHEIGHT <= WallArray.getArray()[m].y + BlockArray.HEIGHT && x > WallArray.getArray()[m].x && x<=WallArray.getArray()[m].x+BlockArray.WIDTH)//on top
					{
						y = WallArray.getArray()[m].y - PlayerConstants.PLAYERHEIGHT;
						//injump = false;
					//jumping = false;
						yvelocity = 0;
						xvelocity = 0;
						
						break;
					}
					
					
				}
				for (var m:int = 0; m < WallArray.getlength();m++ )
				{
					if (x+PlayerConstants.PLAYERWIDTH> WallArray.getArray()[m].x && x+ PlayerConstants.PLAYERWIDTH<=WallArray.getArray()[m].x+BlockArray.WIDTH && y> WallArray.getArray()[m].y-10 && y< WallArray.getArray()[m].y+BlockArray.HEIGHT+10)//on left, going right
					{
						x = WallArray.getArray()[m].x - PlayerConstants.PLAYERWIDTH;
						break;
					}
					
					
				}
				for (var m:int = 0; m < WallArray.getlength();m++ )
				{
					if (x>= WallArray.getArray()[m].x && x <= WallArray.getArray()[m].x+BlockArray.WIDTH && y> WallArray.getArray()[m].y-10 && y< WallArray.getArray()[m].y+BlockArray.HEIGHT+10)//on left, going right
					{
						x = WallArray.getArray()[m].x +BlockArray.WIDTH;
						break;
					}
					
					
				}
				*/
				
				
			}
			myframe++;
		}
		
		
		
		private function bottomcollide(x1:int,x2:int, y1:int):Boolean
		{
			
			if (x+blockr.width >= x1 && x <= x2 && y+PlayerConstants.PLAYERHEIGHT<=y1+1 && y+PlayerConstants.PLAYERHEIGHT>=y1-30)
			{
				//jumping = true; trampoliny move
		
				return true;
			}
			return false;
		}
		private function collides(x:int,y:int,width:int,height:int):Boolean
		{
			if (x + width >= this.x - 5 && x <= this.x + PlayerConstants.PLAYERWIDTH +5 && y + height >= this.y - 5 && y <= this.y + PlayerConstants.PLAYERHEIGHT - 5)
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