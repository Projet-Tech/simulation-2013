package org.projetandtech.sim.core
{
	import flash.net.Socket;

	public class SocketCommunication implements ICommunication
	{
		
		private var _host:String;
		private var _ip:String;
		private var socket:Socket;
		
		public function SocketCommunication()
		{
			
			socket = new Socket();
		}
		
		
		public static function getInstance():SocketCommunication
		{
			// TODO: Auto Generated method stub
			
			return null;
		}
		
		public function connect($ip:String, $host:String):void{
			_host = $host;
			_ip = $ip;
			
			
		}
		
		
		public function close():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function send($message:String, $type:String=null):void
		{
			// TODO Auto Generated method stub
			
		}
		
	}
}