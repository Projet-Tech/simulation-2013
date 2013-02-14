package org.projetandtech.sim.core.map.items
{
	import org.projetandtech.sim.core.tools.Out;

	public class TypeItemMgr
	{
		
		
		private var _types:Vector.<TypeItem>;
		
		
		
		
		//////////////////////////////
		//////   CONSTRUCTEUR  //////
		/////////////////////////////
		
		
		public function TypeItemMgr()
		{
			_types = new Vector.<TypeItem>();
		}
		
		
		
		
		///////////////////////////////////
		//////   METHODES PUBLIQUES  //////
		///////////////////////////////////
		
		
		/**
		 * 
		 * @param type
		 * @return 
		 * 
		 */
		public function addType(type:TypeItem):TypeItem{
						
			// On verifie que le type n'est pas dupliqué.
			if(getType(type.nom)){
				Out.error("Declaration de type d'item " + type.nom + "dupliquée");
				return null;
			}
			
			// On ajoute le type a la liste.
			_types.push(type);
			return type;
		}
		
		
		
		public function getType(nom:String):TypeItem{
			
			// Parcourt la liste des types existant et renvoie si il y a correspondance en nom.
			for each(var t:TypeItem in _types){
				if(t.nom == nom)
					return t;
			}
			
			// Type non trouvé, renvoie null. 
			return null;
		}
		
		
		
		
		
		////////////////////////
		/// SERIALISATION //////
		////////////////////////
		
		
		public function load(datasXML:XML):void{
			
			//On ajoute tous les types d'item.
			for each( var typeXML:XML in datasXML.children()){
				
				// Recherche des attributs name et id.
				if(!typeXML.hasOwnProperty("@name")  || !typeXML.hasOwnProperty("@id"))
				{
					// Attribut name ou id non trouve.
					Out.error("Chargement XML TypeItem: attribut name ou id manquant");
				}
				else
				{
					// Attributs existants. On créé le TypeItem.
					var typeNom:String = typeXML.@name;
					var typeId:int = parseInt(typeXML.@id); 
					var type:TypeItem = new TypeItem(typeNom, typeId);
					
					// On rajoute tous les etats
					for each( var etatXML:XML in typeXML.children()){
						
						// Recherche des attributs name et valeurIni.
						if(!etatXML.hasOwnProperty("@name") || !etatXML.hasOwnProperty("@valeurIni")){
							// Attribut non trouve.
							Out.error("Chargement XML : dans le TypeItem " +  type.nom + " : attribut name ou valeurIni manquant");
						}
						else if (isNaN(parseFloat(etatXML.@valeurIni)))
						{
							Out.error("Chargement XML : dans le TypeItem " +  type.nom 
								+ " : impossible de convertir valeurIni en float");
						}
						else
						{
							// Attributs existants. On créé l'EtatItem.
							var etatNom:String = etatXML.@name;
							var etatValeurIni:Number = parseFloat(etatXML.@valeurIni);
							var etatIsIni:Boolean = (etatXML.@isEtatInitial == "true");
							var etat:EtatItem = new EtatItem(etatNom,etatValeurIni);
							
							// On ajoute l'état a l'item.
							
							type.addEtat(etat,etatIsIni);
							Out.debug(etat);
						}	
						
					}
					
					// On ajoute le TypeItem
					addType(type);
				}
			}
		}
		
		
		
		public function save():XMLList{
			
			// TODO
			// --------------------------------------------
			
			
			
			return null;
		}
	}
}