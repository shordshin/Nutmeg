package  
{
	import org.flixel.*;

	public class Level2 extends FlxGroup
	{
		[Embed(source = "../assets/mapCSV_Level2_Sky.csv", mimeType = "application/octet-stream")] public var skyCSV:Class;
		[Embed(source = "../assets/mapCSV_Level2_Map.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		[Embed(source = "../assets/mapCSV_Level2_Stars.csv", mimeType = "application/octet-stream")] public var starsCSV:Class;
		[Embed(source = "../assets/mapCSV_Level2_Water.csv", mimeType = "application/octet-stream")] public var waterCSV:Class;
		[Embed(source = "../assets/mapCSV_Level2_Spike_Up.csv", mimeType = "application/octet-stream")] public var spike_upCSV:Class;
		[Embed(source = "../assets/mapCSV_Level2_Spike_Down.csv", mimeType = "application/octet-stream")] public var spike_downCSV:Class;
		[Embed(source = "../assets/mapCSV_Level2_Spike_Left.csv", mimeType = "application/octet-stream")] public var spike_leftCSV:Class;
		[Embed(source = "../assets/mapCSV_Level2_Spike_Right.csv", mimeType = "application/octet-stream")] public var spike_rightCSV:Class;
		[Embed(source = "../assets/backdrop.png")] public var skyTilesPNG:Class;
		[Embed(source = "../assets/tiles.png")] public var mapTilesPNG:Class;
		[Embed(source = "../assets/star.png")] public var starPNG:Class;
		[Embed(source = "../assets/water.png")] public var waterPNG:Class;
		[Embed(source = "../assets/spike_up.png")] public var spike_upPNG:Class;
		[Embed(source = "../assets/spike_down.png")] public var spike_downPNG:Class;
		[Embed(source = "../assets/spike_left.png")] public var spike_leftPNG:Class;
		[Embed(source = "../assets/spike_right.png")] public var spike_rightPNG:Class;
		
		//private var _instructText: FlxText;
		//public var _sign:Sign;
		
		public var sky:FlxTilemap;
		public var map:FlxTilemap;
		public var stars:FlxGroup;
		public var water:FlxGroup;
		public var spike_up:FlxGroup;
		public var spike_down:FlxGroup;
		public var spike_left:FlxGroup;
		public var spike_right:FlxGroup;
		public var cats:Cats;
		public var dogs:Dogs;
		public var checkpoints:Checkpoints;
		public var player:Player;
		
		private var elevator1:Elevator;
		private var elevator2:Elevator;
		//private var registry:Registry;
		
		public var width:int;
		public var height:int;
		public var totalStars:int;
		
		//Set these coordinates to tell the Player where to spawn in the Level
		public var playerStartx:int = 161;
		public var playerStarty:int = 14;
		
		
		public function Level2(skipCats:Boolean = false) 
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
			Registry.levelExit = new FlxPoint(20 * 16, 96 * 16);
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
			addCheckpoints();
			
			parseStars();
			parseWater();
			parseSpike_Up();
			parseSpike_Down();
			parseSpike_Left();
			parseSpike_Right();
			
			if (skipCats == false)
			{
				addCats();
				addDogs();
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
			cats.addCat(1, 37);
			//cats.addCat(92, 16);
		}
		
		private function addDogs():void
		{
			dogs = new Dogs;
			
			//	The 5 enemy cats in this level. You could place them in the map editor, then parse the results (as we do with the stars) rather than fixed coordinates here
			dogs.addDog(1, 68);
			dogs.addDog(14, 68);
			dogs.addDog(18, 98);
		}
		
		private function addCheckpoints():void
		{
			checkpoints = new Checkpoints;
			
			checkpoints.addCheckpoint(10, 41);
			//checkpoints.addCheckpoint(10, 10);
			

		}
		
		public function openExit():void
		{
			//	Removes the two blocking tiles on the right of the map and sets them to nothing, so the player can walk through
			map.setTile(20, 94, 0, true);
			map.setTile(20, 95, 0, true);
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
		private function parseSpike_Up():void
		{
			var spike_upMap:FlxTilemap = new FlxTilemap();
			
			spike_upMap.loadMap(new spike_upCSV, spike_upPNG, 16, 16);
			
			spike_up = new FlxGroup();
			
			for (var ty:int = 0; ty < spike_upMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < spike_upMap.widthInTiles; tx++)
				{
					if (spike_upMap.getTile(tx, ty) == 1)
					{
						spike_up.add(new Spike_Up(tx, ty));
						
					}
				}
			}
		}
		private function parseSpike_Down():void
		{
			var spike_downMap:FlxTilemap = new FlxTilemap();
			
			spike_downMap.loadMap(new spike_downCSV, spike_downPNG, 16, 16);
			
			spike_down = new FlxGroup();
			
			for (var ty:int = 0; ty < spike_downMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < spike_downMap.widthInTiles; tx++)
				{
					if (spike_downMap.getTile(tx, ty) == 1)
					{
						spike_down.add(new Spike_Down(tx, ty));
						
					}
				}
			}
		}
		private function parseSpike_Left():void
		{
			var spike_leftMap:FlxTilemap = new FlxTilemap();
			
			spike_leftMap.loadMap(new spike_leftCSV, spike_leftPNG, 16, 16);
			
			spike_left = new FlxGroup();
			
			for (var ty:int = 0; ty < spike_leftMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < spike_leftMap.widthInTiles; tx++)
				{
					if (spike_leftMap.getTile(tx, ty) == 1)
					{
						spike_left .add(new Spike_Left(tx, ty));
						
					}
				}
			}
		}	
		private function parseSpike_Right():void
		{
			var spike_rightMap:FlxTilemap = new FlxTilemap();
			
			spike_rightMap.loadMap(new spike_rightCSV, spike_rightPNG, 16, 16);
			
			spike_right = new FlxGroup();
			
			for (var ty:int = 0; ty < spike_rightMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < spike_rightMap.widthInTiles; tx++)
				{
					if (spike_rightMap.getTile(tx, ty) == 1)
					{
						spike_right.add(new Spike_Right(tx, ty));
						
					}
				}
			}
		}
		
		private function parseWater():void
		{
			var waterMap:FlxTilemap = new FlxTilemap();
			
			waterMap.loadMap(new waterCSV, waterPNG, 16, 16);
			
			water = new FlxGroup();
			
			for (var ty:int = 0; ty < waterMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < waterMap.widthInTiles; tx++)
				{
					if (waterMap.getTile(tx, ty) == 1)
					{
						water.add(new Water(tx, ty));
						
					}
				}
			}
		}
		
	}

}
