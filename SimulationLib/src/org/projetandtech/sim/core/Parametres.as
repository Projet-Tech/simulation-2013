package org.projetandtech.sim.core
{
	public class Parametres
	{
		
		private var _paramsXMLList:XMLList;
		
		
		public function Parametres()
		{
			_paramsXMLList = new XMLList();
		}
		
		
		/**
		 * 
		 * @param $nomParametre
		 * @param $valeur
		 * @param $type
		 * 
		 */		
		public function setParametre($nomParametre:String, $valeur:String, $type:String = null):void
		{
			//TODO
		}

		
		/**
		 * 
		 */
		[Bindable]
		public function get paramsXMLList():XMLList
		{
			return _paramsXMLList;
		}

		public function set paramsXMLList(value:XMLList):void
		{
			_paramsXMLList = value;
		}
		

		
	}
}