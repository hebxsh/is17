package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.MyText;
	
	import data.GameInit;

	public class EquipShow extends Sprite
	{
		public function EquipShow(tdata:Object,ts:int = 0)
		{
			this.graphics.beginFill(0X556677);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			var tstr:String = "";
			if(int(tdata.id)<20000){				
				tstr += "<font color='"+GameInit.getHtmlColor(tdata.level)+"'>"+tdata.name+"</font>\n\n";
				if(tdata.hp!="0")tstr += "气血：  "+tdata.hp+"\n";
				if(tdata.gongji!="0")tstr += "攻击：  "+tdata.gongji+"\n";
				if(tdata.fangyu!="0")tstr += "防御：  "+tdata.fangyu+"\n";
				if(tdata.bing!="0")tstr += "冰霜：  "+tdata.bing+"\n";
				if(tdata.huo!="0")tstr += "火焰：  "+ tdata.huo+"\n";
				if(tdata.du!="0")tstr += "毒素：  "+tdata.du+"\n";
				
				if (ts!==1){
					var dropEqu:MyButton = new MyButton("卸下",0xccccff);
					dropEqu.x = (this.width - dropEqu.width)>>1;
					dropEqu.y = int(this.height*.8);
					dropEqu.name = tdata.id+"";
					dropEqu.addEventListener(MouseEvent.CLICK,remEquHandler);
					this.addChild(dropEqu);
				}
			}else{
				tstr += "<font color='"+GameInit.getHtmlColor(tdata.level)+"'>"+tdata.name+"</font>\n\n";
				if(tdata.type=="1")tstr += "对目标造成攻击*"+tdata.percentage+"%+"+tdata.fixed+"伤害\n";
				if(tdata.type=="2")tstr += "对自身造成攻击*"+tdata.percentage+"%+"+tdata.fixed+"治疗\n";
				
				if (ts!==1){
					var dropSki:MyButton = new MyButton("卸下",0xccccff);
					dropSki.x = (this.width - dropSki.width)>>1;
					dropSki.y = int(this.height*.8);
					dropSki.name = tdata.id+"";
					dropSki.addEventListener(MouseEvent.CLICK,remSkiHandler);
					this.addChild(dropSki);
				}
			}
			var tf:MyText = new MyText(tstr);
			tf.x = 50;
			tf.y = 50;
			this.addChild(tf);
			this.addEventListener(MouseEvent.CLICK,cloHandler);			
		}
		private function remEquHandler(e:MouseEvent):void{
			alone.playerdialog.removeEqu();
		}
		private function remSkiHandler(e:MouseEvent):void{
			alone.playerdialog.removeSki();
		}
		private function cloHandler(e:MouseEvent):void{
			alone.topSpr.removeChildAt(0);
		}
	}
}