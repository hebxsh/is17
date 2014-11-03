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
		public function fighting(eType:int,eLevel:int):void{
			PlayerInit.p_status = 0;

			if (eType == 0){				
				guaiwu(eType,eLevel);
			}else if (eType == 1){				
				zhenfa(eType,eLevel);
			}else if (eType == 2){				
				migong(eType,eLevel);
			}else {				
				baowu(eType,eLevel);
			}
		}
		private function baowu(eType:int,eLevel:int):void{
			tooltip.show("你仔细搜查了这里似乎有所发现");
			//获取奖励
			Reward.getitem(eLevel);
		}
		//迷宫挑战
		private function migong(eType:int,eLevel:int):void{
			alone.mazedialog.level = eLevel;
			alone.mazedialog.theOpen();
		}
		//阵法挑战
		private function zhenfa(eType:int,eLevel:int):void{
			if (Math.random() < (100-DataInit.getSrote(PlayerInit.zhenfa))/100){
				tooltip.show("落入了一个阵法，历尽千辛破阵而出");
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