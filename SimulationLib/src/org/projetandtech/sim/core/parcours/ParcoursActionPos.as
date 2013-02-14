package org.projetandtech.sim.core.parcours
{
	public class ParcoursActionPos extends ParcoursAction
	{
		private var _posX:int;
		private var _posY:int;
		
		
		public function ParcoursActionPos(type:String)
		{
			super(type);
		}

		[Bindable]
		public function get posX():int
		{
			return _posX;
		}

		public function set posX(value:int):void
		{
			_posX = value;
			
		}

		[Bindable]
		public function get posY():int
		{
			return _posY;
		}

		public function set posY(value:int):void
		{
			_posY = value;
		}


	}
}