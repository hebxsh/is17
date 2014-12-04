package dialogs
{
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.Panel;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	
	public class SkillDialog extends DialogObject	{
		private var skiPanel:Panel;
		public function SkillDialog(){}
		
		override public function theOpen():void{
			this.visible = true;
			init();
		}
		private function init():void{
			theTitle("技 能");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			if (!skiPanel) skiPanel = new Panel(400,600);
			skiPanel.x = 40;
			skiPanel.y = 90;
			this.addChild(skiPanel);
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
			Refresh();
		}
		public static var useType:String;
		private var useTab:int;
		public function setTitle(str:String,tabid:int = 0):void{
			useType = str;
			useTab = tabid;				
			theOpen();
		}
		
		//刷新技能
		public function Refresh():void{	
			if (!skiPanel)return;
			skiPanel.removeContents();
			if(DataPool.getArr("userskill")){
				for (var i:int = 0;i<DataPool.getArr("userskill").length;i++){
					var temid:int = DataPool.getArr("userskill")[i].id;
					var tlevel:int = DataPool.getArr("userskill")[i].nowlevel;
					if(useTab == 1){//根据选项卡选择展示的技能
						if (DataPool.getSel("skill",temid)&&DataPool.getSel("skill",temid)['type']=="8"){
							var skiitem1:SkiItem = new SkiItem("skill",temid,tlevel,i);
							skiPanel.addContent(skiitem1,10);					
						}
					}else if(useTab == 9){
						if (DataPool.getSel("skill",temid)){
							var skiitem2:SkiItem = new SkiItem("skill",temid,tlevel,i);
							skiPanel.addContent(skiitem2,10);					
						}
					} else {
						if (DataPool.getSel("skill",temid)&&int(DataPool.getSel("skill",temid)['type'])<8){
							var skiitem3:SkiItem = new SkiItem("skill",temid,tlevel,i);
							skiPanel.addContent(skiitem3,10);					
						}
					}
				}
			}
		}
		
		public function closeHandler(e:MouseEvent = null):void{
			skiPanel.removeContents();
			//while(skiPanel.numChildren>0)skiPanel.removeChildAt(0);
			//skiPanel.graphics.clear();
			this.theDest();
		}
	}
}