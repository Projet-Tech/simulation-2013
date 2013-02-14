package org.projetandtech.sim.core.comm
{
	import flash.utils.ByteArray;
	
	import org.hamcrest.mxml.object.Null;
	import org.projetandtech.sim.core.Commande;
	import org.projetandtech.sim.core.MoteurPrincipal;
	import org.projetandtech.sim.core.Parametres;
	import org.projetandtech.sim.core.parcours.Parcours;
	import org.projetandtech.sim.core.parcours.ParcoursAction;
	import org.projetandtech.sim.core.parcours.ParcoursActionGoTo;
	import org.projetandtech.sim.core.parcours.ParcoursActionRotate;
	import org.projetandtech.sim.core.parcours.ParcoursActionWait;
	import org.projetandtech.sim.core.tools.Out;

	public class SocketCommunicateur
	{
	
		//0xA0-0xBF [SIMU -> STRAT]
		public static const TO_PSOC :Commande 				= new Commande("2PSOC",Commande.ENV_GLOB, "Envoie la commande a destination du PSoC");
		public static const TO_MAIA :Commande 				= new Commande("2MAIA",Commande.ENV_GLOB, "Envoie la commande a destination de Maia");
		public static const TO_SIMU :Commande 				= new Commande("2SIMU",Commande.ENV_GLOB, "Envoie la commande a destination de la Simulation");
		
		
		//0x80-0x9F [STRAT -> SIMU]   RECEPTION 
		public static const MESSAGE:Commande 				= new Commande("MESSAGE",Commande.ENV_SIMU, "Envoie d'un message.");
		
		// 0x60-0x7F [PSoC -> STRAT]
		public static const POS_XYO:Commande 				= new Commande("POS_XYO",Commande.ENV_MAIA,"set les 3 positions");
		public static const POS_X:Commande 					= new Commande("POS_X",Commande.ENV_MAIA,"");
		public static const POS_Y:Commande 					= new Commande("POS_Y",Commande.ENV_MAIA,"");
		public static const POS_O:Commande 					= new Commande("POS_O",Commande.ENV_MAIA,"");
		public static const EVITEMENT_DIRECTION:Commande 	= new Commande("EVITEMENT_DIRECTION",Commande.ENV_MAIA,"");
		public static const CAPTEUR_ETAT:Commande 			= new Commande("CAPTEUR_ETAT",Commande.ENV_MAIA,"");
		public static const START:Commande 					= new Commande("START",Commande.ENV_MAIA,"");
		public static const STOP:Commande 					= new Commande("STOP",Commande.ENV_MAIA,"");
		public static const CONFIG_ADVERSAIRE:Commande 		= new Commande("CONFIG_ADVERSAIRE",Commande.ENV_MAIA,"");
		public static const COULEUR:Commande 				= new Commande("COULEUR",Commande.ENV_MAIA,"");
		public static const POS_2_XYO:Commande 				= new Commande("POS_2_XYO",Commande.ENV_MAIA,"");
		public static const POS_2_X:Commande 				= new Commande("POS_2_X",Commande.ENV_MAIA,"");
		public static const POS_2_Y:Commande 				= new Commande("POS_2_Y",Commande.ENV_MAIA,"");
		public static const POS_2_O:Commande 				= new Commande("POS_2_O",Commande.ENV_MAIA,"");
		
		//[0x40-0x5F] [STRAT -> PSoC]
		public static const PARCOURS:Commande 				= new Commande("PARCOURS",Commande.ENV_PSOC,"");
		public static const PARCOURS_ELEMENT:Commande 		= new Commande("P_ELEM",Commande.ENV_PSOC,"");
		public static const PHASE_EVIT_START:Commande   	= new Commande("PHASE_EVIT_START",Commande.ENV_PSOC,"");
		public static const PHASE_EVIT_STOP:Commande 		= new Commande("PHASE_EVIT_STOP",Commande.ENV_PSOC,"");
		public static const COMMANDE_TEXTE:Commande 		= new Commande("COMMANDE_TEXTE",Commande.ENV_PSOC,"");
		
		
		
		public static const ERROR_NO_COMMAND:Commande 		= new Commande("ERROR_NO_COMMAND",Commande.ENV_ERRO,"");
		public static const ERROR_BLANK_COMMAND:Commande 		= new Commande("ERROR_BLANK_COMMAND",Commande.ENV_ERRO,"");
		
		protected var conn:SocketConnection; 
		
		public static function init():void{}
		
		public function SocketCommunicateur()
		{
			conn = SocketConnection.getInstance();
		}
		
		public function send(tag: uint, datas: ByteArray = null): void{
			conn.sendDatas(tag,datas);
		}
		public function sendText(tag:Object, datas:String = ""): void{
			conn.sendText(tag.toString,datas);
		}
		public function intString(v:Number):String{
			return v.toFixed(0);
		}
		public function floatString(v:Number,precision:int = 4):String{
			return v.toFixed(precision);
		}
		public function boolString(b:Boolean):String{
			return (b==true)?"1":"0";
		}
		
		public function sendPosXYO(x:uint, y:uint, o:uint):void{
			var msg:String = intString(x)+" "+intString(y)+" "+intString(o);
			sendText(POS_XYO.name,msg);
		}
		public function sendPosX(x:uint):void{
			var msg:String = intString(x);
			sendText(POS_X,msg);
		}
		public function sendPosY(y:uint):void{
			var msg:String = intString(y);
			sendText(POS_Y,msg);
		}
		public function sendPosO(o:uint):void{
			var msg:String = intString(o);
			sendText(POS_O,msg);
		}
		
		
		public function sendParcours(p:Parcours):void
		{
			//COORD_X  |  COORD_Y  |  COORD_O | ID_ACTION
			var commandes:Vector.<String> = new Vector.<String>;
			
			var isFirst:Boolean = true;
			var goX:Number = 0;
			var goY:Number = 0;
			var rot:Number = 0;
			var action:String = "0";
			var id:int = 1;
			
			for(var i:int = 0; i < p.actions.length ; i++){
				var act:ParcoursAction = p.actions[i];
				switch(act.type){
					case ParcoursActionGoTo.TYPE:
					{
						if(!isFirst){
							commandes.push(id+" "+goX + " " + goY + " " + rot + " " + action);
							action = "0";
							
							id++
						}
						else {
							isFirst = false;
						}
						
						var gotoAct:ParcoursActionGoTo = act as ParcoursActionGoTo;
						goX = gotoAct.posX;
						goY = gotoAct.posY;
						break;
						
					}
					case ParcoursActionWait.TYPE:
					{
						var waitAct:ParcoursActionWait = act as ParcoursActionWait;
						if(waitAct.action == ""){
							action = "0";
						}else{
							action = waitAct.action;
						}
						break;
					}
					case ParcoursActionRotate.TYPE:
					{
						var rotAct:ParcoursActionRotate = act as ParcoursActionRotate;
						rot = rotAct.abs_rotation;
						break;
					}
				}
			}
			
			
			commandes.push(id+" "+goX + " " + goY + " " + rot + " " + action);
			
			
			for each(var commande:String in commandes)
			{
				sendText(PARCOURS_ELEMENT,commande);
			}
			
			
		}
		/**
		 * 0x66 - CAPTEUR_ETAT : 
		 *    Transmet l'etat d'un capteur
		 * @param capteurID : ID_DU_CAPTEUR sur 16 bits
		 * @param valeur : valeur du capteur sur 32 bits
		 */
		public function sendEtatCapteur(capteurID:uint, valeur:int):void{
			var msg:String = intString(capteurID)+" "+intString(valeur);
			sendText(CAPTEUR_ETAT,msg);
		}

		public function sendEvitement(dirrection:uint):void{
			var msg:String = intString(dirrection);
			sendText(EVITEMENT_DIRECTION,msg);
		}
		
		public function start():void{
			var msg:String = "";
			sendText(START);
		}
		
		
		public function stop(motif:String):void{
			var msg:String = "";
			sendText(STOP);
		}
		
		public function couleur(isBlue:Boolean):void{
			var msg:String = boolString(isBlue);
			sendText(COULEUR,msg);
		}
		
		public function sendConfigAdversaire(config:uint):void{
			var msg:String = intString(config);
			sendText(CONFIG_ADVERSAIRE,msg);
		}
		
		public function sendPos_2_XYO(x:uint, y:uint, o:uint):void{
			var msg:String = intString(x)+" "+intString(y)+" "+intString(o);
			sendText(POS_2_XYO,msg);
		}
		public function sendPos_2_X(x:uint):void{
			var msg:String = intString(x);
			sendText(POS_2_X,msg);
		}
		public function sendPos_2_Y(y:uint):void{
			var msg:String = intString(y);
			sendText(POS_2_Y,msg);
		}
		public function sendPos_2_O(o:uint):void{
			var msg:String = intString(o);
			sendText(POS_2_O,msg);
		}
		
		public function sendPSoC(commande:String):void{
			sendText(TO_PSOC, commande);
		}
		
		public function sendMaia(commande:String):void{
			sendText(TO_MAIA, commande);
		}
		
		public function sendSimu(commande:String):void{
			sendText(TO_SIMU, commande);
		}
		
		public function reception(txt_msg:String):void{
			var commande:CommuncationCommand = new CommuncationCommand(txt_msg);
			var moteur:MoteurPrincipal = MoteurPrincipal.getInstance()
			Out.debug(commande.textCommand);
			
			switch(commande.commande){
				
				// SIMULATEUR PSOC
				case PARCOURS.name:
					//TODO
					break;
				case PHASE_EVIT_START.name:
					//TODO
					break;
				case PHASE_EVIT_STOP.name:
					//TODO
					break;
				case COMMANDE_TEXTE.name:
					//TODO
					break;

				case TO_MAIA.name:
					sendMaia(commande.getParamMessage());
					break;
				case TO_PSOC.name:
					sendPSoC(commande.getParamMessage());
					break;
				case TO_SIMU.name:
					Out.print("Reception directe (2SIMU) : " + commande.getParamMessage());
					reception(commande.getParamMessage());
					break;
				
				
				// LOGGEUR
				case MESSAGE.name:
					var msg:String =  commande.getParamMessage();
					Out.print(msg);
					break;
				
				
				
				// VISUALISATION
				case POS_XYO.name:
					moteur.sendPosXYO(
						commande.getParamFloat(0),
						commande.getParamFloat(1),
						commande.getParamFloat(2));
					break;
				case POS_X.name:
					moteur.setPosX(commande.getParamFloat(0));
					break;
				case POS_Y.name:
					moteur.setPosY(commande.getParamFloat(0));
					break;
				case POS_O.name:
					moteur.setPosO(commande.getParamFloat(0));
					break;
				case EVITEMENT_DIRECTION.name:
					moteur.setEvitement(commande.getParamInt(0));
					break;
				case CAPTEUR_ETAT.name:
					moteur.setEtatCapteur(commande.getParamString(0),commande.getParamString(1));
					break;
				case START.name:
					moteur.start();
					break;
				case STOP.name:
					moteur.stop(commande.getParamString(0));
					break;
				case CONFIG_ADVERSAIRE.name:
					moteur.setConfigAdversaire(commande.getParamMessage());
					break;
				case COULEUR.name:
					moteur.setCouleur(commande.getParamString(0));
					break;
				case POS_2_XYO.name:
					moteur.setPos_2_XYO(
						commande.getParamFloat(0),
						commande.getParamFloat(1),
						commande.getParamFloat(2));
					break;
				case POS_2_X.name:
					moteur.setPos_2_X(commande.getParamFloat(0));
					break;
				case POS_2_Y.name:
					moteur.setPos_2_Y(commande.getParamFloat(0));
					break;
				case POS_2_O.name:
					moteur.setPos_2_O(commande.getParamFloat(0));
					break;
				
				
				case ERROR_NO_COMMAND.name:
					Out.warning("Commande non interprétable: ["+commande.textCommand+"] (espace au début?)");
					break;
				case ERROR_BLANK_COMMAND.name:
					Out.warning("Commande vide");
					break;
				default:
					//Tag de Debug
					Out.warning("Le tag "+commande.commande+" n'est pas pris en charge.");
			}
		}
	}
}