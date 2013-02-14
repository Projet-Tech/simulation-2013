package org.projetandtech.sim.ui
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	import org.projetandtech.sim.core.map.MapElement;
	import org.projetandtech.sim.core.map.PointOrriente;
	import org.projetandtech.sim.core.map.items.Item;

	public class MapActionPointView extends MapComponent
	{
		
		
		public function MapActionPointView(mapview:MapView,item:MapElement,size:Number = 5)
		{
			super(mapview,item,size,0x00000);
		}
		/*
		override protected function draw():void
		{
			var g:Graphics = graphics;
			g.lineStyle(2,0x00000,1);
			g.drawCircle(0,0,_size);
		}*/
		

		
	}
}