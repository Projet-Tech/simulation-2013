package org.projetandtech.sim.ui
{
	public class EditionMode
	{
		
		private var _name:String;
		private var _label:String;
		private var _editablesTypes:Vector.<String>;
		
		public function EditionMode(name:String, label:String, ...rest)
		{
			_name = name;
			_label = label;
			_editablesTypes = new Vector.<String>;
			for(var i:uint = 0; i < rest.length; i++){
				_editablesTypes.push(rest[i].toString());
			}
			//_editablesTypes = editablesTypes; 
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

		public function get editablesTypes():Vector.<String>
		{
			return _editablesTypes;
		}

		public function set editablesTypes(value:Vector.<String>):void
		{
			_editablesTypes = value;
		}


	}
}