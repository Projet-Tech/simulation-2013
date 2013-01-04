package org.projetandtech.sim.core
{
	import flash.utils.Timer;
	
	import org.hamcrest.core.throws;
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.items.TypeItem;
	import org.projetandtech.sim.core.tools.Out;

	public class MoteurPrincipal
	{ 
		
		private static var _instance:MoteurPrincipal;
		
		[Bindable]
		public var sim:Simulation;///////////////////XXX
		[Bindable]
		public var gameTimer:Timer;

		
		/*
			TODO:
			Reflection sur la position des robots, 
			notamment a cause de la possibilité d'une simulation multiple.
		*/
		

		
		public function MoteurPrincipal(SINGLETON_CLASS_PLEASE_USE_getInstance:SingletonClass)
		{
			sim = new Simulation();
			gameTimer = new Timer(0.2,0);
			trace("a");
			
		}
		
		public static function getInstance():MoteurPrincipal{
			if(!_instance)
				_instance = new MoteurPrincipal(new SingletonClass())
				
			return _instance;
		}
		
		
		public function start():void{
		}
		
		public function stop(reason:int):void{
		}

	}
	

}

internal class SingletonClass{}
