package  
{
	import org.flixel.FlxSprite;

	public class Spike_Left extends FlxSprite
	{
		[Embed(source="../assets/spike_left.png")] private var spike_leftPNG:Class;
		
		public function Spike_Left(X:int, Y:int)
		{
			super(X * 16, Y * 16, spike_leftPNG);
			loadGraphic(spike_leftPNG, true, false, 16, 16, false);
			addAnimation("idle", [1], 0, false);
			play("idle");
			solid = true;
			immovable = true;

		}
		
	}

}