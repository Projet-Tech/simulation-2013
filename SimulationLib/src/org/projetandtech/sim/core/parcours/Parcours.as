package org.projetandtech.sim.core.parcours
{
	import mx.collections.ArrayCollection;
	
	import org.projetandtech.sim.core.map.PointOrriente;

	public class Parcours
	{
		private var _actions:ArrayCollection;
		private var _initialPos:ParcoursActionInit;
		
		public function Parcours(initialPos:PointOrriente = null)
		{
			_actions = new ArrayCollection();
			_initialPos = new ParcoursActionInit(0,0,0);
			
			
			_actions.addItem(_initialPos);
			
			_actions.addItem(new ParcoursActionGoTo(1000,200));
			_actions.addItem(new ParcoursActionGoTo(2000,500));
			_actions.addItem(new ParcoursActionWait("17"));
			_actions.addItem(new ParcoursActionGoTo(1000,300));
			_actions.addItem(new ParcoursActionRotate(10));
			_actions.addItem(new ParcoursActionGoTo(200,1320));
			_actions.addItem(new ParcoursActionGoTo(1000,200));
			_actions.addItem(new ParcoursActionGoTo(2000,500));
			_actions.addItem(new ParcoursActionWait());
			_actions.addItem(new ParcoursActionGoTo(1000,300));
			_actions.addItem(new ParcoursActionRotate(10));
			_actions.addItem(new ParcoursActionGoTo(200,1320));
			_actions.addItem(new ParcoursActionGoTo(200,1320));
			_actions.addItem(new ParcoursActionGoTo(1000,200));
			_actions.addItem(new ParcoursActionGoTo(2000,500));
			_actions.addItem(new ParcoursActionWait());
			_actions.addItem(new ParcoursActionGoTo(1000,300));
			_actions.addItem(new ParcoursActionRotate(10));
			_actions.addItem(new ParcoursActionGoTo(200,1320));
			
		}
		
		public function appliCommand(id:int, posX:Number,posY:Number,posO:Number,action:Number):void{
			var i:int;
			
			// Complétion des vides si l'id est superieur au nombre d'actions.
			var diff:int = id-_actions.length-2;
			for(i = 0; i < diff; i++){
				_actions.addItem(new ParcoursActionWait("",0));
			}
			
			if(id < _actions.length && id > 0){
				_actions.setItemAt(new ParcoursActionGoTo(posX,posY),id);
			}
		}
		
		[Bindable]
		public function get actions():ArrayCollection
		{
			return _actions;
		}

		public function set actions(value:ArrayCollection):void
		{
			_actions = value;
		}

		public function get initialPos():PointOrriente
		{
			return _initialPos.pointOriente;
		}

		public function set initialPos(value:PointOrriente):void
		{
			_initialPos.pointOriente = value;
		}


	}
}