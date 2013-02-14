package org.projetandtech.sim.core.robot
{
	import org.projetandtech.sim.core.map.PointOrriente;
	import org.projetandtech.sim.core.parcours.ParcoursAction;
	import org.projetandtech.sim.core.parcours.ParcoursActionGoTo;
	import org.projetandtech.sim.core.parcours.ParcoursActionInit;
	import org.projetandtech.sim.core.parcours.ParcoursActionRotate;
	import org.projetandtech.sim.core.parcours.ParcoursActionWait;

	public class ActionRobot
	{
		
		private var _parcoursAction:ParcoursAction;
		private var _velocitiyParams:VelocityParams;
		private var _tempsEcoule:Number;
		private var _robot:Robot;
		private var _posIni:PointOrriente;
		
		public function ActionRobot(parcoursAction:ParcoursAction,velocitiyParams:VelocityParams,robot:Robot)
		{
			
			_parcoursAction = parcoursAction;
			_velocitiyParams = velocitiyParams;
			_robot = robot;
			_posIni = robot.position;
		}
		
		public function execute(diff:uint):uint{
			var diff_ret:uint = diff;
			var pos:PointOrriente;
			switch(_parcoursAction.type){
				case ParcoursActionGoTo.TYPE:
				{
					var goto:ParcoursActionGoTo = _parcoursAction as ParcoursActionGoTo;
					//TODO
					break;
				}
					
				case ParcoursActionInit.TYPE:
				{	
					var ini:ParcoursActionInit = _parcoursAction as ParcoursActionInit;
					pos = new PointOrriente(ini.posX,ini.posY,_posIni.o);
					
					break;
				}
		
				case ParcoursActionWait.TYPE:
				{
					var wait:ParcoursActionWait = _parcoursAction as ParcoursActionWait;
					_tempsEcoule += diff;
					diff_ret = Math.min(_tempsEcoule - wait.durationMili,0);
					break;
				}
				case ParcoursActionRotate.TYPE:
				{
					var rot:ParcoursActionRotate = _parcoursAction as ParcoursActionRotate;
					//TODO
					break;
				}		
			}
			return diff;
		}
		
		private static function getRatioFunction(temps, qtMvt, attenteIni, attenteFin, vitesseCourse, acceleration):Number
		{
			//TODO
			
			return 0;
		}
	}
}