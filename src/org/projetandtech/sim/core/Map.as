package org.projetandtech.sim.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	public class Map
	{
		private var _dimensions:Rectangle;
		private var _imageSource:String;
		
		public function Map()
		{
			_imageSource = "assets/Aire_de_jeu_0.png";
		}
		
		public function load(datas:XMLList):void{
			
		}
		
		
		public function save():XMLList{
			
			return null;
		}
		
		
		
		
		[Bindable]
		public function get imageSource():String
		{
			return _imageSource;
		}

		public function set imageSource(value:String):void
		{
			_imageSource = value;
		}

	}
}