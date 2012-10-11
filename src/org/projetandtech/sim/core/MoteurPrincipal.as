package org.projetandtech.sim.core
{
	public class MoteurPrincipal
	{ 
		
		private static var _instance:MoteurPrincipal;
		
		
		private var _mode:MoteurMode;
		private var _map:Map;
		
		private var _robotAlliePrincipal:Robot;
		private var _robotAllieSecondaire:Robot;
		private var _robotEnnemiPrincipal:Robot;
		private var _robotEnnemiSecondaire:Robot;
		
		public function MoteurPrincipal(SINGLETON_USE_getInstance:SingletonClass)
		{
			_mode = new MoteurMode();
			_map = new Map();
			
			
			_robotAlliePrincipal = new Robot();
			_robotAllieSecondaire = new Robot();
			_robotEnnemiPrincipal = new Robot();
			_robotEnnemiSecondaire = new Robot();
			new XMLSerialLoader("ressources/infos.xml");
		}
		
		public static function getInstance():MoteurPrincipal{
			if(!_instance)
				_instance = new MoteurPrincipal(new SingletonClass())
				
			return _instance;
		}
		
		public function load(datas:XMLList):void{
			for(var elem:* in datas){
				trace('aa');
			}
		}
		
		
		public function save():XMLList{
			
			return null;
		}
	}
	

}

internal class SingletonClass{}
