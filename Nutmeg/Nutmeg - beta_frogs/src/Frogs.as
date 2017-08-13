package  
{
	import org.flixel.*;

	public class Frogs extends FlxGroup
	{
		public function Frogs()
		{
			super();
		}
		
		public function addFrog(x:int, y:int):void
		{
			var tempFrogs:Frog = new Frog(x, y);
				
			add(tempFrogs);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}