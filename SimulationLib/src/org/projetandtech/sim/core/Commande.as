package org.projetandtech.sim.core
{
	import mx.rpc.events.HeaderEvent;
	
	import org.projetandtech.sim.core.comm.SocketCommunicateur;
	import org.projetandtech.sim.core.tools.Out;

	public class Commande
	{
		public static const ENV_PSOC:String = "PSoC";
		public static const ENV_MAIA:String = "Maia";
		public static const ENV_SIMU:String = "Simu";
		public static const ENV_CONS:String = "Console";
		public static const ENV_GLOB:String = "Global";
		public static const ENV_ERRO:String = "Erreur";
		
		
		
		private static var _commandList:Vector.<Commande> = new Vector.<Commande>;
		private static function enregistreCommande(comm:Commande):void{
			var old_comm:Commande = getCommande(comm.name)
			if(old_comm){
				old_comm  = comm;
			}
			else{
				_commandList.push(comm);
			}		
		}	
		private static function getCommande(commandName:String):Commande{
			if("" == commandName)
				return null;
			
			for each(var comm:Commande in _commandList){
				if(commandName == comm.name)
					return comm;
			}
			return null
		}
		
		public static function getHelp(commandName:String = ""):String{
			init();
			var outHelpMsg:String;
			var liste:Vector.<Commande>;
			
			liste = getCorrespondances(commandName);
			
			if(liste.length == 0){
				liste = _commandList;
			}
			
			outHelpMsg = "Aide: "
			for each(var comm:Commande in liste){
				outHelpMsg += "\n" + " |-- ["+comm.environement+"] "+ comm.name +":     "+comm._aideMsg;
			}
			return outHelpMsg;
			
		}
		
		public static function init():void{
			InterpretteurCommande.init();
			SocketCommunicateur.init();
		}
		private static var _oldCommandBegin:String = "@@@@@@@~~#";
		private static var _correspondancesIndex:int = 0;
		private static var _correspondances:Vector.<Commande> = new Vector.<Commande>;
		private static function getCorrespondances(commandName:String):Vector.<Commande>{
			Out.debug(" --getCorrespondances!");		
			Out.debug(" --getCorrespondances: _commandList.lenght: " + _commandList.length);
			if(commandName == ""){
				Out.debug(" --getCorrespondances: return _commandList;");
				return _commandList;
			}
			
			var out:Vector.<Commande> = new Vector.<Commande>;
			Out.debug(" --getCorrespondances: boucle debut");
			for each(var comm:Commande in _commandList){
				Out.debug("["+comm.name+"] -- "+ (comm.name.indexOf(commandName) == 0));
				if(comm.name.indexOf(commandName) == 0){
					out.push(comm);
				}
			}
			
			Out.debug(" --getCorrespondances: boucle fin");
			return out
		}
		public static function autocompletion(commandBegin:String = "",environement:String = ""):String{
			var commandBeginSE:String = commandBegin.toUpperCase().replace("  ", " ");
			var sous_elems:Array = commandBeginSE.split(" ");
			
			Out.debug("commandBeginSE");
			Out.debug(commandBeginSE);
			Out.debug("sous_elems");
			Out.debug(sous_elems);
			
			init();
			
			if(commandBegin != _oldCommandBegin){
				
				Out.debug("commandBegin != _oldCommandBegin");
				Out.debug("sous_elems[sous_elems.length-1]");
				Out.debug(sous_elems[sous_elems.length-1]);
				_correspondances = getCorrespondances(sous_elems[sous_elems.length-1]);
				Out.debug("_correspondances = getCorrespondances(sous_elems[sous_elems.length-1])");
				Out.debug(_correspondances);
				_correspondancesIndex = 0;
				_oldCommandBegin = commandBegin;
			}
			
			if(_correspondances.length == 0){
				Out.debug("_correspondances.length == 0");
				return commandBegin;
			}
			_correspondancesIndex %= _correspondances.length;
			Out.debug("_correspondancesIndex %= _correspondances.length");
			Out.debug(_correspondancesIndex);
			sous_elems[sous_elems.length-1] = _correspondances[_correspondancesIndex].name;
			Out.debug("sous_elems[sous_elems.length-1] = _correspondances[_correspondancesIndex].name;");
			Out.debug(_correspondances[_correspondancesIndex].name);
			_correspondancesIndex++;
			Out.debug("JOIN --|"+sous_elems.join(" ")+"|");
			return sous_elems.join(" ");
		}

		
		private var _name:String;
		private var _environement:String;
		private var _aideMsg:String = "";
		
		public function Commande(name:String, environement:String, aideMsg:String = "")
		{
			_name = name;
			_environement = environement;
			_aideMsg = aideMsg;
			enregistreCommande(this);
		}
		
		public function toString():String{
			return _name;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}

		public function get environement():String
		{
			return _environement;
		}

		public function set environement(value:String):void
		{
			_environement = value;
		}

		public function get aideMsg():String
		{
			return _aideMsg;
		}

		public function set aideMsg(value:String):void
		{
			_aideMsg = value;
		}


	}
}