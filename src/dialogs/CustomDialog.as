package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	import data.PlayerInit;

	public class CustomDialog extends DialogObject
	{
		private var lockArr:Array = new Array;
		public function CustomDialog()
		{
			init();
		}
		private function init():void{
			theTitle("关 卡");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
			
			var length:int = DataPool.getArr("mountain").length;
			for (var i:int = 0;i<length;i++){
				var moubtn:MyButton = new MyButton(DataPool.getArr("mountain")[i].name,0Xccaa77,80);
				moubtn.x = i%5*(moubtn.width+10)+20;
				moubtn.y = int(i/5)*(moubtn.height+20)+100;
				moubtn.name = i.toString();
				moubtn.addEventListener(MouseEvent.CLICK,moucHandler);				
				this.addChild(moubtn);
				
				//if (i>PlayerInit.p_custom){
					var loc:Sprite = lock();
					loc.x = i%5*(moubtn.width+10)+20;
					loc.y = int(i/5)*(moubtn.height+20)+100;
					this.addChild(loc);
					lockArr.push(loc);
				//}
			}
			Refresh();
		}
		//小锁遮挡
		private function lock():Sprite{
			var tSpr:Sprite = new Sprite;
			tSpr.graphics.beginFill(0Xccaa77);
			tSpr.graphics.drawRect(0,0,80,50);
			tSpr.graphics.beginFill(0Xdddddd);
			tSpr.graphics.drawCircle(40,20,13);
			tSpr.graphics.beginFill(0Xccaa77);
			tSpr.graphics.drawCircle(40,20,9);
			tSpr.graphics.beginFill(0Xdddddd);
			tSpr.graphics.drawRect(25,20,30,22);
			tSpr.graphics.beginFill(0Xccaa77);
			tSpr.graphics.drawCircle(40,28,4);
			tSpr.graphics.beginFill(0Xccaa77);
			tSpr.graphics.drawRect(38,31,4,8);
			return tSpr;
		}
		private function moucHandler(e:MouseEvent):void{
			alone.maplayer.level = int(e.currentTarget.name);
			alone.maplayer.theOpen();
			closeHandler();
		}
		//刷新属性
		public function Refresh():void{
			for (var i:int = 0;i<lockArr.length;i++){
				if (i<=PlayerInit.p_custom){
					lockArr[i].visible = false;
				}
			}
		}
		private function closeHandler(e:MouseEvent = null):void{
			//equSpr.removeContents();
			//while(equSpr.numChildren>0)equSpr.removeChildAt(0);
			//equSpr.graphics.clear();
			this.theDest();
		}
	}
}