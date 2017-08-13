package  
{
	import org.flixel.*;

	public class Sign extends FlxSprite
	{
		[Embed(source="../assets/DoStuffsign.png")] private var signPNG:Class;
		
		public function Sign(x:int, y:int)
		{
			super(x * 16, y * 16);
			loadGraphic(signPNG, false, false, 55, 16, false);
			allowCollisions = FlxObject.NONE;
			//immovable = true;
		}
		
		
	}


}