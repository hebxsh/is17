package data
{
	import flash.events.MouseEvent;
	
	import UI.ToolTip;
	

	public class Fight
	{
		private var tooltip:ToolTip;
		public function Fight()
		{
			tooltip = new ToolTip();
			alone.playerdialog.Refresh();
		}
		//点击地形开始战斗
		//["空","#0"],["怪","#1"],["静","#2"],["阵","#3"],["陷","#4"],["宝","#5"]
		
		public function fighting(eType:int,eLevel:int):void{
			PlayerInit.p_status = 0;

			if (eType == 0){				
				kongdi(eType,eLevel);
			}else if (eType == 1){				
				guaiwu(eType,eLevel);
			}else if (eType == 2){
				anjing(eType,eLevel);
			}else if (eType == 3){				
				zhenfa(eType,eLevel);
			}else if (eType == 4){				
				xianjing(eType,eLevel);
			}else if (eType == 5){				
				baowu(eType,eLevel);
			}
		}
		//空地
		private function kongdi(eType:int,eLevel:int):void{
			tooltip.show("这里似乎没什么发现");
			alone.maplayer.fightOver(true);
		}
		//安静
		private function anjing(eType:int,eLevel:int):void{
			tooltip.show("在这里收集到了一些材料");
			Reward.getitem(eLevel);
			alone.maplayer.fightOver(true);
		}
		//宝物
		private function baowu(eType:int,eLevel:int):void{
			tooltip.show("你仔细搜查了这里似乎有所发现");
			//获取奖励
			Reward.getitem(eLevel);
			alone.maplayer.fightOver(true);
		}
		//陷阱
		private function xianjing(eType:int,eLevel:int):void{
			if (Math.random()<.4){
				tooltip.show("这是个废弃的陷阱");
			}else if (Math.random()<.5){
				tooltip.show("这是个废弃的陷阱");
			}else{
				migong(eType,eLevel);
			}
		}
		//阵法挑战
		private function zhenfa(eType:int,eLevel:int):void{
			if (Math.random() < (100-DataInit.getSrote(PlayerInit.zhenfa))/100){
				tooltip.show("落入了一个阵法，历尽千辛破阵而出");
				alone.maplayer.fightOver(true);
			}else if (Math.random()<.5){
				guaiwu(eType,eLevel);
			}else{
				migong(eType,eLevel);
			}
		}
		//怪物战斗
		private function guaiwu(eType:int,eLevel:int):void{
			alone.fightlayer.level = eLevel;
			alone.fightlayer.theOpen();
		}
		//迷宫挑战
		private function migong(eType:int,eLevel:int):void{
			tooltip.show("进入一个迷阵之中");
			alone.mazedialog.level = eLevel;
			alone.mazedialog.theOpen();
		}
		private function queF(e:MouseEvent):void{
			//alert.close();
		}
		private function fanF(e:MouseEvent):void{
			
		}		
	
		private function die():void{
			PlayerInit.p_status = 1;
		}
	}
}