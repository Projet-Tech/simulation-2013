package org.projetandtech.sim.core
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLSerialLoader
	{
		
		public function XMLSerialLoader(fileSource:String)
		{                                             
			var l:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest(fileSource);
			l.load(req);
			l.addEventListener(Event.COMPLETE, loading_completeHandler);
			trace(fileSource+" is loading by XMLSerialLoader");	
		}
		
		private function loading_completeHandler(e:Event):void{
			var m:MoteurPrincipal = MoteurPrincipal.getInstance();
			var l:URLLoader = e.target as URLLoader;
			var XMLInfos:XML = new XML(l.data)
			m.load(XMLInfos.children());
		}
	}
} 