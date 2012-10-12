package org.projetandtech.sim.core
{
	public class Forme
	{
		
		//Revient a faire une enum en java;
		public static const CARRE:String = "BOT_FORME_CARRE";
		public static const ROND:String = "BOT_FORME_ROND";
		
		private var _forme:String;
		
		public function Forme()
		{
		}
		
		
		
		public function get():String
		{
			return _forme;
		}

		public function set(value:String):void
		{
			if(value == CARRE || value == ROND)
				_forme = value;
		}

	}
}