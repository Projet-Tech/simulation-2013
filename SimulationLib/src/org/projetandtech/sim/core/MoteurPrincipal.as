package org.projetandtech.sim.core
{
	import flash.utils.Timer;
	
	import org.hamcrest.core.throws;
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.items.TypeItem;
	import org.projetandtech.sim.core.parcours.Parcours;
	import org.projetandtech.sim.core.tools.Out;

	public class MoteurPrincipal
	{ 
		
		private static var _instance:MoteurPrincipal;
		
		private var _sim:Simulation;
		
		public function MoteurPrincipal(SINGLETON_CLASS_PLEASE_USE_getInstance:SingletonClass)
		{
			_sim = new Simulation();
			trace("a");
			
		}
		
		public static function getInstance():MoteurPrincipal{
			if(!_instance)
				_instance = new MoteurPrincipal(new SingletonClass())
				
			return _instance;
		}

		[Bindable]
		public function get currentSim():Simulation
		{
			return _sim;
		}

		public function set currentSim(value:Simulation):void
		{
			_sim = value;
		}
		
		public function sendPosXYO(x:uint, y:uint, o:uint):void{
			currentSim.map.robotAlliePrincipal.position.x = x;
			currentSim.map.robotAlliePrincipal.position.y = y;
			currentSim.map.robotAlliePrincipal.position.o = o;
		}
		public function setPosX(x:uint):void{
			currentSim.map.robotAlliePrincipal.position.x = x;
		}
		public function setPosY(y:uint):void{
			currentSim.map.robotAlliePrincipal.position.y = y;
		}
		public function setPosO(o:uint):void{
			currentSim.map.robotAlliePrincipal.position.o = o;
		}
		
		public function setParcours(id:int, posX:Number, posY:Number, posO:Number, action:Number):void
		{
			currentSim.map.robotAlliePrincipal.parcours.appliCommand(id, posX, posY, posO, action);
		}
		
		public function setEtatCapteur(capteurID:String, valeur:String):void{
			currentSim.params.setParametre(capteurID,valeur);
		}
		
		public function setEvitement(dirrection:uint):void{}
		public function start():void{}
		public function stop(motif:String):void{}
		public function setCouleur(couleur:String):void{}
		public function setConfigAdversaire(config:String):void{}
		public function setPos_2_XYO(x:uint, y:uint, o:uint):void{
			currentSim.map.robotAllieSecondaire.position.x = x;
			currentSim.map.robotAllieSecondaire.position.y = y;
			currentSim.map.robotAllieSecondaire.position.o = o;
		}
		public function setPos_2_X(x:uint):void{
			currentSim.map.robotAllieSecondaire.position.x = x;
		}
		public function setPos_2_Y(y:uint):void{
			currentSim.map.robotAllieSecondaire.position.y = y;
		}
		public function setPos_2_O(o:uint):void{
			currentSim.map.robotAllieSecondaire.position.o = o;
		}
	}
	

}

internal class SingletonClass{}
