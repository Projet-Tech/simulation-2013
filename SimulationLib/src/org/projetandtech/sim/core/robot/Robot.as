package org.projetandtech.sim.core.robot
{
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.PointOrriente;
	import org.projetandtech.sim.core.parcours.Parcours;
	import org.projetandtech.sim.core.tools.Forme;

	public class Robot
	{
		private var _forme:Forme;
		private var _velocity:VelocityParams;
		private var _initPos:PointOrriente;
		private var _map:Map;
		private var _position:PointOrriente;
		
		private var _parcours:Parcours;
		private var _parcoursEtape:int;
		
		

		public function Robot(map:Map, initPos:PointOrriente, forme:Forme, velocity:VelocityParams)
		{
			_initPos = initPos;
			_velocity = velocity;
			_forme = forme;
			
			_position = initPos;
			_map = map;
			_parcours = new Parcours(/*_position*/);
		}
		
		public function update(diff:uint):void{
			//TODO gestion du déplacement.
			
			/*
			if(!isSimule)
				return
			
			actionRobot(parcoursAction, velocitiyParams, _tempsecoule) 
			
			while((diff = actionEnCours.executer(diff,this))> 0)
			{
				etape++;
				actionEnCours = getNextDeplacement(parcours,etape);
			}
			*/
			
		}
		
		public function get forme():Forme
		{
			return _forme;
		}

		public function set forme(value:Forme):void
		{
			_forme = value;
		}

		public function get velocity():VelocityParams
		{
			return _velocity;
		}

		public function set velocity(value:VelocityParams):void
		{
			_velocity = value;
		}

		public function get initPos():PointOrriente
		{
			return _initPos;
		}

		public function set initPos(value:PointOrriente):void
		{
			_initPos = value;
		}

		public function get map():Map
		{
			return _map;
		}

		public function set map(value:Map):void
		{
			_map = value;
		}

		public function get position():PointOrriente
		{
			return _position;
		}

		public function set position(value:PointOrriente):void
		{
			_position = value;
		}

		public function get parcours():Parcours
		{
			return _parcours;
		}

		public function set parcours(value:Parcours):void
		{
			_parcours = value;
		}

		

	}
}