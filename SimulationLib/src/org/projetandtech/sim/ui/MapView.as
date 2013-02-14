package org.projetandtech.sim.ui
{
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	
	import org.osmf.elements.ImageLoader;
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.MapElement;
	import org.projetandtech.sim.core.map.items.Item;
	import org.projetandtech.sim.core.parcours.Parcours;
	import org.projetandtech.sim.core.robot.Robot;
	import org.projetandtech.sim.core.tools.Out;
	import org.projetandtech.sim.ui.ParcoursPanelComponents.ParcoursMap;
	
	import spark.primitives.BitmapImage;
	
	
	
	public class MapView extends UIComponent
	{
		
		private var _map:Map;
		private var _img:Loader;
		private var elementsChild:Sprite;

		
		public function MapView(map:Map)
		{
			
			
			this._map = map;
			
			_img = new Loader();
			
			if(_map.isLoaded)
				this.build();
			else
				_map.addEventListener("LOADED",mapLoadedHandler);
			
			super();
		}
		
		
		public function mapLoadedHandler(evt:Event):void{
			build();
		}
		
		
		public function build():void{
			elementsChild = new Sprite();
			Out.debug(this.className + " : Chargement de l'image : " + _map.imageSource);
			var req:URLRequest = new URLRequest(_map.imageSource);
			_img.load(req);
			addChild(_img);
			
			addChild(elementsChild);
			draw();
			addElements();
			
			
						
		}
		
		
		public function addElements():void{
			var ratio:Number = _map.ratioX;
			var comp:MapComponent;
			var elem:MapElement;
			for each(elem in _map.items){
				comp = new MapItemView(this,elem,ratio);
				Out.detail(elem.position.x + " " + elem.position.y);
				comp.x = _map.coordX(elem.position.x);
				comp.y = _map.coordY(elem.position.y);
				addChild(comp);
			}
			
			for each(elem in _map.actionPoints){
				comp = new MapActionPointView(this,elem,ratio);
				Out.detail(elem.position.x + " " + elem.position.y);
				comp.x = _map.coordX(elem.position.x);
				comp.y = _map.coordY(elem.position.y);
				addChild(comp);
			}
			
			for each(elem in _map.passagePoints){
				comp = new MapPassagePointView(this,elem,ratio);
				Out.detail(elem.position.x + " " + elem.position.y);
				comp.x = _map.coordX(elem.position.x);
				comp.y = _map.coordY(elem.position.y);
				addChild(comp);
			}
			
			for each(elem in _map.obstacles){
				comp = new MapObstacleView(this,elem,ratio);
				Out.detail(elem.position.x + " " + elem.position.y);
				comp.x = _map.coordX(elem.position.x);
				comp.y = _map.coordY(elem.position.y);
				addChild(comp);
			}
			
			addChild(new MapRobotDisplay(this,_map.robotAlliePrincipal,ratio));
			addChild(new MapRobotDisplay(this,_map.robotEnnemiPrincipal,ratio));
			addChild(new MapRobotDisplay(this,_map.robotAllieSecondaire,ratio));
			addChild(new MapRobotDisplay(this,_map.robotEnnemiSecondaire,ratio));
			
			addChild(new ParcoursMap(this,_map.tempdebugParcours));
		}
		
		
		public function draw():void{
			var g:Graphics = this.elementsChild.graphics;
			var r:Rectangle = _map.dimensions;
			g.lineStyle(1,0xFF0000,1);
			Out.detail(r);
			g.drawRect(r.x,r.y,_map.coordX(r.width)-r.x,_map.coordY(r.height)-r.y);			
		}
		
		
		public function resize(x:Number, y:Number, width:Number,height:Number):void{
			
			var proportion:Number = Math.min( width/_map.imageWidth,height/_map.imageHeight);
			setStretchXY(proportion,proportion);
			
			// TODO: Revoir la formule, pas sur que le repositionnement soit correct
			move(x+((width  - _map.imageWidth * proportion)/2),
				y+ ((height  - _map.imageHeight * proportion)/2)
			);
			trace((width / _map.imageWidth - proportion) * width / 2),((height / _map.imageHeight - proportion) * height / 2);
		}

		public function get map():Map
		{
			return _map;
		}

		public function set map(value:Map):void
		{
			_map = value;
		}
		
		
	}
}