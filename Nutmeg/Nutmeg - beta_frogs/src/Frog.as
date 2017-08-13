package  
{
	import org.flixel.*;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Linear;

	public class Frog extends FlxSprite
	{
		[Embed(source="../assets/froggy.png")] private var frogPNG:Class;
		
		public var isDying:Boolean = false;
		
		public function Frog(x:int, y:int)
		{
			super(x * 16, y * 16);
			
			loadGraphic(frogPNG, true, true, 16, 16);
			
			facing = FlxObject.RIGHT;
			
			addAnimation("stop", [0], 0, false);
			play("stop");
			
			
			acceleration.y = 70;
			velocity.x = 30;
			
			if (isTouching(FlxObject.FLOOR) == false && isDying == false)
			{
				addAnimation("jump", [1], 0, false);
				
				play("jump");
			}
			
			else if (isTouching(FlxObject.FLOOR) == true && isDying == false) 
			{
				play("stop");
			}
			
			
		}
		
		override public function kill():void
		{
			FlxG.play(catty2SFX, 0.5, false, true);
			
			isDying = true;
			
			frame = 2;
			
			velocity.x = 0;
			velocity.y = 0;
			
			angle = 180;
			
			TweenMax.to(this, 1.5, { bezier: [ {x:"64", y:"-64"}, {x:"80", y:"200"} ], onComplete: removeSprite } );
		}
			
		private function removeSprite():void
		{
			exists = false;
		}
		
		override public function update():void
		{
			super.update();
			
			//	Check the tiles on the left / right of it
			
			var tx:int = int(x / 16);
			var ty:int = int(y / 16);
			
			if (facing == FlxObject.LEFT)
			{
				//	31 is the Collide Index of our Tilemap (which sadly isn't exposed in Flixel 2.5, so is hard-coded here. Not ideal I appreciate)
				if (Registry.map.getTile(((x+15) / 16) - 1, ty) >= 31)
				{
					turnAround();
					return;
				}
			}
			else
			{
				//	31 is the Collide Index of our Tilemap (which sadly isn't exposed in Flixel 2.5, so is hard-coded here. Not ideal I appreciate)
				if (Registry.map.getTile(tx + 1, ty) >= 31)
				{
					turnAround();
					return;
				}
			}
			
			if (velocity.y == 0)
				{
					velocity.y = -70;
				}
			
			/*	Check the tiles below it
			
			if (isTouching(FlxObject.FLOOR) == false && isDying == false)
			{
				turnAround();
			}
			*/
		}
		
		private function turnAround():void
		{
			if (facing == FlxObject.RIGHT)
			{
				facing = FlxObject.LEFT;
				
				velocity.x = -20;
				
				if (velocity.y == 0)
				{
					velocity.y = -70;
				}
				
			}
			else
			{
				facing = FlxObject.RIGHT;
				
				velocity.x = 20;
				
			}
		}
		
	}

}