package dialogs
{
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.Panel;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	
	public class SkillDialog extends DialogObject	{
		private var skiSpr:Panel;
		public function SkillDialog(){}
		
		override public function theOpen():void{
			this.visible = true;
			init();
		}
		private function init():void{			
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			skiSpr = new Panel(400,600);
			skiSpr.x = 40;
			skiSpr.y = 90;
			this.addChild(skiSpr);
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
			Refresh();
		}
		public static var useType:String;
		public function setTitle(str:String):void{
			useType = str;
			theTitle("技 能");
			theOpen();
		}
		
		//刷新技能
		public function Refresh():void{	
			skiSpr.removeContents();

			for (var i:int = 0;i<DataPool.getArr("userskill").length;i++){
				var temid:int = DataPool.getArr("userskill")[i].id;
				var tlevel:int = DataPool.getArr("userskill")[i].nowlevel;
				if (DataPool.getSel("skill",temid)){
					var skiitem:SkiItem = new SkiItem("skill",temid,tlevel,i);
					skiSpr.addContent(skiitem,10);					
				}
			}
		}
		
		public function closeHandler(e:MouseEvent = null):void{
			skiSpr.removeContents();
			//while(skiSpr.numChildren>0)skiSpr.removeChildAt(0);
			skiSpr.graphics.clear();
			this.theDest();
		}
	}
}