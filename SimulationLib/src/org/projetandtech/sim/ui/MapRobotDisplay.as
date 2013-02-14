package org.projetandtech.sim.ui
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.robot.Robot;
	import org.projetandtech.sim.core.tools.Forme;
	

	public class MapRobotDisplay extends ElementEditable
	{
		public static const TYPE:String = "MAP_ROBOT_DISPLAY";
		private var _robot:Robot;
		private var _ratio:Number;
		public function MapRobotDisplay(mapview:MapView,robot:Robot,ratio:Number){
			super(mapview,TYPE);
			_robot = robot;
			_ratio = ratio;
			draw();
			positionner();
		}
		
		
		private function draw():void{
			if(_robot == null)
				return;
			
			var g:Graphics = graphics;
			g.lineStyle(2, 0, 1);
			g.beginFill(0, 0.4);
			if(_robot.forme.type == Forme.FORME_RECTANGLE){
				
				g.drawRect(-_robot.forme.largeur*_ratio/2,-_robot.forme.hauteur*_ratio/2,
					_robot.forme.largeur*_ratio,_robot.forme.hauteur*_ratio);
				
			}
			if(_robot.forme.type == Forme.FORME_CERCLE){
				g.drawCircle(0,0,_robot.forme.rayon*_ratio);
			}
			
			g.endFill();
			
			var h:Number = _robot.forme.rayon || _robot.forme.hauteur;
			var w:Number = _robot.forme.rayon || _robot.forme.largeur;
			
			g.moveTo(-w/2*_ratio,-h/6*_ratio);
			
			g.lineStyle(2,0xFFFFFF,1);
			g.beginFill(0xFFFFFF,0.6);
			
			g.lineTo(+w/2*_ratio,-h/6*_ratio);
			g.lineTo( 0         ,-h/3*_ratio);
			g.lineTo(-w/2*_ratio,-h/6*_ratio);
			
			g.endFill();
			
		}
		
		private function positionner():void{
			var m:Map = _robot.map;
			x = m.coordX(_robot.position.x);
			y = m.coordY(_robot.position.y);
			rotation = _robot.position.o*180/Math.PI;
		}
		
		
		
		
		
	}
	
}