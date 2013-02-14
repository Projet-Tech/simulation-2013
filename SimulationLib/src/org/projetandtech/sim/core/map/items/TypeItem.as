package org.projetandtech.sim.core.map.items
{
	import org.hamcrest.core.throws;
	import org.projetandtech.sim.core.MoteurPrincipal;
	import org.projetandtech.sim.core.tools.Out;

	public class TypeItem
	{
		
		
		///////////////////////
		/// MEMBRES PUBLICS ///
		///////////////////////
		
		private var _etats:Vector.<EtatItem>;
		private var _id:int;
		private var _nom:String;
		private var _etatInitial:EtatItem;
		
		
		
		
		
		
		//////////////////////////////
		//////   CONSTRUCTEUR  //////
		/////////////////////////////
		
		
		public function TypeItem(nom:String,id:int)
		{
			this._nom = nom;
			this._id = id;
			this._etats = new Vector.<EtatItem>();
			this._etatInitial = null;
		}
		
		
		
		
		
		
		///////////////////////////////////
		//////   METHODES PUBLIQUES  //////
		///////////////////////////////////
		
		public function addEtat(etat:EtatItem, isDefault:Boolean = false):EtatItem{
			
			
			// Exception si l'etat existe déja
			if(getEtat(etat.nom) != null){
				Out.error("Declaration de l'etat d'item '" + etat.nom + "' dans l'item '" + this._nom + "' dupliquée");
				return null;
			}
			
			
			
			// TODO: 
			// Generer une exception si il n'y a pas d'état par défaut 
			
			// Si l'element est spécifié comme etant par defaut, on le désigne comme etat initial du type d'item.
			// De meme si aucun element par défaut est spécifié, on prendra le premier.
			if(isDefault || this._etatInitial == null){
				this._etatInitial = etat;
			}
			
			
			// On ajoute l'etat a la liste et le renvoie.
			this.etats.push(etat);
			return etat;
		}
		
		
		
		public function getEtat(etatNom:String):EtatItem{
			
			
			// Parcourt la liste des etats existant et renvoie si il y a correspondance en nom.
			for each(var e:EtatItem in this._etats){
				if(e.nom == etatNom)
					return e;
			}
			
			// Etat non trouvé, renvoie null. 
			return null;
		}
		
		
		///////////////////////////////////
		//////    METHODES PRIVEES   //////
		///////////////////////////////////
		
		
		
		///////////////////////////////////
		//////   METHODES STATIQUES  //////
		///////////////////////////////////
		

		
		
		///////////////////////////////////
		//// METHODES STATIQUES PRIVEES////
		///////////////////////////////////
		
		
		
		
		////////////////////////
		//// SERIALISATION /////
		////////////////////////
		
		
		
		
		
		
		//////////////////////////////
		//////GETTERS ET SETTERS/////
		/////////////////////////////
		
		
		
		public function get etats():Vector.<EtatItem>
		{
			return _etats;
		}

		public function set etats(value:Vector.<EtatItem>):void
		{
			_etats = value;
		}

		public function get nom():String
		{
			return _nom;
		}

		public function set nom(value:String):void
		{
			_nom = value;
		}

		public function get etatInitial():EtatItem
		{
			return _etatInitial;
		}

		public function set etatInitial(value:EtatItem):void
		{
			_etatInitial = value;
		}
		
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
		

		
		
		
		
		
		
		
		//////////////////////////////
		//////FONCTIONS USUELLES//////
		/////////////////////////////
		
		
		
		public function toString():String
		{
			return "(TypeItem: nom = " + this.nom+ ", id = "+this.id + ")";
		}

	}
}