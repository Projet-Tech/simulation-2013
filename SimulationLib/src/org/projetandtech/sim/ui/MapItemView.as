package org.projetandtech.sim.ui
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.MapElement;
	import org.projetandtech.sim.core.map.PointOrriente;
	import org.projetandtech.sim.core.map.items.Item;

	public class MapItemView extends MapComponent
	{
		
		//TODO Verifier item type
		public function MapItemView(mapview:MapView,item:MapElement,size:Number = 5)
		{
			super(mapview,item,size,0x0000FF);
		}
		/*
		override protected function draw():void
		{
			var g:Graphics = graphics;
			g.lineStyle(2,0x0000FF,1);
			g.drawCircle(0,0,_size);
		}
		*/
		

		
	}
}