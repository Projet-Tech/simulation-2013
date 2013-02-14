package org.projetandtech.sim.core.map
{
	import org.projetandtech.sim.core.tools.Forme;

	public class MapElement
	{
		
		protected var _position:PointOrriente;
		protected var _forme:Forme;
		
		public function MapElement(x:Number, y:Number, o:Number = Number.NaN, forme:Forme = null)
		{ 
			_position = new PointOrriente(x,y,o);
			_forme = forme;
		}

		
		
		public function get position():PointOrriente
		{
			return _position;
		}

		public function set position(value:PointOrriente):void
		{
			_position = value;
		}

		public function get forme():Forme
		{
			return _forme;
		}

		public function set forme(value:Forme):void
		{
			_forme = value;
		}


	}
}