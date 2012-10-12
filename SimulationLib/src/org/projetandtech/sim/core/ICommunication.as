package org.projetandtech.sim.core
{
	public interface ICommunication
	{
		
		//function connect():void;
		function send($message:String,$type:String=null):void;
		function close():void;
		
	}
}