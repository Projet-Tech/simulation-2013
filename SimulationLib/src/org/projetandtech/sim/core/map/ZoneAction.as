package org.projetandtech.sim.core.map
{
	import org.projetandtech.sim.core.tools.Forme;

	public class ZoneAction extends MapElement
	{
		private var _actionName:String;
		
		public function ZoneAction(x:Number,y:Number,o:Number, actionName:String, forme:Forme)
		{
			_actionName = actionName;
			_forme = forme;
			super(x,y,o);
		}

		public function get actionName():String
		{
			return _actionName;
		}

		public function set actionName(value:String):void
		{
			_actionName = value;
		}


	}
}