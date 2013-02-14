package org.projetandtech.sim.ui.ParcoursPanelComponents
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	
	import mx.events.DragEvent;
	import mx.events.PropertyChangeEvent;
	
	import org.projetandtech.sim.core.parcours.ParcoursActionGoTo;
	import org.projetandtech.sim.core.parcours.ParcoursActionPos;
	import org.projetandtech.sim.ui.ElementEditable;
	import org.projetandtech.sim.ui.MapView;
	
	public class ParcoursMapPoint extends ElementEditable
	{
		public static const TYPE:String = "PARCOURS_MAP_POINT";
		private var _color:uint = 0xFFFFFF;
		private var _parcoursmap:ParcoursMap;
		private var _goto:ParcoursActionPos;
		private var size:Number = 60;
		
		public function ParcoursMapPoint(mapview:MapView,parcoursmap:ParcoursMap,goto:ParcoursActionPos)
		{
			super(mapview,TYPE);
			_parcoursmap = parcoursmap;
			_goto = goto;
			draw();
			repositioner();
			registerEvent();
			goto.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,propertyChange_handler);
		}
		
		private function registerEvent():void{
			addEventListener(Event.ENTER_FRAME,drag_loop);
		}
		
		private function drag_loop(evt:Event):void{
			if(!_isDragging)
				return;
			
			_goto.posX = _mapview.map.coord2posX(x);
			_goto.posY = _mapview.map.coord2posY(y);
			trace("aa");
		}
		private function propertyChange_handler(evt:PropertyChangeEvent):void{
			if(!_isDragging)
				repositioner();
		}
		
		private function repositioner():void{
			x = _mapview.map.coordX(_goto.posX);
			y = _mapview.map.coordY(_goto.posY);
		}
		protected function draw():void{
			var g:Graphics = this.graphics;
			var s:Number = size * _mapview.map.ratioX;
			g.lineStyle(2,_color,1);
			g.beginFill(_color,0.3);
			
				g.drawRect(-s/2,-s/2,s,s);
			
			g.endFill();
		}
	}
}