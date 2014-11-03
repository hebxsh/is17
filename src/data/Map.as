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
			m_hang = DataPool.getArr("mountain")[level].hang;
			m_lie = DataPool.getArr("mountain")[level].lie;
			//var point:Point = random(hang,lie);
			
			for (var i:int = 0;i<m_hang;i++){
				mapArr.push(new Array());
				for (var j:int = 0;j<m_lie;j++){
					
					var mapObj:Object = {type:0,ground:0,level:0};
					mapArr[i].push(mapObj);
				}
			}			
			setlevel(level);
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