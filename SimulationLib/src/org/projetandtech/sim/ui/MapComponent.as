package org.projetandtech.sim.ui
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	
	import mx.core.UIComponent;
	
	import org.projetandtech.sim.core.tools.Forme;
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.MapElement;
	import org.projetandtech.sim.core.map.PointOrriente;
	import org.projetandtech.sim.core.tools.Out;
	import org.projetandtech.sim.ui.ParcoursPanelComponents.ParcoursMap;

	public class MapComponent extends ElementEditable
	{
		public static const TYPE:String = "MAP_COMPONENT";
		protected var _item:MapElement;
		protected var _size:Number;
		protected var _color:uint;
		
		
		public function MapComponent(mapview:MapView, item:MapElement,size:Number,color:uint = 0x00000){
			super(mapview,TYPE);
			_item = item;
			_size = size;
			_color = color;
			
			draw();
			
		}
		
		protected function draw():void{
			var g:Graphics = this.graphics;
			g.lineStyle(2,_color,1);
			g.beginFill(_color,0.3);
			if(forme != null){
				Out.print("Forme "+forme.type);
				switch(forme.type){
					case Forme.FORME_RECTANGLE:
						g.drawRect(-forme.largeur*_size/2,-forme.hauteur*_size/2,forme.largeur*_size,forme.hauteur*_size);
						break;
					case Forme.FORME_CERCLE:
						g.drawCircle(0,0,forme.rayon*_size);
						break;
					default:
						g.drawCircle(0,0,_size*20);
				}
			}
			else
				g.drawCircle(0,0,_size*20);
			
			g.endFill();
		}
		
		protected function  get position():PointOrriente{
			return _item.position;
		}
		
		protected function  set ratio(value:Number):void{
			_size = value;
		}
		protected function get forme():Forme{
			return _item.forme;
		}
	}
}