package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import data.FastPrng;
	import data.Simplex;
	import data.map;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#999999")]	
	public class equipTest extends Sprite
	{
		private var hang:int = 600;
		private var lie:int = 800;
		private var colorArr:Array = [0xff0000,0xaa0000,0x550000,0x00ff00];
		public function equipTest()
		{
			var tmap:map = new map(hang,lie);
			var mapArr:Array = new Array();
			mapArr = tmap.getmap();
			for(var i:int = 0;i<lie;i++){
				for(var j:int = 0;j<hang;j++){
					//trace(mapArr[0][j][i]+"*****");
					this.graphics.beginFill(mapArr[0][j][i]*mapArr[0][j][i]*mapArr[0][j][i]);
					this.graphics.drawRect(i*1,j*1,1,1);
					this.graphics.endFill();
				}					
			}
		}
		private function randomEquip():void{
			
		}
	}
}