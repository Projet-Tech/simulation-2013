package org.projetandtech.sim.core.config
{
	import flash.geom.PerspectiveProjection;

	public class SocketConfig
	{
		
		[Bindable]
		static public var port:int = 11022;
		static private var _address:String = "192.168.1.210";
		
		public function SocketConfig()
		{
		}
		public static function save():void{
			//TODO
		}

		[Bindable]
		public static function get address():String
		{
			return _address;
		}

		public static function set address(value:String):void
		{
			_address = value;
		}

	}
}