package  
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var level:Level1;
		//private var level2:Level2;
		private var score:FlxText;
		
		private var starFX:FlxSound;
		private var catDeathFX:FlxSound;
		private var registry:Registry;
		
		private var levelNumber:int = 1;
		
		public function PlayState() 
		{
		}
		
		override public function create():void
		{

			level = new Level1;
			
			
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
			add(level.cats);
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
			
			FlxG.overlap(player, level.cats, hitCat);
			FlxG.overlap(player, level.stars, hitStar);
			
			//	Player walked through end of level exit?
			if (player.x > Registry.levelExit.x && player.y == Registry.levelExit.y)
			{
				levelNumber += 1;
				player.exists = false;
				FlxG.fade(0xff000000, 2, changeState);
				FlxG.music.fadeOut(2);
			}
			
			if (FlxG.keys.T == true)
			{
			trace (player.x, player.y);
			}
		}
		
		private function changeState():void
		{
			FlxG.switchState(new LevelEndState);
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