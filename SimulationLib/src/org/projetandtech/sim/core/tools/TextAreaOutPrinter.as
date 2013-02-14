package org.projetandtech.sim.core.tools
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import spark.components.TextArea;

	public class TextAreaOutPrinter implements IOutPrinter
	{
		private var _target:TextArea;
		private var buffer:String = "";
		private var timer:Timer;
		private var needUpdate:Boolean = false;
		public function TextAreaOutPrinter(targetTA:TextArea)
		{
			_target = targetTA;
			timer = new Timer(100,0);
			
			timer.addEventListener(TimerEvent.TIMER,update);
			timer.start()
				
		}
		
		public function print(msg:String):void
		{
			buffer+="\n"+msg;
			needUpdate = true;
		}
		
		public function update(event:TimerEvent):void{
			if(!needUpdate)
				return;
			
			
			_target.appendText(buffer);
			
			buffer = "";
			needUpdate = false;
		}
	}
}