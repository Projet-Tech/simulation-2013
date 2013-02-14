package org.projetandtech.sim.ui
{
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.MapElement;
	import org.projetandtech.sim.core.map.Obstacle;
	
	public class MapObstacleView extends MapComponent
	{
		public function MapObstacleView(mapview:MapView,item:MapElement,size:Number = 5)
		{
			super(mapview,item, size, 0xFF00FF);
		}
	}
}