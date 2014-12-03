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
			var temarr:Object = getArr(str);
			if (!temarr)return 0;
			if(temarr[0].length>1){
				for (var i:int = 0;i<temarr[0].length;i++){
					if(temarr[0][i].id == tid){
						return temarr[0][i];
						break;
					}
				}
			}else{
				for (var j:int = 0;j<temarr.length;j++){
					if(temarr[j].id == tid){
						return temarr[j];
						break;
					}
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
			return dataArr[GameInit.getlid(str)] as Array;
		}
		//写入数据到程序
		public static function setData(str:String,obj:Object):void{
			if (!dataArr){
				dataArr = new Array();
				for (var i:int = 0;i<GameInit.dataArr.length;i++)dataArr.push(new Object());
			}
			dataArr[GameInit.getlid(str)] = obj;
		}
	}
}