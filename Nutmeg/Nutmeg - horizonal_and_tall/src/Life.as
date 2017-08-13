package  
{
	import org.flixel.*;

	public class Life extends FlxSprite
	{
		[Embed(source="../assets/lives.png")] private var lifePNG:Class;
		
		public function Life(x:int, y:int)
		{
			super(x, y);
			loadGraphic(lifePNG, false, false, 16, 16, false);
			allowCollisions = FlxObject.NONE;
			//immovable = true;
		}
		
		
	}


}