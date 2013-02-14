package org.projetandtech.sim.ui.ParcoursPanelComponents
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.parcours.Parcours;
	import org.projetandtech.sim.core.parcours.ParcoursAction;
	import org.projetandtech.sim.core.parcours.ParcoursActionGoTo;
	import org.projetandtech.sim.core.parcours.ParcoursActionInit;
	import org.projetandtech.sim.core.parcours.ParcoursActionPos;
	import org.projetandtech.sim.ui.MapView;
	
	public class ParcoursMap extends Sprite
	{
		
		private var _mapview:MapView;
		private var _parcours:Parcours;
		
		public function ParcoursMap(mapview:MapView,parcours:Parcours)
		{
			super();
			
			_mapview = mapview;
			_parcours = parcours;
			
			registerEvents();
			draw();
			rebuild();
		}
		
		
		protected function rebuild():void{
			removeChildren();
			for each(var action:ParcoursAction in _parcours.actions){
				if(action.type == ParcoursActionGoTo.TYPE || action.type == ParcoursActionInit.TYPE){
					var actPos:ParcoursActionPos = action as ParcoursActionPos;
					addChild(new ParcoursMapPoint(_mapview,this,actPos));
				}
			}
		}
		private function registerEvents():void{
			_parcours.actions.addEventListener(CollectionEvent.COLLECTION_CHANGE,elemChange);
		}
		
		private function elemChange(e:CollectionEvent):void{
			if(e.kind != CollectionEventKind.UPDATE){
				rebuild();
			}
			draw();
			
		}
		
		private function draw():void{
			var g:Graphics = graphics;
			var _map:Map = _mapview.map;
			
			g.clear();
			g.lineStyle(2,0xFF0000,1);
			g.moveTo(_map.coordX(_parcours.initialPos.x),
				_map.coordY(_parcours.initialPos.y));
			
			for each(var action:ParcoursAction in _parcours.actions){
				if(action.type == ParcoursActionGoTo.TYPE){
					var goto:ParcoursActionGoTo = action as ParcoursActionGoTo;
					
					g.lineTo(_map.coordX(goto.posX),
						_map.coordY(goto.posY));
					
				}
			}
			
			
			
		}
		
		
		
		
	}
}