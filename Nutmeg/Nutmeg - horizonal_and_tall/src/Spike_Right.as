package  
{
	import org.flixel.FlxSprite;

	public class Spike_Right extends FlxSprite
	{
		[Embed(source="../assets/spike_right.png")] private var spike_rightPNG:Class;
		
		public function Spike_Right(X:int, Y:int)
		{
			super(X * 16, Y * 16, spike_rightPNG);
			loadGraphic(spike_rightPNG, true, false, 16, 16, false);
			addAnimation("idle", [1], 0, false);
			play("idle");
			solid = true;
			immovable = true;

		}
		
	}

}