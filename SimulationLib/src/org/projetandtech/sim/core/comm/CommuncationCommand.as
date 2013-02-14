package org.projetandtech.sim.core.comm
{
	public class CommuncationCommand{
		
		private var _commande:String;
		private var _params:Vector.<String>;
		private var _textCommand:String;
		
		function CommuncationCommand(textCommand:String = ""){
			_textCommand = textCommand.toUpperCase().replace(/ +(?= )/g,'');
			_commande = recupererCommande(textCommand);
			_params = recupererParametres(textCommand);
		}
		
		public function getParamFloat(index:int):Number{
			if(index >= _params.length)
				return NaN;
			
			return parseFloat(_params[index]);
		}
		
		public function getParamInt(index:int):int{
			if(index >= _params.length)
				return NaN;
			
			return parseInt(_params[index]);
		}
		
		public function getParamUint(index:int):uint{
			if(index >= _params.length)
				return null;
			
			return parseInt(_params[index]);
		}
		
		public function getParamString(index:int):String{
			if(index >= _params.length || index < 0)
				return null;
			
			return _params[index];
		}
		
		
		public function getParamMessage():String{
			var index:int = _textCommand.search(" ");
			if(index == -1)
				return "";
			
			return _textCommand.slice(index+1);
		}
		
		public function getNumParam():int{
			return _params.length;
		}
		
		private function recupererCommande(textCommand:String = ""):String{
			
			var tmp:Array = textCommand.toUpperCase().split(" ",1);
			
			if(tmp.length == 0){
				return SocketCommunicateur.ERROR_NO_COMMAND.toString();
			}
			else if(tmp[0] == ""){
				return SocketCommunicateur.ERROR_BLANK_COMMAND.toString();
			}
			
			return tmp[0];
			
			
		}
		
		private function recupererParametres(textCommand:String = ""):Vector.<String>{
			
			var out:Vector.<String> = new Vector.<String>();
			var tmp:Array = textCommand.split(" ");
			
			for(var i:int = 1; i < tmp.length; i++){
				out.push(tmp[i]);
			}
			
			return out;
		}
		
		public function get commande():String
		{
			return _commande;
		}
		
		public function get params():Vector.<String>
		{
			return _params;
		}
		
		public function get textCommand():String
		{
			return _textCommand;
		}
		
	}
}