package org.projetandtech.sim.core
{
	public class VelocityParams
	{
		
		private var _tempsDemarage:Number;
		private var _vitesseDemarage:Number;
		private var _vitesseCourse:Number;
		private var _tempsArret:Number;
		private var _vitesseArret:Number; //Non géré.
		
		
		public function VelocityParams(tempsDemarage:Number, tempsArret:Number, vitesseDemarage:Number,
									   vitesseCourse:Number, vitesseArret:Number = 0)
		{
			_tempsArret = tempsArret;
			_tempsDemarage =tempsDemarage;
			_vitesseArret = vitesseArret;
			_vitesseCourse = vitesseCourse;
			_vitesseDemarage = vitesseDemarage;
		}

		public function get tempsDemarage():Number
		{
			return _tempsDemarage;
		}

		public function set tempsDemarage(value:Number):void
		{
			_tempsDemarage = value;
		}

		public function get vitesseDemarage():Number
		{
			return _vitesseDemarage;
		}

		public function set vitesseDemarage(value:Number):void
		{
			_vitesseDemarage = value;
		}

		public function get vitesseCourse():Number
		{
			return _vitesseCourse;
		}

		public function set vitesseCourse(value:Number):void
		{
			_vitesseCourse = value;
		}

		public function get tempsArret():Number
		{
			return _tempsArret;
		}

		public function set tempsArret(value:Number):void
		{
			_tempsArret = value;
		}

		public function get vitesseArret():Number
		{
			return _vitesseArret;
		}

		public function set vitesseArret(value:Number):void
		{
			_vitesseArret = value;
		}


	}
}