package org.projetandtech.sim.core.parcours
{
	public class ParcoursActionWait extends ParcoursAction
	{
		public static const TYPE:String = "TYPE_WAIT";
		
		private var _durationMili:uint;
		private var _action:String;
		
		public function ParcoursActionWait(action:String = "",duration:uint = 1000)
		{
			super(TYPE);
			_durationMili = duration;
			_action = action;
		}

		[Bindable]
		public function get durationMili():uint
		{
			return _durationMili;
		}

		public function set durationMili(value:uint):void
		{
			_durationMili = value;
		}

		[Bindable]
		public function get action():String
		{
			return _action;
		}

		public function set action(value:String):void
		{
			_action = value;
		}
		

	}
}