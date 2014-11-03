package UI
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	
	import data.GameInit;

	public class ToolTip extends Sprite
	{
		//public static var spr:Sprite;
		private var tipList:Array = new Array();
		private const inity:int = 130;
		public function ToolTip()
		{
		}
		public function show(str:String,y:int = inity):void{
			var txt:MyText = new MyText(str);
			txt.x = txt.y = 5;
			var spr:Sprite = new Sprite;
			spr.graphics.beginFill(0xffffcf,0.5);
			spr.graphics.drawRect(0,0,txt.width+10,txt.height+10);
			spr.x = (GameInit.m_stage.stageWidth-txt.width)>>1;
			spr.y = y;
			spr.addChild(txt);
			GameInit.m_stage.addChild(spr);
			GameInit.tipArr.unshift(spr);
			Refresh();
			TweenLite.to(spr,1,{delay:1,alpha:0,onComplete:comFun,onCompleteParams:[spr]});
		}
		private function comFun(spr:Sprite):void{
			GameInit.m_stage.removeChild(spr);
			GameInit.tipArr.pop();
		}
		private function Refresh():void{			
			for(var i:int = 0;i<GameInit.tipArr.length;i++){
				GameInit.tipArr[i].y = inity - i*42;
			}
		}
	}
}