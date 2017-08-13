package  
{
	import org.flixel.*;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Linear;

	public class Bird extends FlxSprite
	{
		[Embed(source="../assets/flower.png")] private var BirdPNG:Class;
		
		public var isDying:Boolean = false;
		
		public function Bird(x:int, y:int)
		{
			super(x * 16, y * 16);
			
			loadGraphic(BirdPNG, true, true, 16, 16);
			
			facing = FlxObject.RIGHT;
			
			addAnimation("stop", [0, 1], 10, true);
			play("stop");
			
			
			velocity.x = 30;
			
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
				
			}
			else
			{
				facing = FlxObject.RIGHT;
				
				velocity.x = 20;
				
			}
		}
		
	}

}