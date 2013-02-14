package org.projetandtech.sim.core
{
	import org.projetandtech.sim.core.tools.Out;

	public class IdentifiantMgr
	{
		
		private var _objects:Object;
		public function IdentifiantMgr()
		{
			_objects = new Object();
		}
		
		public function getByRef(ref:String):Object{
			return _objects[ref];
		}
		
		public function createIdentifiant(obj:Object, id:String):void{
			
			if(getByRef(id)){
				Out.error("Reference d'objet dupliquée (ref: " + id + ")");
				return;
			}
			
			_objects[id] = obj;
		}
		
		public function getObject(id:String):Object{
			return _objects[id];
		}
	}
}