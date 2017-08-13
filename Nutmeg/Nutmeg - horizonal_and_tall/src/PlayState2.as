package  
{
	import org.flixel.*;
	
	public class PlayState2 extends FlxState
	{
		private var player:Player;
		private var level:Level2;
		private var score:FlxText;
		private var life1:Life;
		private var life2:Life;
		private var life3:Life;
		private var water:Water;
		private var spike_up:Spike_Up;
		private var spike_down:Spike_Down;
		private var spike_left:Spike_Left;
		private var spike_right:Spike_Right;
		
		private var starFX:FlxSound;
		private var catDeathFX:FlxSound;
		private var registry:Registry;
		
		private var levelNumber:int = 2;
		
		public function PlayState2() 
		{
		}
		
		override public function create():void
		{

			level = new Level2;
			
			life1 = new Life(32, 0);
			life1.scrollFactor.x = 0;
			life1.scrollFactor.y = 0;
			
			life2 = new Life(48, 0);
			life2.scrollFactor.x = 0;
			life2.scrollFactor.y = 0;
			
			life3 = new Life(64, 0);
			life3.scrollFactor.x = 0;
			life3.scrollFactor.y = 0;
			
			starFX = new FlxSound();
			starFX.loadEmbedded(starSFX);
			
			catDeathFX = new FlxSound();
			catDeathFX.loadEmbedded(catDeathSFX);
			
			player = new Player(level.playerStartx, level.playerStarty);
			
			score = new FlxText(0, 0, 100);
			score.color = 0xffffffff;
			score.shadow = 0xff000000;
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
			score.text = "0 / " + level.totalStars.toString();
			
			add(level);
			add(player);
			add(level.stars);
			add(level.water);
			add(level.cats);
			add(level.dogs);
			add(level.checkpoints);
			add(level.spike_up);
			add(level.spike_down);
			add(level.spike_left);
			add(level.spike_right);
			
			if (Registry.lives >= 3)
			{
			add(life3);
			add(life2);
			add(life1);
			}
			else if (Registry.lives == 2)
			{
			add(life2);
			add(life1);
			}
			else if (Registry.lives == 1)
			{
				add(life1);
			}
			else if (Registry.lives <= 0)
			{
				
			}
			add(score);
			
			//	Tell flixel how big our game world is
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			
			//	Don't let the camera wander off the edges of the map
			FlxG.camera.setBounds(0, 0, level.width, level.height);
			
			//	The camera will follow the player
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			FlxG.playMusic(level1MusicMP3, 0.5);
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, level);
			FlxG.collide(level.cats, level);
			FlxG.collide(level.dogs, level);
			FlxG.overlap(level.cats, level.water, drownCat);
			FlxG.overlap(level.dogs, level.water, drownDog);
			FlxG.collide(player, level.spike_up, hitSpike_Up);
			FlxG.overlap(player, level.spike_down, hitSpike_Down);
			FlxG.collide(player, level.spike_left, hitSpike_Left);
			FlxG.collide(player, level.spike_right, hitSpike_Right);
			
			FlxG.overlap(player, level.cats, hitCat);
			FlxG.overlap(player, level.dogs, hitDog);
			FlxG.overlap(player, level.stars, hitStar);
			FlxG.overlap(player, level.water, hitWater);
			FlxG.overlap(player, level.checkpoints, setCheckpoint);
			
			//	Player walked through end of level exit?
			if (player.x > Registry.levelExit.x && player.y == Registry.levelExit.y)
			{
				//levelNumber += 1;
				player.exists = false;
				FlxG.fade(0xff000000, 2, changeState);
				FlxG.music.fadeOut(2);
				FlxG.score = 0;
			}
			
			if (FlxG.keys.T == true)
			{
			trace (player.x, player.y);
			}
			
			// Resets the level
			if (FlxG.keys.R == true)
			{
				FlxG.switchState(new PlayState2);
				FlxG.score = 0;
				Registry.lives = 3;
			}
			
			// Sets your spawn point for testing
			if (FlxG.keys.P == true)
			{
				level.setCheckpoint(player.x, player.y);
				trace (level.playerStartx, level.playerStarty);
			}
			
			if (player.alive == false && Registry.lives >= 3)
			{
				respawnPlayer();
				life3.kill();
			}
			else if (player.alive == false && Registry.lives == 2)
			{
				respawnPlayer();
				life2.kill();
			}
			else if (player.alive == false && Registry.lives == 1)
			{
				respawnPlayer();
				life1.kill();
			}
			else if (player.alive == false && Registry.lives == 0)
			{
				loseState();
			}
			
			//Water now an object placed in DAME like stars
			/*
			if (player.y > 271 && player.isDying == false)
			{
				player.dyingPlayer();
			}
			*/
			
			// Prevents from leaving the level left of screen
			if (player.x < 0)
			{
				player.x = 0;
			}
			// Prevents from leaving the level right of screen
			else if (player.x > 320)
			{
				player.x = 320;
			}
		}
		
		private function changeState():void
		{
			FlxG.switchState(new LevelEndState);
		}
		
		private function loseState():void
		{
			FlxG.switchState(new LoseState);
		}
		
		private function respawnPlayer():void
		{
			player = new Player(level.playerStartx, level.playerStarty);
			add(player);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			Registry.lives -= 1;
		}
		
		public function setCheckpoint(p:FlxObject, check:FlxObject):void
		{
			if (player.isDying == false)
				{
					level.setCheckpoint(player.x, player.y);
				}
				else
				{
				
				}
		}
		
		private function resetState():void
		{
			FlxG.switchState(new PlayState);
		}
		
		private function drownCat(cat:FlxObject, water:FlxObject):void
		{
			cat.kill();
		}
		
		private function drownDog(dog:FlxObject, water:FlxObject):void
		{
			dog.kill();
		}
		
		private function hitCat(player:FlxObject, cat:FlxObject):void
		{
			if (Cat(cat).isDying)
			{
				return;
			}
			
			if ((player.y < cat.y) && (Player(player).isDying == false))
			{
				cat.kill();
				catDeathFX.play(true);
				if (FlxG.keys.SPACE)
				{
					player.velocity.y = -300;
				}
				else
				{
					player.velocity.y = -100;
				}
			}
			else if (Player(player).isDying == false)
			{
				Player(player).dyingPlayer();
			}
		}
		
		private function hitDog(player:FlxObject, dog:FlxObject):void
		{
			if (Dog(dog).isDying)
			{
				return;
			}
			
			if ((player.y < dog.y) && (Player(player).isDying == false))
			{
				dog.kill();
				catDeathFX.play(true);
				if (FlxG.keys.SPACE)
				{
					player.velocity.y = -300;
				}
				else
				{
					player.velocity.y = -100;
				}
			}
			else if (Player(player).isDying == false)
			{
				Player(player).dyingPlayer();
			}
		}
		
		private function hitSpike_Up(player:FlxObject, spike_up:FlxObject):void
		{
			if (Player(player).isDying == false)
			{
				Player(player).dyingPlayer();
			}
			else
			{
				
			} 
		}
		private function hitSpike_Down(player:FlxObject, spike_down:FlxObject):void
		{
			if (Player(player).isDying == false)
			{
				Player(player).dyingPlayer();
			}
			else
			{
				
			} 
		}
		private function hitSpike_Left(player:FlxObject, spike_left:FlxObject):void
		{
			if (Player(player).isDying == false)
			{
				Player(player).dyingPlayer();
			}
			else
			{
				
			} 
		}
		private function hitSpike_Right(player:FlxObject, spike_right:FlxObject):void
		{
			if (Player(player).isDying == false)
			{
				Player(player).dyingPlayer();
			}
			else
			{
				
			} 
		}
		private function hitWater(player:FlxObject, water:FlxObject):void
		{
			if (Player(player).isDying == false)
			{
				Player(player).dyingPlayer();
			}
			else
			{
				
			}
		}
		
		private function hitStar(p:FlxObject, star:FlxObject):void
		{
			star.kill();
			
			FlxG.score += 1;
			
			starFX.play(true);
			
			if (FlxG.score == level.totalStars)
			{
				//	Opens the exit at the end of the level
				score.text = FlxG.score.toString() + " / " + level.totalStars.toString() + " EXIT OPEN!";
				level.openExit();
			}
			else
			{
				score.text = FlxG.score.toString() + " / " + level.totalStars.toString();
			}
		}
		
	}

}