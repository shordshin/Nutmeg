package  
{
	import org.flixel.FlxSprite;

	public class Star extends FlxSprite
	{
		[Embed(source = '../assets/star.png')] private var starPNG:Class;
		
		public function Star(X:int, Y:int)
		{
			super(X * 16, Y * 16, starPNG);
			loadGraphic(starPNG, true, false, 16, 16, false);
			addAnimation("idle", [0,1,2,3], 10, true);
			play("idle");
			solid = true;

		}
		
	}

}