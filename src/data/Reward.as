package data
{
	import UI.ToolTip;
	
	import dialogs.LoadData;
	
	import event.CommEvent;

	public class Reward
	{
		public function Reward()
		{
		}
		public static function getitem(elev:int):void{
			var getaward:ChangeData = new ChangeData();
			getaward.refreshData("","award",elev);
			getaward.addEventListener(CommEvent.CHANGEDATA,loaddataHandler);
		}
		//加载数据
		private static function loaddataHandler(e:CommEvent = null):void{
			var temboj:Object = e.obj;
			for (var k:int = 0;k<temboj.length;k++){
				var tooltip:ToolTip = new ToolTip();
				var tstr:String = "<font color ='#00bb00'>获得</font>了"+ "<font color = '"+GameInit.getHtmlColor(temboj[k].level)+"'>"+temboj[k].name+"</font>\n";
				tooltip.show(tstr,140-(DataPool.getArr("sel").length-k)*42);
				if (alone.fightlayer.visible){
					alone.fightlayer.showReward(tstr);
				}
				if(int(temboj[k].id)<40000){
					LoadData.RefreshData("bag");
				}else{
					LoadData.RefreshData("userskill");
				}
			}
			
		}
	}
}