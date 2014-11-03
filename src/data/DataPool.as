package data
{
	public class DataPool
	{
		//public static var dataArr:Array = [equipArr,userArr,bagArr,selArr];
		public static var dataArr:Array ;
		public function DataPool()
		{
			
		}
		public static function getSel(str:String,tid:int):Object{
			for (var i:int = 0;i<getArr(str).length;i++){
				if(getArr(str)[i].id == tid){
					return getArr(str)[i];
					break;
				}
			}
			return 0;
		}

		/*public static function getMonster(tid:int):Object{
			for (var i:int = 0;i<getArr("mountain").length;i++){
				if(getArr("mountain")[i].id == tid){
					return getArr("mountain")[i];
					break;
				}
			}
			return 0;
		}*/
		//根据类型返回数组
		public static function getArr(str:String):Array{
			if (!dataArr){
				dataArr = new Array();
				for (var i:int = 0;i<GameInit.dataArr.length;i++)dataArr.push(new Array());
			}
			return dataArr[GameInit.getlid(str)];
		}
	}
}