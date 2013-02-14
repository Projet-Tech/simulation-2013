package org.projetandtech.sim.core.parcours
{
	public class ParcoursActionGoTo extends ParcoursActionPos
	{
		public static const TYPE:String = "TYPE_GO_TO";
		
		private var _gotoX:int;
		private var _gotoY:int;
		
		
		public function ParcoursActionGoTo(gotoX:int = 0,gotoY:int = 0)
		{
			super(TYPE);
			_gotoX = gotoX;
			_gotoY = gotoY;
		}

		[Bindable]
		override public function get posX():int
		{
			return _gotoX;
		}

		override public function set posX(value:int):void
		{
			_gotoX = value;
		}

		[Bindable]
		override public function get posY():int
		{
			return _gotoY;
		}

		override public function set posY(value:int):void
		{
			_gotoY = value;
		}


	}
}