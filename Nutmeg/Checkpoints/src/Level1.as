package  
{
	import org.flixel.*;

	public class Level1 extends FlxGroup
	{
		[Embed(source = "../assets/mapCSV_Level1_Sky.csv", mimeType = "application/octet-stream")] public var skyCSV:Class;
		[Embed(source = "../assets/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		[Embed(source = "../assets/mapCSV_Level1_Stars.csv", mimeType = "application/octet-stream")] public var starsCSV:Class;
		[Embed(source = "../assets/backdrop.png")] public var skyTilesPNG:Class;
		[Embed(source = "../assets/tiles.png")] public var mapTilesPNG:Class;
		[Embed(source = "../assets/star.png")] public var starPNG:Class;
		
		//private var _instructText: FlxText;
		//public var _sign:Sign;
		
		public var sky:FlxTilemap;
		public var map:FlxTilemap;
		public var stars:FlxGroup;
		public var cats:Cats;
		public var dogs:Dogs;
		public var check:Checkpoint;
		public var player:Player;
		
		private var elevator1:Elevator;
		private var elevator2:Elevator;
		//private var registry:Registry;
		
		public var width:int;
		public var height:int;
		public var totalStars:int;
		
		//Set these coordinates to tell the Player where to spawn in the Level
		public var playerStartx:int = 16;
		public var playerStarty:int = 1519;
		
		
		public function Level1(skipCats:Boolean = false) 
		{
			super();
			
			sky = new FlxTilemap;
			sky.loadMap(new skyCSV, skyTilesPNG, 192, 336);
			sky.setTileProperties(1, FlxObject.NONE);
			sky.setTileProperties(2, FlxObject.NONE);
			sky.setTileProperties(3, FlxObject.NONE);
			sky.setTileProperties(4, FlxObject.NONE);
			sky.setTileProperties(5, FlxObject.NONE);
			sky.setTileProperties(6, FlxObject.NONE);
			sky.setTileProperties(7, FlxObject.NONE);
			sky.scrollFactor.x = 1.0;
			
			map = new FlxTilemap;
			map.loadMap(new mapCSV, mapTilesPNG, 16, 16, 0, 0, 1, 31);
			
			//	Makes these tiles as allowed to be jumped UP through (but collide at all other angles)
			map.setTileProperties(40, FlxObject.UP, null, null, 4);
			
			// Sets the exit point for your map, numbers are multiplied by 16 so they equal the tile width
			Registry.map = map;
			Registry.levelExit = new FlxPoint(20 * 16, 95 * 16);
			
			width = map.width;
			height = map.height;
			
			// To use Elevator set tile location X, Y, Horizontal movement in tiles, Vertical movement in tiles
			elevator1 = new Elevator(26, 6, 10, 0);
			elevator2 = new Elevator(82, 6, 0, 7);
			

			
			add(sky);
			add(map);
			add(elevator1);
			add(elevator2);

			
			parseStars();
			
			if (skipCats == false)
			{
				addCats();
				addDogs();
				addCheck();
			}
			
			// THIS IS THE INSTRUCTION TEXT
			/*
			_instructText = new FlxText(100, 100, 1000,
			"HELLO\nThis is some instruction");
			_instructText.setFormat(null, 16, 0xFFec1c79, "left");
			add(_instructText);
			
			_sign = new Sign(14, 8);
			add(_sign);
			*/
		}
		
		private function addCats():void
		{
			cats = new Cats;
			
			//	The 5 enemy cats in this level. You could place them in the map editor, then parse the results (as we do with the stars) rather than fixed coordinates here
			cats.addCat(6, 93);
			cats.addCat(11, 91);
		}
		
		private function addDogs():void
		{
			dogs = new Dogs;
			
			//	The 5 enemy cats in this level. You could place them in the map editor, then parse the results (as we do with the stars) rather than fixed coordinates here
			dogs.addDog(11, 7);
			dogs.addDog(31, 16);
			dogs.addDog(27, 16);
		}
		
		private function addCheck():void
		{
			check = new Checkpoint(17, 95);
			

		}
		
		public function openExit():void
		{
			//	Removes the two blocking tiles on the right of the map and sets them to nothing, so the player can walk through
			map.setTile(20, 95, 0, true);
			map.setTile(19, 95, 0, true);
		}
		
		public function setCheckpoint(x:int, y:int):void
		{
			playerStartx = x;
			playerStarty = y;
		}
		
		private function parseStars():void
		{
			var starMap:FlxTilemap = new FlxTilemap();
			
			starMap.loadMap(new starsCSV, starPNG, 16, 16);
			
			stars = new FlxGroup();
			
			for (var ty:int = 0; ty < starMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < starMap.widthInTiles; tx++)
				{
					if (starMap.getTile(tx, ty) == 1)
					{
						stars.add(new Star(tx, ty));
						totalStars++;
					}
				}
			}
		}
		
	}

}