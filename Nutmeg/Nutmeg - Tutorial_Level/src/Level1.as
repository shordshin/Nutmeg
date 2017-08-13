package  
{
	import adobe.utils.CustomActions;
	import org.flixel.*;

	public class Level1 extends FlxGroup
	{
		[Embed(source = "../assets/mapCSV_Level1_Sky.csv", mimeType = "application/octet-stream")] public var skyCSV:Class;
		[Embed(source = "../assets/mapCSV_Level1_Map.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		[Embed(source = "../assets/mapCSV_Level1_Stars.csv", mimeType = "application/octet-stream")] public var starsCSV:Class;
		[Embed(source = "../assets/backdrop.png")] public var skyTilesPNG:Class;
		[Embed(source = "../assets/tiles.png")] public var mapTilesPNG:Class;
		[Embed(source = "../assets/star.png")] public var starPNG:Class;
		
		public var sky:FlxTilemap;
		public var map:FlxTilemap;
		public var stars:FlxGroup;
		public var cats:Cats;
		
		
		private var elevator1:Elevator;
		private var elevator2:Elevator;
		//private var registry:Registry;
		
		public var width:int;
		public var height:int;
		public var totalStars:int;
		
		//Set these coordinates to tell the Player where to spawn in the Level
		public var playerStartx:int = 8;
		public var playerStarty:int = 257;
		
		public var startPlayerDummyx:int = 214;
		public var startPlayerDummyy:int = 194;
		
		public function Level1(skipCats:Boolean = false) 
		{
			super();
			
			sky = new FlxTilemap;
			sky.loadMap(new skyCSV, skyTilesPNG, 192, 336);
			sky.setTileProperties(1, FlxObject.NONE);
			sky.scrollFactor.x = 0.9;
			
			map = new FlxTilemap;
			map.loadMap(new mapCSV, mapTilesPNG, 16, 16, 0, 0, 1, 31);
			
			//	Makes these tiles as allowed to be jumped UP through (but collide at all other angles)
			map.setTileProperties(40, FlxObject.UP, null, null, 4);
			
			// Sets the exit point for your map, numbers are multiplied by 16 so they equal the tile width
			Registry.map = map;
			Registry.levelExit = new FlxPoint(66 * 16, 16 * 16);
			
			width = map.width;
			height = map.height;
			
			// To use Elevator set tile location X, Y, Horizontal movement in tiles, Vertical movement in tiles
			elevator1 = new Elevator(46, 17, 6, 0);
			//elevator2 = new Elevator(82, 6, 0, 7);
			
			add(sky);
			add(map);
			add(elevator1);
			add(elevator2);
			
			parseStars();
			
			if (skipCats == false)
			{
				addCats();
			}
		}
		
		private function addCats():void
		{
			cats = new Cats;
			
			//	The 5 enemy cats in this level. You could place them in the map editor, then parse the results (as we do with the stars) rather than fixed coordinates here
			cats.addCat(7, 9);
			cats.addCat(9, 16);
			cats.addCat(24, 4);
			cats.addCat(29, 4);
			cats.addCat(34, 4);
			cats.addCat(22, 12);
			cats.addCat(36, 16);
			cats.addCat(57, 16);
		}
		
			
		public function openEntrance():void  //Opens entrance after collecting x stars
		{
			map.setTile(10, 16, 0, true);
			map.setTile(10, 15, 0, true);
		}
		public function openEntranceTwo():void
		{
			map.setTile(21, 5, 0, true);
			map.setTile(21, 6, 0, true);
		}
		public function openEntranceThree():void
		{
			map.setTile(35, 16, 0, true);
		}
		public function openExit():void
		{
			//	Removes the two blocking tiles on the right of the map and sets them to nothing, so the player can walk through
			map.setTile(62, 15, 0, true);
			map.setTile(62, 16, 0, true);
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