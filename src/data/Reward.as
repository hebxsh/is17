package data
{
	import UI.ToolTip;

	public class Reward
	{
		private static var itemArr:Array = [[30,15,5,.5,.1],
											[40,20,7,1,.2],
											[35,18,10,4,.5],
											[15,20,30,10,1],
											[5,15,20,20,5]];
		public function Reward()
		{
		}
		public static function getitem(elev:int):String{
			getStatus(elev); 
//			if(Math.random()<.3){
//				SqlDb.select("equip","sel","WHERE level="+tlev+" ORDER BY RANDOM() LIMIT 1;");
//			}else if(Math.random()<.5){
//				SqlDb.select("skill","sel","WHERE level="+tlev+" ORDER BY RANDOM() LIMIT 1;");
//			}else{
//				trace ("没有奖励");
//			}
			var showStr:String = "";
			for (var k:int = 0;k<DataPool.getArr("sel").length;k++){				
				SqlDb.insert("bag",{id:DataPool.getArr("sel")[k].id,num:1});	
				var tooltip:ToolTip = new ToolTip();
				var tstr:String = "<font color ='#00bb00'>获得</font>了"+ "<font color = '"+GameInit.getHtmlColor(DataPool.getArr("sel")[k].level)+"'>"+DataPool.getArr("sel")[k].name+"</font>\n";
				tooltip.show(tstr,140-(DataPool.getArr("sel").length-k)*42);
				showStr += tstr;
			}
			
			return showStr;
		}
		//将奖励插入奖励表
		private static function getStatus(elev:int):void{
			DataPool.getArr("sel").splice(0);
			for (var i:int = 0;i<itemArr[elev].length;i++){
				if(Math.random()*100<itemArr[elev][i]){
					if(Math.random()<.5){
						SqlDb.select("equip","sel","WHERE level="+i+" ORDER BY RANDOM() LIMIT 1;");
					}else if(Math.random()<.6){
						SqlDb.select("skill","sel","WHERE level="+i+" ORDER BY RANDOM() LIMIT 1;");
					}else{
						trace ("没有奖励");
					}
				}
			}
			
			//return 0;
		}
	}
}