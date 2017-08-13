package  
{
	import org.flixel.FlxSprite;

	public class Spike_Up extends FlxSprite
	{
		[Embed(source="../assets/spike_up.png")] private var spike_upPNG:Class;
		
		public function Spike_Up(X:int, Y:int)
		{
			super(X * 16, Y * 16, spike_upPNG);
			loadGraphic(spike_upPNG, true, false, 16, 16, false);
			addAnimation("idle", [1], 0, false);
			play("idle");
			solid = true;
			//allowCollisions = UP;
			
			
			immovable = true
		}
		
	}
}