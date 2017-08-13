package  
{
	import org.flixel.*;

	public class Dogs extends FlxGroup
	{
		public function Dogs()
		{
			super();
		}
		
		public function addDog(x:int, y:int):void
		{
			var tempDog:Dog = new Dog(x, y);
				
			add(tempDog);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}