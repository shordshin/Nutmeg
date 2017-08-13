package  
{
	import org.flixel.FlxSprite;
	import org.flixel.*;

	public class Checkpoint extends FlxSprite
	{
		[Embed(source = '../assets/Checkpoint.png')] private var flagPNG:Class;
		
		public function Checkpoint(X:int, Y:int)
		{
			super(X * 16, Y * 16, flagPNG);
			loadGraphic(flagPNG, false, false, 16, 16, false);
			addAnimation("unhit", [1], 0, true);
			play("unhit");
			allowCollisions = FlxObject.ANY;
		}
		
	}

}