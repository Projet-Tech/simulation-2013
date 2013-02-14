package org.projetandtech.sim.core.tools
{

	public class Forme
	{
		public static const FORME_RECTANGLE:String = "BOT_FORME_RECTANGLE";
		public static const FORME_CERCLE:String = "BOT_FORME_ROND";
		
		private var _forme:String;
		private var _largeur:Number;
		private var _hauteur:Number;
		/*
			TODO:
				
			sauvegarde propre des dimensions
		*/
		
		public function Forme(forme:String, largeur:Number, hauteur:Number)
		{ 
			if(forme == FORME_RECTANGLE || forme == FORME_CERCLE)
				_forme = forme;
			else
				return;
			
			_largeur = largeur;
			_hauteur = hauteur;
			
		}
		
		
		public static function genererRectangle(largeur:Number, hauteur:Number):Forme{
			try{
				var f:Forme = new Forme(FORME_RECTANGLE, largeur, hauteur);
				return f;
			}catch(e:Error){
				Out.error(e);
			}
			return null;
		}
		
		public static function genererCercle(rayon:Number):Forme{
			
			try{
				var f:Forme = new Forme(FORME_CERCLE, rayon, rayon);
				return f;
			}catch(e:Error){
				Out.error(e);
			}
			return null;
		}
		
		public function get type():String
		{
			return _forme;
		}

		public function get largeur():Number
		{
			if(_forme == FORME_RECTANGLE)
				return _largeur;
			
			return NaN;
		}

		public function set largeur(value:Number):void
		{
			if(_forme == FORME_RECTANGLE)
				_largeur = value;
		}

		public function get hauteur():Number
		{
			if(_forme == FORME_RECTANGLE)
				return _hauteur;
			
			return NaN;
		}

		public function set hauteur(value:Number):void
		{
			if(_forme == FORME_RECTANGLE)
				_hauteur = value;
		}


		public function get rayon():Number
		{
			if(_forme == FORME_CERCLE)
				return _hauteur;
			
			return NaN;
		}
		
		public function set rayon(value:Number):void
		{
			if(_forme == FORME_CERCLE)
			{
				_hauteur = value;
				_largeur = value;
			}
		}
		
	}
}