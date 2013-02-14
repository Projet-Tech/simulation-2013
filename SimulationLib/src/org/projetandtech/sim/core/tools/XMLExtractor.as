package org.projetandtech.sim.core.tools
{
	import flash.geom.Point;
	
	import org.projetandtech.sim.core.robot.VelocityParams;
	import org.projetandtech.sim.core.map.Map;
	import org.projetandtech.sim.core.map.PointOrriente;
	import org.projetandtech.sim.core.robot.Robot;

	public class XMLExtractor
	{
		public function XMLExtractor()
		{
		}
		
		public static function getNumber(XMLDatas:XML, paramName:String):Number{
			if(!XMLDatas.hasOwnProperty(paramName))
				throw new Error("attribut" + paramName + " manquant pour: \n" + XMLDatas.toXMLString());
			
			
			if(isNaN(parseFloat(XMLDatas[paramName])))
				throw new Error("attribut" + paramName + " non convertible en nombre pour: \n" + XMLDatas.toXMLString());
			
			return parseFloat(XMLDatas[paramName]);
		}
		
		
		public static function getNumberFacultatif(XMLDatas:XML, paramName:String):Number{
			return parseFloat(XMLDatas[paramName]);
		}
		
		
		
		
		public static function getString(XMLDatas:XML, paramName:String):String{
			if(!XMLDatas.hasOwnProperty(paramName))
				throw new Error("attribut " + paramName + " manquant pour: \n" + XMLDatas.toXMLString());
			
			return XMLDatas[paramName].toString();
		}
		
		public static function getStringFacultatif(XMLDatas:XML, paramName:String):String{
			return XMLDatas[paramName].toString();
		}
		
		
		
		//<forme type="rectangle" width="12" height="123" />
		//<forme type="rond" rayon="12" />
		public static function extractForme(XMLDatas:XML):Forme{
			if(XMLDatas.child("forme").length() < 1)
				throw new Error("Chargement de forme: Impossible de trouver un enfant <forme ... /> dans: /n" + XMLDatas);
			
			var XMLForme:XML = XMLDatas.child("forme")[0];
			
			try{
				var type:String = getString(XMLForme,"@type");
				switch(type.toLowerCase()){
					case "rectangle":
						var width:Number = getNumber(XMLForme,"@width");
						var height:Number = getNumber(XMLForme,"@height");
						return(Forme.genererRectangle(width,height));
						break;
					case "rond":
						var rayon:Number = getNumber(XMLForme,"@rayon");
						return(Forme.genererCercle(rayon));
						break;
					default:
						throw new Error("type de forme : \"" + type + "\" non définit. " +
							"Essayez avec \"rectangle\" ou \"rond\". +\n " + XMLForme);
				}
				
			}
			catch(err:Error){
				throw err;
			}
			
			return null;
			
		}
		
		
		/*				
		<robot_aliee_principal>
			<position_init x="120" y="11" o="1.1415" />
			<forme type="rond" rayon="12" />
			<velocite temps_demarage="0.2" temps_arret="0.3" vitesse_course="13" vitesse_rotation ="3.14"/>
		</robot_aliee_principal>
		*/
		
		public static function extractRobot(XMLDatas:XML,robotName:String,map:Map):Robot{
			try{
				var XMLRobot:XML = extractChild(XMLDatas,robotName);
			}
			catch(err:Error){
				throw new Error("Impossible de trouver la déclaration de <" + robotName + ">...</" + robotName + "> dans la section <robots>...</robots>");
			}
			
			
			try{
				var robotPosInit:PointOrriente = extractPointOrriente(XMLRobot,"position_init");
				var robotForme:Forme = extractForme(XMLRobot);
				var robotVelocityParams:VelocityParams = extractVelocityParams(XMLRobot);
				var robot:Robot = new Robot(map,robotPosInit,robotForme,robotVelocityParams);
				
				return robot;
			}catch(err:Error){
				Out.error(err);
			}
			return null;
		}
		
		public static function extractPointOrriente(datasXML:XML,pointName:String = null):PointOrriente{
			var pointXML:XML = extractChild(datasXML,pointName);
			var px:Number = getNumber(pointXML,"@x");
			var py:Number = getNumber(pointXML,"@y");
			var po:Number = getNumberFacultatif(pointXML,"@o");
			
			return new PointOrriente(px,py,po);
		}
		
		//<velocite temps_demarage="0.2" temps_arret="0.3" vitesse_course="13" vitesse_rotation ="3.14"/>
		public static function extractVelocityParams(datasXML:XML,velociteChildName:String = "velocite"):VelocityParams{
			var velXML:XML = extractChild(datasXML,velociteChildName);
			var tempsDemarage:Number = getNumber(velXML,"@temps_demarage");
			var tempsArret:Number = getNumber(velXML,"@temps_arret");
			var vitesseCourse:Number = getNumber(velXML,"@vitesse_course");
			var vitesseRotation:Number = getNumber(velXML,"@vitesse_rotation");
			
			return new VelocityParams(tempsDemarage,tempsArret,vitesseCourse,vitesseRotation);
		}
		
		public static function extractChild(XMLDatas:XML, childName:String = null):XML{
			if(childName == null)
				return XMLDatas;
			
			if(XMLDatas.child(childName).length() < 1){
				throw new Error("Impossible de trouver un enfant requis <" + childName + "> dans \n " + XMLDatas);
			}
			if(XMLDatas.child(childName).length() > 1){
				throw new Error("Duplication de la définition de l'enfant enfant <" + childName + "> dans \n " + XMLDatas);
			}
			
			return XMLDatas.child(childName)[0];
		}
	}
}