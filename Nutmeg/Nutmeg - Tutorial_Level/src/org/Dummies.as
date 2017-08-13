package  
{
	import org.flixel.*;

	public class Dummies extends FlxGroup
	{
		public function Dummies()
		{
			super();
		}
		
		public function addDummy(x:int, y:int):void
		{
			var tempDummy:Dummy = new Dummy(x, y);
				
			add(tempDummy);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}