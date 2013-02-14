package org.projetandtech.sim.core.parcours
{
	import org.projetandtech.sim.core.map.PointOrriente;

	public class ParcoursActionInit extends ParcoursActionPos
	{
		public static const TYPE:String = "TYPE_INIT";
		
		private var _pointOriente:PointOrriente;
		
		
		public function ParcoursActionInit(iniX:int = 0,iniY:int = 0, iniO:int = 0)
		{
			super(TYPE);
			_pointOriente = new PointOrriente(iniX,iniY,iniO);
		}

		[Bindable]
		override public function get posX():int
		{
			return _pointOriente.x;
		}

		override public function set posX(value:int):void
		{
			_pointOriente.x = value;
		}

		[Bindable]
		override public function get posY():int
		{
			return _pointOriente.y;
		}

		override public function set posY(value:int):void
		{
			_pointOriente.y = value;
		}
		
		[Bindable]
		public function get posO():int
		{
			return _pointOriente.o;
		}

		public function set posO(value:int):void
		{
			_pointOriente.o = value;
		}

		public function get pointOriente():PointOrriente
		{
			return _pointOriente;
		}

		public function set pointOriente(value:PointOrriente):void
		{
			_pointOriente = value;
		}
		


	}
}