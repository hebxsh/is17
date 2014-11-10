package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.MyText;
	
	import data.GameInit;
	import data.PlayerInit;

	public class ItemShow extends Sprite
	{
		public function ItemShow(tdata:Object,ts:int = 0)
		{
			this.graphics.beginFill(0X556677);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			var tstr:String = "";
			tstr += "<font color='"+GameInit.getHtmlColor(tdata.level)+"'>"+tdata.name+"</font>\n";
			if(int(tdata.id)<20000){
				var ttype:String = "";
				if (tdata.type =="1")ttype = "武器";
				if (tdata.type =="2")ttype = "防具";
				if (tdata.type =="3")ttype = "法宝";
				tstr += "类型： "+ttype+"\n\n";
				
				for (var i:int = 0;i<PlayerInit.p_xsArr.length;i++){			
					for(var property:String in tdata){				
						if (property == PlayerInit.p_xsArr[i][0]){
							if(tdata[property]!="0")tstr += PlayerInit.getName(property)+"：  "+tdata[property]+"\n";
						}
					}
				} 
				
				if (ts!==1){
					var dropEqu:MyButton = new MyButton("卸下",0xccccff);
					dropEqu.x = (this.width - dropEqu.width)>>1;
					dropEqu.y = int(this.height*.85);
					dropEqu.name = tdata.id+"";
					dropEqu.addEventListener(MouseEvent.CLICK,remEquHandler);
					this.addChild(dropEqu);
				}
			}else if(int(tdata.id)<30000){
				//tstr += "<font color='"+GameInit.getHtmlColor(tdata.level)+"'>"+tdata.name+"</font>\n\n";
				switch(tdata.type){
					case 1:
						tstr += "类型： 攻击技能\n\n";
						if(int(tdata.huihe)>1)tstr += "持续回合："+tdata.huihe+"\n";
						tstr += "对目标造成"+int((PlayerInit.gongji*(tdata.baiji+tdata.baixi*tdata.nowlevel)/100+(tdata.guji+tdata.guxi*tdata.nowlevel)+tdata.xiuzheng))+"伤害\n";
						break;
					case 2:
						tstr += "类型： 恢复技能\n\n";
						break;
					case 3:
						tstr += "类型： 状态技能\n\n";
						break;
					case 4:
						tstr += "类型： 法术技能\n\n";
						break;
					case 7:
						tstr += "类型： 生产技能\n\n";
						break;
					case 8:
						tstr += "类型： 被动技能\n\n";
						break;
					case 9:
						tstr += "类型： 使用技能\n\n";
						break;
				}
				
				if (ts!==1){
					var dropSki:MyButton = new MyButton("卸下",0xccccff);
					dropSki.x = (this.width - dropSki.width)>>1;
					dropSki.y = int(this.height*.85);
					dropSki.name = tdata.id+"";
					dropSki.addEventListener(MouseEvent.CLICK,remSkiHandler);
					this.addChild(dropSki);
				}
			}else if(int(tdata.id)<50000){
				switch(tdata.type){
					case 1:
						tstr += "类型： 辅助书籍\n\n";
						tstr += tdata.shuoming;
						break;
					case 2:
						tstr += "类型：功法\n\n";
						tstr += tdata.shuoming;
						break;

				}
				
				if (ts!==1){
//					var dropSki:MyButton = new MyButton("卸下",0xccccff);
//					dropSki.x = (this.width - dropSki.width)>>1;
//					dropSki.y = int(this.height*.85);
//					dropSki.name = tdata.id+"";
//					dropSki.addEventListener(MouseEvent.CLICK,remSkiHandler);
//					this.addChild(dropSki);
				}
			}
			var tf:MyText = new MyText(tstr,20,0x000000,"left",360);
			tf.x = 50;
			tf.y = 50;
			this.addChild(tf);
			this.addEventListener(MouseEvent.CLICK,cloHandler);			
		}
		private function remEquHandler(e:MouseEvent):void{
			alone.playerdialog.removeEqu();
		}
		private function remSkiHandler(e:MouseEvent):void{
			alone.playerdialog.removeSki(0);
		}
		private function cloHandler(e:MouseEvent):void{
			alone.topSpr.removeChildAt(0);
		}
	}
}