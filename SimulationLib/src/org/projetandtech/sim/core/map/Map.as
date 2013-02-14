package org.projetandtech.sim.core.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import org.flexunit.internals.matchers.Each;
	import org.projetandtech.sim.core.tools.Forme;
	import org.projetandtech.sim.core.IdentifiantMgr;
	import org.projetandtech.sim.core.Simulation;
	import org.projetandtech.sim.core.map.items.EtatItem;
	import org.projetandtech.sim.core.map.items.Item;
	import org.projetandtech.sim.core.map.items.TypeItem;
	import org.projetandtech.sim.core.map.items.TypeItemMgr;
	import org.projetandtech.sim.core.parcours.Parcours;
	import org.projetandtech.sim.core.robot.Robot;
	import org.projetandtech.sim.core.tools.Out;
	import org.projetandtech.sim.core.tools.XMLExtractor;

	public class Map extends EventDispatcher
	{
		
		public var tempdebugParcours:Parcours = new Parcours();
		private var _dimensions:Rectangle;
		private var _imageSource:String;
		private var _obstacles:Vector.<Obstacle>;
		private var _actionPoints:Vector.<PointAction>;
		private var _actionZones:Vector.<ZoneAction>;
		private var _passagePoints:Vector.<PointPassage>;
		private var _items:Vector.<Item>;
		private var _sim:Simulation;
		private var _typesItems:TypeItemMgr;
		private var _isLoaded:Boolean;
		private var _ratioX:Number;
		private var _ratioY:Number;
		private var _areaWidth:Number;
		private var _areaHeight:Number;
		private var _imageWidth:Number;
		private var _imageHeight:Number;
		
		
		
		private var _idMgr:IdentifiantMgr;
		
		
		private var _robotAlliePrincipal:Robot;
		private var _robotAllieSecondaire:Robot;
		private var _robotEnnemiPrincipal:Robot;
		private var _robotEnnemiSecondaire:Robot;
		//////////////////////////////
		//////   CONSTRUCTEUR  //////
		/////////////////////////////
		
		
		public function Map(sim:Simulation)
		{
			_sim = sim;
			_idMgr = new IdentifiantMgr();
			_dimensions = new Rectangle();
			_imageSource = ""; 
			_isLoaded = false;
			
			
			_items = new Vector.<Item>();
			_actionPoints = new Vector.<PointAction>();
			_actionZones = new Vector.<ZoneAction>();
			_obstacles = new Vector.<Obstacle>();
			_passagePoints = new Vector.<PointPassage>();
			
			this._typesItems = new TypeItemMgr();
			
			
			_robotAlliePrincipal = null;
			_robotAllieSecondaire = null;
			_robotEnnemiPrincipal = null;
			_robotEnnemiSecondaire = null;
		}
		
		///////////////////////////////////
		//////   METHODES PUBLIQUES  //////
		///////////////////////////////////
		
		public function coord(x:Number,y:Number):Point{
			return new Point(_dimensions.x + x * ratioX,
							 _dimensions.y + y * ratioY);
		}
		
		public function coordX(x:Number):Number{
			return _dimensions.x + x * ratioX;
		}
		
		public function coordY(y:Number):Number{
			return _dimensions.y + y * ratioY;
		}
		
		
		public function coord2posX(x:Number):Number{
			return (x - _dimensions.x)/ratioX;
		}
		
		public function coord2posY(y:Number):Number{
			return (y - _dimensions.y)/ratioY;
		}
		
		///////////////////////////////////
		//////   METHODES STATIQUES  //////
		///////////////////////////////////
		
		
		////////////////////////
		/// SERIALISATION //////
		////////////////////////
		
		
		public function load(datasXML:XML):void{
			try{
				// On affecte les attributs a la map
				_imageSource = XMLExtractor.getString(datasXML,"@imagePath");
				_dimensions.width = XMLExtractor.getNumber(datasXML,"@dimensionX");
				_dimensions.height = XMLExtractor.getNumber(datasXML,"@dimensionY");
				_dimensions.x = XMLExtractor.getNumber(datasXML,"@origineX");
				_dimensions.y = XMLExtractor.getNumber(datasXML,"@origineY");
				_areaWidth = XMLExtractor.getNumber(datasXML,"@aire_img_largeur");
				_areaHeight = XMLExtractor.getNumber(datasXML,"@aire_img_hauteur");
				_imageWidth = XMLExtractor.getNumber(datasXML,"@image_largeur");
				_imageHeight = XMLExtractor.getNumber(datasXML,"@image_hauteur");
			}
			catch(err:Error){
				Out.error(err);
			}
			_ratioX = _areaWidth/_dimensions.width;
			_ratioY = _areaHeight/_dimensions.height;
			
			Out.debug(_dimensions);
			
			// Chargement des divers elements
			loadItems(new XML(datasXML.child("items")));
			loadPointsPassage(new XML(datasXML.child("points_passage")));
			loadPointsAction(new XML(datasXML.child("points_action")));
			loadZonesAction(new XML(datasXML.child("zones_action")));
			loadObstacles(new XML(datasXML.child("obstacles")));
			loadRobots(new XML(datasXML.child("robots")));
			// On notifie que tout est chargé
			notifyLoadedState();
		}
		
		public function save():XMLList{
			// TODO
			return null;
		}
		
		
		private function loadItems(datasXML:XML):void{
			Out.debug("Chargement des items de la map");
			
			//On parcours la liste XML des items.
			for each( var itemXML:XML in datasXML.children()){
				
				try{
					// Attributs existants. On créé l'item.
					
					// Recuperation de la position
					var itemPosX:Number = XMLExtractor.getNumber(itemXML,"@x"); 
					var itemPosY:Number = XMLExtractor.getNumber(itemXML,"@y"); 
					
					
					// Recuperation de l'identifiant propre
					var itemID:String = XMLExtractor.getString(itemXML,"@id"); 
					

					// Recuperation du type
					var itemType:String = XMLExtractor.getString(itemXML,"@type"); 
					var type:TypeItem = _typesItems.getType(itemType);
					
					// On verifie que le type existe
					if( type == null){
						Out.error("Chargement XML Item: type " + itemType + " introuvable pour l'item (ref: " + itemID + ":" + itemXML.toXMLString() + ")"); 
					}
					else{
						// Si le type existe
						
						// On recherche l'etat initial. Si il n'est pas spécifié, on utilise l'etat initial
						// par défaut du type.
						var itemEtatInitName:String = XMLExtractor.getStringFacultatif(itemXML,"@etatInitial"); 
						var itemEtatInit:EtatItem = type.getEtat(itemEtatInitName) || type.etatInitial; 
						
						// On créé l'objet, et l'enregistre dans le gestionnaire d'identifiants
						var item:Item = new Item(itemID, type, itemEtatInit, itemPosX,itemPosY);
						this._items.push(item);
						_idMgr.createIdentifiant(item,itemID);
						
					}
				}catch(err:Error){
					Out.error(err);
				}
			}
		}
		
		public function loadTypeItems(datasXML:XML):void{
			_typesItems.load(datasXML);
		}
		
		private function loadPointsPassage(datasXML:XML):void{
			Out.debug("Chargement des points de passage de la map");
			
			//On parcours la liste XML des points de passages.
			for each( var ppXML:XML in datasXML.children()){
				
				try{
					// Recuperation de la position
					var ppPosX:Number = XMLExtractor.getNumber(ppXML,"@x"); 
					var ppPosY:Number = XMLExtractor.getNumber(ppXML,"@y"); 
					// Recuperation de l'identifiant propre
					var ppID:String = XMLExtractor.getString(ppXML,"@id"); 
					
					// On créé l'objet, et l'enregistre dans le gestionnaire d'identifiants
					var pp:PointPassage = new PointPassage(ppPosX,ppPosY);
					this._passagePoints.push(pp);
					_idMgr.createIdentifiant(pp,ppID);
						
				}catch(err:Error){
					Out.error(err);
				}
			}
			
		}
		
		private function loadPointsAction(datasXML:XML):void{
			Out.debug("Chargement des points d'action de la map");
			
			//On parcours la liste XML des points d'action.
			for each( var paXML:XML in datasXML.children()){
				
				
				try{
					// Recuperation de la position
					var paPosX:Number = XMLExtractor.getNumber(paXML,"@x"); 
					var paPosY:Number = XMLExtractor.getNumber(paXML,"@y"); 
					var paPosO:Number = XMLExtractor.getNumberFacultatif(paXML,"@o"); 
					
					// Recuperation de l'identifiant propre
					var paID:String = XMLExtractor.getString(paXML,"@id"); 	
					
					// Recuperation du nom de l'action de base associée.
					var paActionName:String = XMLExtractor.getString(paXML,"@action_name");
					
					/*
					TODO: 
					
					Ammeliorer le gestionnaire d'action.
					Pour une prise en compte du temps d'action par exemple.
					*/
					
					
					// On créé l'objet, et l'enregistre dans le gestionnaire d'identifiants
					var pa:PointAction = new PointAction(paPosX,paPosY,paPosO,paActionName);
					this._actionPoints.push(pa);
					_idMgr.createIdentifiant(pa,paID);
					
				}catch(err:Error){
					Out.error(err);
				}

			}
			
		}
		
		private function loadZonesAction(datasXML:XML):void{
			Out.debug("Chargement des zones d'action de la map");
			
			//On parcours la liste XML des zones d'action.
			for each( var zaXML:XML in datasXML.children()){
				
				
				try
				{
					// Attributs existants. On créé la zone d'action.
					
					// Recuperation de la position
					var zaPosX:Number = XMLExtractor.getNumber(zaXML,"@x"); 
					var zaPosY:Number = XMLExtractor.getNumber(zaXML,"@y"); 
					var zaPosO:Number = XMLExtractor.getNumberFacultatif(zaXML,"@o"); 
					
					// Recuperation de l'identifiant propre
					var zaID:String = XMLExtractor.getString(zaXML,"@id"); 	
					
					// Recuperation du nom de l'action de base associée.
					var zaActionName:String = XMLExtractor.getString(zaXML,"@action_name");
					
					/*
						TODO: 
						Recuperer les elements liés
					*/
					
					/*
						TODO: 
						Ammeliorer le gestionnaire d'action.
					*/
					
					var zaForme:Forme = XMLExtractor.extractForme(zaXML);
					
					// On créé l'objet, et l'enregistre dans le gestionnaire d'identifiants
					var za:ZoneAction = new ZoneAction(zaPosX,zaPosY,zaPosO,zaActionName,zaForme);
					this._actionZones.push(za);
					_idMgr.createIdentifiant(za,zaID);
					
				}catch(err:Error){
					Out.error(err);
				}
			}
			
		}
		
		private function loadObstacles(datasXML:XML):void{
			
			Out.debug("Chargement des obstacles de la map");
			
			//On parcours la liste XML des obstacles.
			for each( var obstacleXML:XML in datasXML.children()){
				
				try{
					// Recuperation de la position
					var obstaclePosX:Number = XMLExtractor.getNumber(obstacleXML,"@x");
					var obstaclePosY:Number = XMLExtractor.getNumber(obstacleXML,"@y");
					var obstaclePosO:Number = XMLExtractor.getNumberFacultatif(obstacleXML,"@o");
					
					// Recuperation de l'eventuelle durée pendant laquelle persistera l'obstacle
					var obstacleDuree:Number = XMLExtractor.getNumberFacultatif(obstacleXML,"@duree"); 
					
					// Recuperation de l'identifiant propre
					var obstacleID:String =  XMLExtractor.getString(obstacleXML,"@id");
					
					// Recuperation de la forme de l'objet
					var obstacleForme:Forme = XMLExtractor.extractForme(obstacleXML);
					
					
					// On créé l'objet, et l'enregistre dans le gestionnaire d'identifiants
					var obstacle:Obstacle = new Obstacle(obstaclePosX,obstaclePosY,obstaclePosO,obstacleDuree,obstacleForme);
					
		
					this._obstacles.push(obstacle);
					_idMgr.createIdentifiant(obstacle,obstacleID);
					
					
				}catch(err:Error){
					Out.error(err);
				}


					
				
			}
		}
		
		
		/*
		<robot_aliee_principal>...</robot_aliee_principal>
		<robot_aliee_secondaire>...</robot_aliee_secondaire>
		<robot_enemie_principal>...</robot_enemie_principal>
		<robot_enemie_secondaire>...</robot_enemie_secondaire>
		
		*/
		private function loadRobots(datasXML:XML):void{
			// TODO: 
			// Reflexion sur l'eventualité de plusieurs classes 
			//( RobotBase => (RobotSimule / RobotStrat / RobotNull / RobotPilote / ... )
			
			try{
				_robotAlliePrincipal = XMLExtractor.extractRobot(datasXML,"robot_aliee_principal",this);
				_robotAllieSecondaire = XMLExtractor.extractRobot(datasXML,"robot_aliee_secondaire",this);
				_robotEnnemiPrincipal = XMLExtractor.extractRobot(datasXML,"robot_enemie_principal",this);
				_robotEnnemiSecondaire = XMLExtractor.extractRobot(datasXML,"robot_enemie_secondaire",this);
			}
			catch(err:Error){
				Out.error(err);
			}
		}
		

		
		private function notifyLoadedState():void{
			this._isLoaded = true;
			dispatchEvent(new Event("LOADED"));
		}

		
		
		
		
		//////////////////////////////
		//////GETTERS ET SETTERS/////
		/////////////////////////////
		
		
		[Bindable]
		public function get imageSource():String
		{
			return _imageSource;
		}

		public function set imageSource(value:String):void
		{
			_imageSource = value;
		}

		
		public function get isLoaded():Boolean
		{
			return _isLoaded;	
		}

		public function get dimensions():Rectangle
		{
			return _dimensions;
		}

		public function set dimensions(value:Rectangle):void
		{
			_dimensions = value;
		}

		public function get obstacles():Vector.<Obstacle>
		{
			return _obstacles;
		}

		public function set obstacles(value:Vector.<Obstacle>):void
		{
			_obstacles = value;
		}

		public function get actionPoints():Vector.<PointAction>
		{
			return _actionPoints;
		}

		public function set actionPoints(value:Vector.<PointAction>):void
		{
			_actionPoints = value;
		}

		public function get actionZones():Vector.<ZoneAction>
		{
			return _actionZones;
		}

		public function set actionZones(value:Vector.<ZoneAction>):void
		{
			_actionZones = value;
		}

		public function get items():Vector.<Item>
		{
			return _items;
		}

		public function set items(value:Vector.<Item>):void
		{
			_items = value;
		}

		public function get typesItems():TypeItemMgr
		{
			return _typesItems;
		}

		public function set typesItems(value:TypeItemMgr):void
		{
			_typesItems = value;
		}

		public function get idMgr():IdentifiantMgr
		{
			return _idMgr;
		}

		public function set idMgr(value:IdentifiantMgr):void
		{
			_idMgr = value;
		}

		public function get passagePoints():Vector.<PointPassage>
		{
			return _passagePoints;
		}

		public function set passagePoints(value:Vector.<PointPassage>):void
		{
			_passagePoints = value;
		}

		public function get ratioX():Number
		{
			return _ratioX;
		}

		public function get ratioY():Number
		{
			return _ratioY;
		}
		public function get areaWidth():Number
		{
			return _areaWidth;
		}

		public function get areaHeight():Number
		{
			return _areaHeight;
		}

		public function get imageWidth():Number
		{
			return _imageWidth;
		}

		public function get imageHeight():Number
		{
			return _imageHeight;
		}

		public function get robotAllieSecondaire():Robot
		{
			return _robotAllieSecondaire;
		}

		public function set robotAllieSecondaire(value:Robot):void
		{
			_robotAllieSecondaire = value;
		}

		public function get robotAlliePrincipal():Robot
		{
			return _robotAlliePrincipal;
		}

		public function set robotAlliePrincipal(value:Robot):void
		{
			_robotAlliePrincipal = value;
		}

		public function get robotEnnemiPrincipal():Robot
		{
			return _robotEnnemiPrincipal;
		}

		public function set robotEnnemiPrincipal(value:Robot):void
		{
			_robotEnnemiPrincipal = value;
		}

		public function get robotEnnemiSecondaire():Robot
		{
			return _robotEnnemiSecondaire;
		}

		public function set robotEnnemiSecondaire(value:Robot):void
		{
			_robotEnnemiSecondaire = value;
		}


	}
}