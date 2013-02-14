package org.projetandtech.sim.core.parcours
{
	import flash.events.EventDispatcher;

	public class ParcoursAction extends EventDispatcher
	{		
		protected var _type:String
		public function ParcoursAction(type:String)
		{
			_type = type;
		}

		public function get type():String
		{
			return _type;
		}
		
		public function getAction():String
		{
			return "";
		}

	}
}