package org.projetandtech.sim.ui
{
	import flashx.textLayout.edit.EditingMode;
	
	import org.projetandtech.sim.ui.ParcoursPanelComponents.ParcoursMapPoint;

	public class UIControleur
	{
		
		private static const EDITION_MODE_ROBOT:String = "EDITION_MODE_ROBOT";
		private static const EDITION_MODE_MAP:String   = "EDITION_MODE_MAP";
		private static const EDITION_MODE_NULL:String  = "EDITION_MODE_NULL";
		
		private var _editions_corresp:Array
		
		private var _edition_mode:String = EDITION_MODE_ROBOT;
		private static var __instance:UIControleur;
		
		public function UIControleur(STATIC_CLASS:StaticClass)
		{			
			initCorresp();
		}
		
		public static function getInstance():UIControleur{
			if(!__instance)
				__instance = new UIControleur(new StaticClass);
			
			return __instance
		}
		
		private function initCorresp():void{
			_editions_corresp = new Array();
			_editions_corresp.push(new EditionMode(EDITION_MODE_ROBOT,"Robots",MapRobotDisplay.TYPE,ParcoursMapPoint.TYPE));
			_editions_corresp.push(new EditionMode(EDITION_MODE_MAP,"Map",MapComponent.TYPE));
			_editions_corresp.push(new EditionMode(EDITION_MODE_NULL,"Rien"));
		}
		
		private function getEditTypes(modName:String):Vector.<String>{
			for each(var mod:EditionMode in _editions_corresp){
				if(mod.name == modName)
					return mod.editablesTypes
			}
			
			return new Vector.<String>;
				
		}
		public function isEditable(elem:ElementEditable):Boolean{
			
			var possibilites:Vector.<String> = getEditTypes(_edition_mode);
			
			for each(var poss:String in possibilites){
				if(elem.type == poss)
					return true
			}
			return false;
		}
		
		public function setEditionMode(mode:String):void{
			_edition_mode = mode;
		}
		
		public function sendParcours():void{
			
		}

		
		[Bindable]
		public function get editions_corresp():Array
		{
			return _editions_corresp;
		}

		public function set editions_corresp(value:Array):void
		{
			_editions_corresp = value;
		}

		
	}
	
}

internal class StaticClass{}