package org.projetandtech.sim.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.rpc.soap.LoadEvent;
	
	import org.projetandtech.sim.core.comm.SocketCommunicateur;
	import org.projetandtech.sim.core.config.SimConfig;
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.PointOrriente;
	import org.projetandtech.sim.core.map.items.TypeItem;
	import org.projetandtech.sim.core.map.items.TypeItemMgr;
	import org.projetandtech.sim.core.robot.Robot;
	import org.projetandtech.sim.core.tools.XMLSerialLoader;

	public class Simulation extends EventDispatcher
	{
		
		private var _mode:MoteurMode;
		private var _map:Map;
		
		private var _idMgr:IdentifiantMgr;
		
		private var matchTime:Number;
		private var displayTime:Number;
		
		private var matchTimer:Timer;
		
		private var _comm:SocketCommunicateur;
		
		private var _params:Parametres = new Parametres();
		
		public static const STOP_REASON_END:int = 0;
		
		public static const MATCH_DURATION:int = 90000;
		public function Simulation(mode:String = MoteurMode.SIMULATION)
		{
			this._mode = new MoteurMode(mode);
			this._map = new Map(this);
			
			matchTime = 0;
			displayTime = 0;
			matchTimer = new Timer(SimConfig.UPDATE_DELAY,0);
			
			registerEvents();
					
			
		}       
		
		private function registerEvents():void{
			new XMLSerialLoader(SimConfig.XML_INFO_FILE_PATH).addEventListener(Event.COMPLETE,loadingComplete);
			matchTimer.addEventListener(TimerEvent.TIMER,matchTimerHandler);
		}
		
		
		private function matchTimerHandler(evt:TimerEvent):void{
			matchTime += matchTimer.delay;
			update(matchTimer.delay);
		}
		
		private function loadingComplete(e:Event):void{
			var loader:XMLSerialLoader = e.target as XMLSerialLoader;
			load(loader.datas);
			
		}
		
		public function load(datasXML:XML):void{
			
			
			_map.loadTypeItems(new XML(datasXML.child("types_item")));
			_map.load(new XML(datasXML.child("map")));
			
			dispatchEvent(new Event("LOADED"));
		}
		

		
		
		public function save():XMLList{
			
			//TODO
			return null;
		}

		public function get map():Map
		{
			return _map;
		}

		public function set map(value:Map):void
		{
			_map = value;
		}
		
		public function start():void{
			matchTime = 0;
			matchTimer.start();
		}
		
		public function stop():void{
			matchTimer.stop();
			if(isSimulationMode){
				
			}
		}
		

		
		public function setDisplayTime(time:Number):void{
			
		}
		
		public function setRobotPisition(robotType:String,position:PointOrriente):void{
			
		}
		
		private function update(diff:Number):void{
			if(isSimulationMode){
				if(matchTime > MATCH_DURATION)
					matchTime = MATCH_DURATION;
				
				stop();
				map.robotAlliePrincipal.update(diff);
				map.robotEnnemiPrincipal.update(diff);
				
			}
			else{
				map.robotEnnemiPrincipal.update(diff);
			}
			
		}
		
		private function get isSimulationMode():Boolean{
			return _mode.get() == MoteurMode.SIMULATION;
		}

		[Bindable]
		public function get params():Parametres
		{
			return _params;
		}

		public function set params(value:Parametres):void
		{
			_params = value;
		}

	}
}