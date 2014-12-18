package data
{
	public class Map
	{
		private var m_hang:int;
		private var m_lie:int;
		private var arr0:Array = [4,3,2,2,1,1];
		private var arr1:Array = [4,3,3,2,2,2,1,1,1,1];
		private var arr2:Array = [4,3,3,3,2,2,2,2,1,1,1,1,1];
		private var mapArr:Array;
		public function Map()
		{
		}
		public function getmap(level:int):Array{
			mapArr = new Array();
			///{需修改}
//			m_hang = 3;
//			m_lie = 3;
//			//var point:Point = random(hang,lie);
//			
//			for (var i:int = 0;i<m_hang;i++){
//				mapArr.push(new Array());
//				for (var j:int = 0;j<m_lie;j++){					
//					//var mapObj:Object = {type:0,ground:0,level:0};
//					//mapArr[i].push(mapObj);
//				}
//			}			
			//setlevel(level);
			//if (level == 0){
			var mapobj:Object =  DataPool.getArr("mountain")[level];
			m_hang = mapobj.hang;
			m_lie = mapobj.lie;
			var tar:Array = mapobj.mapdata.split(",");
			for (var i:int = 0;i<int(m_hang);i++){
				mapArr.push(new Array());
				for (var j:int = 0;j<int(m_lie);j++){
					var tarr:Array = tar[i*int(m_lie)+j].split("&");
					var mapObj1:Object = {ground:int(tarr[0]),level:int(tarr[1]),type:int(tarr[2])};
					mapArr[i].push(mapObj1);
				}
			}
			setlevel(level);
			//}
			return mapArr;
		}
		private function random(hang:int,lie:int,lev:int):void{
			var tem:Boolean = true;
			while(tem)	{
				var th:int = int(Math.random()*hang);
				var tl:int = int(Math.random()*lie);
				if(mapArr[th][tl].level==0){
					var leixing:int = DataInit.getRandomLevel(6,lev);
					var mapObj:Object = {type:leixing,ground:int(Math.random()*6),level:lev};
					mapArr[th][tl] = mapObj;
					tem = false;
				}
			}
			//return new Point(th,tl);
		}
		private function setlevel(level:int):void{
			var tarr:Array = new Array;
			var i:int = 0;
			if (level<6){
				for (i = 0;i<arr0.length;i++){
					random(m_hang,m_lie,arr0[i]);
				}
			}else if (level<10){
				for (i = 0;i<arr1.length;i++){
					random(m_hang,m_lie,arr1[i]);
				}
			}else{
				for (i = 0;i<arr2.length;i++){
					random(m_hang,m_lie,arr2[i]);
				}
			}			
		}
	}
}