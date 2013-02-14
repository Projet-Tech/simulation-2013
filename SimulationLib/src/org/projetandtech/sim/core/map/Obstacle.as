package org.projetandtech.sim.core.map
{
	import org.projetandtech.sim.core.tools.Forme;

	public class Obstacle extends MapElement
	{
		private var _duree:Number;
		
		public function Obstacle(x:Number,y:Number,o:Number, duree:Number, forme:Forme = null)
		{
			_duree = duree;
			super(x,y,o,forme);
		}


		public function get duree():Number
		{
			return _duree;
		}

		public function set duree(value:Number):void
		{
			_duree = value;
		}


	}
}