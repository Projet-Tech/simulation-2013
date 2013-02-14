package org.projetandtech.sim.core
{
	import org.projetandtech.sim.core.comm.CommuncationCommand;
	import org.projetandtech.sim.core.comm.SocketCommunicateur;
	import org.projetandtech.sim.core.parcours.Parcours;
	import org.projetandtech.sim.core.tools.Out;

	public class InterpretteurCommande
	{
		
		public static const TO_PSOC :Commande 				= new Commande("2PSOC",Commande.ENV_GLOB, "Envoie la commande a destination du PSoC");
		public static const TO_MAIA :Commande 				= new Commande("2MAIA",Commande.ENV_GLOB, "Envoie la commande a destination de Maia");
		public static const TO_SIMU :Commande 				= new Commande("2SIMU",Commande.ENV_GLOB, "Envoie la commande a destination de la Simulation");
		
			
		public static const SENDPARCOURS :Commande 		= new Commande("SENDPARCOURS",Commande.ENV_SIMU, "Envoie le parcours par defaut");
		public static const SENDP :Commande 		= new Commande("SENDP",Commande.ENV_SIMU, "Envoie la commande a destination de la Simulation");;
		public static const HELP :Commande 		= new Commande("HELP",Commande.ENV_SIMU, "Envoie la commande a destination de la Simulation");;
		public static function init():void{}
		public function InterpretteurCommande()
		{	
		}
		
		private static var _index:int = 0;
		private static var _historique:Vector.<String> = new Vector.<String>;
		
		private static function saveCommande(commandeText: String):void{
			if(_historique.length == 0 || _historique[_historique.length-1] != commandeText)
				_historique.push(commandeText);
				
			_index = _historique.length;
		}
		public static function getPrevCommande():String{
			if(_historique.length == 0)
				return ""
				
			if(_index > 0)
				_index--;
			var comm:String = _historique[_index];
			return comm;
				
		}
		public static function getNextCommande():String{
			if(_historique.length == 0)
				return "";
			
				
			if(_index >= _historique.length)
				return "";
			
			if(_index < _historique.length-1)
				_index++;
					
			var comm:String = _historique[_index];
			return comm;
		}
		

		public static function execute(txt_msg:String):void{
			var commande:CommuncationCommand = new CommuncationCommand(txt_msg);
			var socketComm:SocketCommunicateur = new SocketCommunicateur();
			
			switch(commande.commande){
				
				
				case TO_PSOC.name:
				{
					socketComm.sendPSoC(commande.getParamMessage());
					break;
				}
					
				case TO_MAIA.name:
				{
					socketComm.sendPSoC(commande.getParamMessage());
					break;
				}
					
				case TO_SIMU.name:
				{
					socketComm.reception(commande.getParamMessage());
					break;
				}
				case SENDP.name:
				case SENDPARCOURS.name:
					socketComm.sendParcours(new Parcours());
					break;
				case HELP.name:
					Out.print(Commande.getHelp());
					break;
				
				default:
					//Tag de Debug
					Out.warning("La commande {"+txt_msg+"} n'a pas pu etre interpretee");
			}
			saveCommande(txt_msg);
		}
		
	}
}