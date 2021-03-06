package
{
	import flash.display.InteractiveObject;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Linear;
	
	
	public class PlayerDummy extends FlxSprite
	{
		[Embed(source = '../assets/player.png')] private var playerdummyPNG:Class;
		
		private var jumpFX:FlxSound;
		private var walkFX:FlxSound;
		private var deathFX:FlxSound;
		private var startPlayerDummyx:int;
		private var startPlayerDummyy:int;
		public var isDying:Boolean = false;
		private var start:FlxPoint;
		
		public function PlayerDummy(x:Number, y:Number)
		{
			//	As this extends FlxSprite we need to call super() to ensure all of the parent variables we need are created
			super(x, y);
			
			start = new FlxPoint(x, y);
			
			jumpFX = new FlxSound();
			jumpFX.loadEmbedded(jumpSFX);
			
			walkFX = new FlxSound();
			walkFX.loadEmbedded(walkSFX, true);
			
			deathFX = new FlxSound();
			deathFX.loadEmbedded(deathSFX);
			
			//	Load the player.png into this sprite.
			//	The 2nd parameter tells Flixel it's a sprite sheet and it should chop it up into 16x18 sized frames.
			loadGraphic(playerdummyPNG, true, true, 16, 18, true);
			
			//	The sprite is 16x18 in size, but that includes a little feather of hair on its head which we don't want to include in collision checks.
			//	We also shave 2 pixels off each side to make it slip through gaps easier. Changing the width/height does NOT change the visual sprite, just the bounding box used for physics.
			width = 12;
			height = 16;
			
			//	Because we've shaved a few pixels off, we need to offset the sprite to compensate
			offset.x = 2;
			offset.y = 2;
			
			//	The Animation sequences we need
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [0, 1, 0, 2], 10, true);
			addAnimation("jump", [1, 3, 0, 3, 2, 3, 0, 3], 10, true);
			addAnimation("hurt", [3], 0, true);
			
			//	Enable the Controls plugin - you only need do this once (unless you destroy the plugin)
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			
			//	Add this sprite to the FlxControl plugin and tell it we want the sprite to accelerate and decelerate smoothly
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			
			//	Sprite will be controlled with the left and right cursor keys
			FlxControl.player1.setCursorControl(false, false, true, true);
			
			//	And SPACE BAR will make them jump up to a maximum of 200 pixels (per second), only when touching the FLOOR
			FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 250, FlxObject.FLOOR, 250, 200);
			
			//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
			//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.
			FlxControl.player1.setMovementSpeed(600, 0, 150, 500, 500, 0);
			
			//	Set a downward gravity of 400px/sec
			FlxControl.player1.setGravity(0, 600);
			
			FlxControl.player1.setSounds(jumpFX, null, walkFX);
			
			//	By default the sprite is facing to the right.
			//	Changing this tells Flixel to flip the sprite frames to show the left-facing ones instead.
			facing = FlxObject.RIGHT;
		}
		
		public function dyingPlayerDummy():void
		{
			play("hurt");
			deathFX.play(true);
			isDying = true;
			
			velocity.x = 0;
			velocity.y = 0;
			
			angle = 180;
			
			//TweenMax.to(this, 1.5, { bezier: [ {x:"64", y:"-64"}, {x:"80", y:"200"} ], onComplete: restart } );
		}
		
		//	We don't actually kill the player at all, we just reset them
		/*public function restart():void
		{
			reset(start.x, start.y);
			angle = 0;
			isDying = false;
		}
		*/
		override public function update():void
		{
			super.update();
			
			if (x < 0)
			{
				x = 0;
			}
			
			//	Have they hit the water?
			if (y > 268 && isDying == false)
			{
				dyingPlayerDummy();
			}
			
			if (touching == FlxObject.FLOOR && isDying == false)
			{
				if (velocity.x != 0)
				{
					play("walk");
				}
				else
				{
					play("idle");
				}
			}
			else if (velocity.y < 0)
			{
				play("jump");
			}
		}
		
	}
}