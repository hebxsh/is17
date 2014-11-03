package UI
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import data.GameInit;

	public class Alert extends Sprite
	{
		private var bgSpr:Sprite;
		private var queBtn:MyButton;
		private var fanBtn:MyButton;
		public function Alert()
		{
		}
		//内容，头，1：只有确定，2：确定取消，确定返回函数，取消返回函数
		public function show(_text:String = "", _tit:String = "", btnNum:int = 1, queF:Function = null,closeF:Function = null):void {
			if (!bgSpr){
				bgSpr = new Sprite;
				this.addChild(bgSpr);
			}
			bgSpr.graphics.beginFill(0Xcccc77);
			bgSpr.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			var tit:MyText = new MyText(_tit,32,0xff0000);
			tit.x = (GameInit.m_stage.stageWidth - tit.width)/2;
			tit.y = 10;
			
			var panel:Panel = new Panel(GameInit.m_stage.stageWidth*0.8,GameInit.m_stage.stageHeight*0.7);
			var text:MyText = new MyText(_text);
			text.x = 10;
			panel.addContent(text);
			panel.x = (GameInit.m_stage.stageWidth - panel.width)/2;
			panel.y = tit.y+90;	
			panel.lastContents();
			   
			bgSpr.addChild(tit);
			bgSpr.addChild(panel);
			if(!queBtn) queBtn = new MyButton("确定");
			
			//将Alert实例添加到舞台最上面
			alone.alertSpr.addChild(bgSpr);

			if (btnNum == 1) {
				queBtn.x = (GameInit.m_stage.stageWidth - queBtn.width) / 2;
				queBtn.y = GameInit.m_stage.stageHeight*0.9;
			}else {
				var fanBtn:MyButton = new MyButton( "取 消");

				queBtn.x = (GameInit.m_stage.stageWidth - queBtn.width*3) / 2;
				queBtn.y = GameInit.m_stage.stageHeight*0.9 ;
				fanBtn.x = (GameInit.m_stage.stageWidth + queBtn.width) / 2;
				fanBtn.y = GameInit.m_stage.stageHeight*0.9 ;
				bgSpr.addChild(fanBtn);
				fanBtn.addEventListener(MouseEvent.CLICK, closeF);
			}
			bgSpr.addChild(queBtn);
			
			/*if (closeF != null)*/
			//自关闭事件以及callback事件。
			queBtn.addEventListener(MouseEvent.CLICK, queF);
			
		}
		public function close():void{
			bgSpr.visible = false;
		}
	}
}