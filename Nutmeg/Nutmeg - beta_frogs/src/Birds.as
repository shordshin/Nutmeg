package  
{
	import org.flixel.*;

	public class Birds extends FlxGroup
	{
		public function Birds()
		{
			super();
		}
		
		public function addBird(x:int, y:int):void
		{
			var tempBirds:Bird = new Bird(x, y);
				
			add(tempBirds);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}