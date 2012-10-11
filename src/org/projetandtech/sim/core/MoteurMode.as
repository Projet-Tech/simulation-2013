package org.projetandtech.sim.core
{
	public class MoteurMode
	{
		
		public static const SIMULATION:String = "MODE_MOTEUR_SIMULATION";
		public static const VISUALISATION:String = "MODE_MOTEUR_VISUALISATION";
		
		private var _mode:String; 
		
		public function MoteurMode()
		{
		}
		
		public function get():String{
			return _mode;
		}
		
		public function set(value:String):void{
			_mode = value;
		}
	}
}