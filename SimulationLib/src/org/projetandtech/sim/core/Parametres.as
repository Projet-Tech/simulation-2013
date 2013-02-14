package org.projetandtech.sim.core
{
	import mx.collections.XMLListCollection;

	public class Parametres
	{
		public static const POSX:String = "Position X";
		public static const POSY:String = "Position Y";
		public static const POSO:String = "Position O";
		public static const VITESSE_THEO:String = "Vitesse théo";
		public static const VITESSE_MOY:String = "Vitesse moy";
		public static const VITESSE_INST:String = "Vitesse inst";
		
		private var _paramsCollection:XMLListCollection;
		
		
		public function Parametres()
		{
			_paramsCollection = new XMLListCollection();
			setParametre(POSX, "- -" );
			setParametre(POSY, "- -" );
			setParametre(POSO, "- -" );
			setParametre(VITESSE_THEO, "- -" );
			setParametre(VITESSE_MOY , "- -" );
			setParametre(VITESSE_INST, "- -" );
		}
		
		
		/**
		 * 
		 * @param nomParametre
		 * @param valeur
		 * 
		 */		
		public function setParametre(nomParametre:String, valeur:Object):void
		{
			
			
			for(var i:int = 0; i < _paramsCollection.length; i++){
				var elem:Object = _paramsCollection.getItemAt(i);
				if(elem.@name == nomParametre){
					elem.@valeur = valeur.toString();
					_paramsCollection.itemUpdated(elem);
					return;
				}
				
			}
			
			// Si le parametre n'existait pas:
			var param:XML = new XML("<parametre name='"+nomParametre+"' valeur='"+valeur.toString()+"' />");
			_paramsCollection.addItem(param);
			
			
		}

		
		/**
		 * 
		 */
		[Bindable]
		public function get paramsCollection():XMLListCollection
		{
			return _paramsCollection;
		}

		public function set paramsCollection(value:XMLListCollection):void
		{
			_paramsCollection = value;
		}
		

		
	}
}