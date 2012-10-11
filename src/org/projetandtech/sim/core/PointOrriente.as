package org.projetandtech.sim.core
{
	public class PointOrriente
	{
		private var _x:Number;
		private var _y:Number;
		private var _o:Number;
		private var _isOrriented:Boolean;
		
		public function PointOrriente(x:Number,y:Number,o:Number = Number.NaN)
		{
			this.x = x;
			this.y = y;
			this.o = o;
		}

		public function get isOrriented():Boolean
		{
			return _isOrriented;
		}

		public function set isOrriented(value:Boolean):void
		{
			_isOrriented = value;
		}

		public function get o():Number
		{
			if(!_isOrriented){
				return Number.NaN;
			}
			return _o;
		}

		public function set o(value:Number):void
		{
			if(isNaN(value))
				_isOrriented = false;
			
			_o = value;
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}

	}
}