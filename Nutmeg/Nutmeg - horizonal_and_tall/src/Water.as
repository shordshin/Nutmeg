package  
{
	import org.flixel.FlxSprite;

	public class Water extends FlxSprite
	{
		[Embed(source = '../assets/water.png')] private var waterPNG:Class;
		
		public function Water(X:int, Y:int)
		{
			super(X * 16, Y * 16, waterPNG);
			loadGraphic(waterPNG, true, false, 16, 16, false);
			addAnimation("idle", [0,1,2,3], 10, true);
			play("idle");
			solid = true;

		}
		
	}

}