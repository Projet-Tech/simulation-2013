package org.projetandtech.sim.core.map
{
	public class PointAction extends MapElement
	{
		private var _actionName:String;
		
		public function PointAction(x:Number,y:Number,o:Number, actionName:String)
		{
			_actionName = actionName;
			
			super(x,y,o);			
		}
	}
}