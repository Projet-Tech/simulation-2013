package org.projetandtech.sim.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.events.DragEvent;
	
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.tools.Out;
	
	public class ElementEditable extends Sprite
	{
		protected var _type:String;
		//protected var _isEditable:Boolean;
		protected var _isMovable:Boolean;
		protected var _isClickable:Boolean;
		protected var _isDown:Boolean;
		protected var _isSelected:Boolean;		
		protected var _isDragging:Boolean;
		protected var _isOver:Boolean;
		protected var _mousePosInit:Point;
		
		protected var _mapview:MapView;
		
		protected var _distanceDecrochage:Number = 20;
		
		protected var over_size:Number = 1.2;
		protected var down_size:Number = 1.4;
		
		public function ElementEditable(mapview:MapView , type:String)
		{
			super();
			_type = type;
			_mapview = mapview;
			
			
			_isDown = false;
			_isSelected = false;
			//_isEditable = true;
			_isMovable = true;
			_isClickable = true;
			_isDragging = false;
			_isOver = false;
			registerEvent();
		}

		
		private function registerEvent():void{
			addEventListener(MouseEvent.MOUSE_OVER,mouseOver_handler);
			addEventListener(MouseEvent.MOUSE_OUT,mouseOut_handler);
			
			addEventListener(MouseEvent.MOUSE_DOWN,mouseDown_handler);
			if(stage){
				stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp_handler);
			}
			else{
				addEventListener(Event.ADDED_TO_STAGE,addedToStage_Handler);
			}
			addEventListener(MouseEvent.CLICK,mouseClick_handler);
			
			
		}
		
		
		protected function addedToStage_Handler(evt:Event):void{
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp_handler);
		}
		
		protected function mouseOver_handler(evt:MouseEvent):void{
			if(!isEditable)
				return;
			
			_isOver = true;
			
			updateScale();
			
		}
		protected function mouseOut_handler(evt:MouseEvent):void{
			if(!isEditable)
				return;
			
			_isOver = false;
			updateScale();
		}
		
		protected function mouseDown_handler(evt:MouseEvent):void{
			if(!isEditable)
				return;
			
			
			_isDown = true;
			_mousePosInit = new Point(mouseX,mouseY);
			addEventListener(Event.ENTER_FRAME,mouseEnterFrame_handler);
			updateScale();
		}
		
		protected function mouseUp_handler(evt:MouseEvent):void{
			if(!isEditable)
				return;
			
			
			_isDown = false;
			_isDragging = false;
			stopDrag();
			removeEventListener(Event.ENTER_FRAME,mouseEnterFrame_handler);
			updateScale();
		}
		
		protected function mouseEnterFrame_handler(evt:Event):void{
			var dist:Number = Point.distance(new Point(mouseX,mouseY),_mousePosInit);
			var m:Map = _mapview.map;
			if(dist >= _distanceDecrochage){
				startDrag(true,
					new Rectangle(m.coordX(0),m.coordY(0),
						m.coordX(m.dimensions.width),m.coordY(m.dimensions.height)
						)
					);
				_isDragging = true;
				removeEventListener(Event.ENTER_FRAME,mouseEnterFrame_handler);
				updateScale();
				
			}
		}
		
		protected function mouseClick_handler(evt:MouseEvent):void{
			if(!_isClickable)
				return;
			
			openMenu();
		}
		
		protected function openMenu():void{
			//TODO
			
		}
		protected function updateScale():void{
			if(_isDragging){
				setScale(1);
				return;
			}
			if(_isDown){
				setScale(down_size);
				return;
			}
			if(_isOver){
				setScale(over_size);
				return;
			}
			setScale(1);
		}
		
		protected function setScale(val:Number):void{
			scaleX = val;
			scaleY = val;
		}
		
		public function get isEditable():Boolean
		{
			return UIControleur.getInstance().isEditable(this);
		}
		/*
		public function set isEditable(value:Boolean):void
		{
			_isEditable = value;
		}
		*/
		[Bindable]
		public function get isMovable():Boolean
		{
			return _isMovable;
		}

		public function set isMovable(value:Boolean):void
		{
			_isMovable = value;
		}

		[Bindable]
		public function get isClickable():Boolean
		{
			return _isClickable;
		}

		public function set isClickable(value:Boolean):void
		{
			_isClickable = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}


	}
}