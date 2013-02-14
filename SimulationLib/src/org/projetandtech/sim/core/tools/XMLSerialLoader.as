package org.projetandtech.sim.core.tools
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.projetandtech.sim.core.MoteurPrincipal;

	/**
	 * 
	 * @author Jean-Mi
	 * 
	 */
	public class XMLSerialLoader extends EventDispatcher
	{
		private var _datas:XML;
		
		/**
		 * Créé une instance de XMLSerialLoader et charge le fichier dont le
		 * chemin est spécifié en parametre. 
		 * 
		 * Renvoie l'evenement Event.COMPLETE une fois chargé.
		 * 
		 * @param filePath Chemin du fichier XML a charger
		 * 
		 */
		
		public function XMLSerialLoader(filePath:String)
		{                                             
			var l:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest(filePath);
			l.load(req);
			l.addEventListener(Event.COMPLETE, loading_completeHandler);
			Out.debug(filePath+" is loading by XMLSerialLoader");	
		}
		
		
		private function loading_completeHandler(evt:Event):void{
			var m:MoteurPrincipal = MoteurPrincipal.getInstance();
			var l:URLLoader = evt.target as URLLoader;
			
			datas = new XML(l.data);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}

		
		public function get datas():XML
		{
			return _datas;
		}
		
		
		public function set datas(value:XML):void
		{
			_datas = value;
		}
		

											
	}
} 