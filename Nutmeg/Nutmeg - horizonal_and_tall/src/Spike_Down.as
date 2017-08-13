package  
{
	import org.flixel.FlxSprite;

	public class Spike_Down extends FlxSprite
	{
		[Embed(source="../assets/spike_down.png")] private var spike_downPNG:Class;
		
		public function Spike_Down(X:int, Y:int)
		{
			super(X * 16, Y * 16, spike_downPNG);
			loadGraphic(spike_downPNG, true, false, 16, 16, false);
			addAnimation("idle", [1], 0, false);
			play("idle");
			solid = true;

		}
		
	}

}