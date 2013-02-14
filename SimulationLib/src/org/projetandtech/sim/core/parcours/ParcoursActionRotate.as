package org.projetandtech.sim.core.parcours
{
	public class ParcoursActionRotate extends ParcoursAction
	{
		
		public static const TYPE:String = "TYPE_ROTATE";
		
		private var _abs_rotation:Number;
		public function ParcoursActionRotate(abs_rotation:Number = 0)
		{
			super(TYPE);
			_abs_rotation = abs_rotation;
		}

		[Bindable]
		public function get abs_rotation():Number
		{
			return _abs_rotation;
		}

		public function set abs_rotation(value:Number):void
		{
			_abs_rotation = value;
		}

	}
}