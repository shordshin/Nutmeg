package  
{
	import org.flixel.*;

	public class Checkpoints extends FlxGroup
	{
		public function Checkpoints()
		{
			super();
		}
		
		public function addCheckpoint(x:int, y:int):void
		{
			var tempCheckpoint:Checkpoint = new Checkpoint(x, y);
				
			add(tempCheckpoint);
		}
		
		
		override public function update():void
		{
			super.update();
		}
		
	}

}