package data
{
	import flash.utils.ByteArray;

	public class DataInit
	{
		private static const d_m:int = 100;
		private static const d_c:int = 1;
		private static const d_x:Number = 0.05;
		public function DataInit()
		{
		}
		//获取随机数
		public static function getRandom(num:int):int{
			return int(Math.random()*num);
		}
		//获得随机等级
		public static function getRandomLevel(num:int,level:int):int{
			return Math.random()*(num-level);			
		}
		//
		public static function getSrote(num:int,dm:int = d_m,dc:int = d_c,dx:Number = d_x):Number{
			return dm/(dc+dx*num);			
		}
		//获得数据拷贝
		public static function getCopy(source:Object):Object{
			var myBA:ByteArray = new ByteArray(); 
			myBA.writeObject(source); 
			myBA.position = 0; 
			return(myBA.readObject()); 
		}
		//数组排序
		public static function paixu(arr:Array,str:String):void{
			
		}
		//获取等级经验
		public static function levelExp(lev:int):int{
			return (lev+1)*(lev+1)*(lev+1)*5+(lev+1)*(lev+1)*10+(lev+1)*10;
		}
	}
}