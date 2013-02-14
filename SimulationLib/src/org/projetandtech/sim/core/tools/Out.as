package org.projetandtech.sim.core.tools
{
	import flash.globalization.DateTimeFormatter;
	
	import mx.formatters.Formatter;
	
	import org.hamcrest.core.throws;

	public class Out
	{
		private static var outPrintCible:Vector.<IOutPrinter>;
		
		public static function addPrintCible(target:IOutPrinter):void{
			if(!outPrintCible)
				outPrintCible = new Vector.<IOutPrinter>();
			outPrintCible.push(target);
		}
		
		
		public static function print(o:Object):void{
			var val:String = (o != null) ? (o.toString()) : "null value"; 
			trace(getNow(), val);
			for each(var target:IOutPrinter in outPrintCible){
				target.print(getNow()+ " " + val);
			}
		}
		
		public static function error(o:Object):void{
			var val:String = (o != null) ? (o.toString()) : "null value";
			var err:Error = new Error(val);
			
			var mess:String = err.getStackTrace();
			trace(getNow(),mess);
			for each(var target:IOutPrinter in outPrintCible){
				target.print(getNow()+ " " + val);
			}
		}
		public static function warning(o:Object):void{
			var val:String = (o != null) ? (o.toString()) : "null value"; 
			
			var err:Error = new Error(val);
			trace(getNow(), "Warning:", val, err.getStackTrace());
			
			for each(var target:IOutPrinter in outPrintCible){
				target.print(getNow()+ " " + val);
			}
			
		}
		
		public static function debug(o:Object):void{
			var val:String = (o != null) ? (o.toString()) : "null value"; 
			trace(getNow(), "Debug:" + val);
			
			for each(var target:IOutPrinter in outPrintCible){
				//target.print(getNow()+ " " + val);
			}
		}
		
		public static function detail(o:Object):void{
			var val:String = (o != null) ? (o.toString()) : "null value"; 
			trace(getNow(), "Detail:" + val);
			for each(var target:IOutPrinter in outPrintCible){
				//target.print(getNow()+ " " + val);
			}
		}
		
		
		
		private static function getNow():String{
			var dtf:DateTimeFormatter = new DateTimeFormatter("fr-FR","short","medium");
			return "[" + dtf.format(new Date()) + "]";
		}
	}
}