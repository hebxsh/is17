package dialogs
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.EquipBox;
	import UI.MyButton;
	
	import data.DataPool;
	import data.RefreshData;
	
	public class SkiItem extends Sprite
	{
		public function SkiItem(type:String,temid:int,tlevel:int,num:int,btnstr:String = "添加",dqshow:Boolean = true)
		{
			var tspr:Sprite = new Sprite;
			
			var sgspe:Shape = new Shape;
			tspr.addChild(sgspe);	
			
			var temObj:Object = DataPool.getSel(type,temid);
			temObj.nowlevel = tlevel;
			
			var tbx:EquipBox = new EquipBox(temObj,1);
			tbx.x = 0;
			tbx.y = 10;
			tspr.addChild(tbx);					
			
			sgspe.graphics.beginFill(0Xcc4477);
			sgspe.graphics.drawRect(tbx.x-10,tbx.y-10,tbx.width*2+40,tbx.height+20);
			
			if (dqshow){
				var dq:MyButton = new MyButton("化功",0xccccff);
				dq.x = tbx.width+dq.height+20;
				dq.y = (tbx.height-dq.height)/2+10;
				tspr.addChild(dq);
				dq.name = num.toString();
				dq.obj = temObj;
				dq.mobj = DataPool.getArr("userskill")[num];
				dq.addEventListener(MouseEvent.CLICK,dqHandler);
			}
			var zb:MyButton = new MyButton(btnstr,0xccccff);
			zb.x = tbx.width*2-30;
			zb.y = (tbx.height-dq.height)/2+10;
			tspr.addChild(zb);
			zb.name = num.toString();
			zb.obj = temObj;
			zb.mobj = DataPool.getArr("userskill")[num];
			zb.addEventListener(MouseEvent.CLICK,zbHandler);
			
			tspr.x = tbx.height/2;
			this.addChild(tspr);
			//equSpr.addContent(tspr,10);
		}
		private function dqHandler(e:MouseEvent):void{
			DataPool.getArr("userskill").splice(int(e.currentTarget.name),1);
			delet(int(e.currentTarget.mobj.mainid));
			//equSpr.removeContents();
			alone.skilldialog.Refresh();
		}
		private function zbHandler(e:MouseEvent):void{
			if (SkillDialog.useType == "zb"){
				alone.playerdialog.addSki(int(e.currentTarget.obj.id),int(e.currentTarget.obj.type)-1);	
			}else if(SkillDialog.useType == "xl"){
				alone.xiuliandialog.addSki(int(e.currentTarget.obj.id));	
			}
			/**添加移除技能不改变列表，只更新状态。*/			
			//delet(int(e.currentTarget.mobj.mainid));
			alone.skilldialog.closeHandler();
		}
		private function delet(typeid:int):void{
			//SqlDb.delet("userskill",{mainid:typeid});
			RefreshData.delet("userskill",typeid.toString());
		}
	}
}