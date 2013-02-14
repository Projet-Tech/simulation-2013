package org.projetandtech.sim.core.map.items
{
	import org.hamcrest.mxml.object.Null;

	public class EtatItem
	{
		
		private var _nom:String;
		private var _valeurInitiale:Number
		
		public function EtatItem(nom:String, valeurInitiale:Number)
		{
			this._nom = nom;
			this._valeurInitiale = valeurInitiale;
		}

		public function get nom():String
		{
			return _nom;
		}

		public function set nom(value:String):void
		{
			_nom = value;
		}

		public function get valeurInitiale():Number
		{
			return _valeurInitiale;
		}

		public function set valeurInitiale(value:Number):void
		{
			_valeurInitiale = value;
		}

		
		
		
		
		//////////////////////////////
		//////FONCTIONS USUELLES//////
		//////////////////////////////
		
		
		
		public function toString():String
		{
			return "[EtatItem: nom = " + this.nom+ ", valeurInitiale = "+this.valeurInitiale + "]";
		}
	}
}