 package org.projetandtech.sim.core.map.items
{
	import org.projetandtech.sim.core.Identifiant;
	import org.projetandtech.sim.core.map.MapElement;
	import org.projetandtech.sim.core.map.PointOrriente;

	public class Item extends MapElement
	{
		private var _id:String // Identifiant;
		private var _pos:PointOrriente;
		private var _type:TypeItem;
		private var _etat:EtatItem;
		
		public function Item(id:String, type:TypeItem, etatInit:EtatItem, posX:Number, posY:Number)
		{
			_id = id;
			_type = type;
			_etat = etatInit;
			super(posX,posY);
		}
	}
}