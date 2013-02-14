package org.projetandtech.sim.core.comm
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import org.projetandtech.sim.core.config.SocketConfig;
	import org.projetandtech.sim.core.tools.Out;

	public class SocketConnection extends Socket
	{ 
		private var _socketComm:SocketCommunicateur;
		
		public function SocketConnection(classeSingleton:SingletonClass) {
			if (classeSingleton == null) {
				throw new Error ("SocketConnection est un singleton, utilisez SocketConnection.getInstance()");            
			}
			
			addEventListener(Event.CONNECT,socketConnected);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityError);
			addEventListener(IOErrorEvent.IO_ERROR,ioError);
			addEventListener(ProgressEvent.SOCKET_DATA,socketData);
			addEventListener(Event.CLOSE,socketClosed);
			
		}
		
		override public function connect(address:String, port:int):void
		{
			if(address){
				SocketConfig.address = address
			}
			if(port){
				SocketConfig.port = port;
			}
			SocketConfig.save();
			
			super.connect(SocketConfig.address,SocketConfig.port);
		}
		
		private function socketClosed(e:Event):void{
			
		}
		
		private function socketConnected(e:Event):void{
			Out.debug("Connecté effectue"); 
		}
		private function socketData(e:ProgressEvent):void{
			while(bytesAvailable){
				var tag:String = readUTF().toUpperCase(); 
				(new SocketCommunicateur).reception(tag);
			}
		}
		
		public function sendDatas(tag: uint, datas: ByteArray  = null):void{
			if(!connected){
				Out.warning("Impossible de transmettre le message, aucune connection active");
				return
			}
			writeByte(tag);
			if(datas != null){
				writeBytes(datas);
			}
			flush();
		}
		
		
		public function sendMessage(msg:String):void{
			if(!connected){
				Out.warning("Impossible de transmettre le message, aucune connection active");
				return
			}
			writeUTF(msg);
			flush();
			Out.debug("sendMessage: "+msg);
		}
		
		public function sendText(tag:String , msg:String = ""):void{
			if(!connected){
				Out.warning("Impossible de transmettre le message, aucune connection active");
				return
			}
			
			var commande:String;
			var datas:ByteArray = new ByteArray();
			if(msg == ""){
				commande = tag; 
			}else{
				commande = tag+" "+msg;
			}
			writeUTF(commande);
			flush();
			datas.writeUTF(commande);
			Out.debug("--> "+commande);
		}
		
		public function ioError(e:IOErrorEvent):void{
			Out.error("Socket IOErr: "+e);
		}
		
		public function securityError(e:SecurityErrorEvent):void{
			Out.error("Socket secuErr: "+e);
		}
		
		
		
		// Implementation du Singleton.
		private static var __instance:SocketConnection;
		public static function getInstance():SocketConnection
		{
			if(!__instance)
				__instance = new SocketConnection(new SingletonClass());
			
			return __instance;
		}



	}
}

class SingletonClass{}