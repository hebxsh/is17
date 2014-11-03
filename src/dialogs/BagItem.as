package dialogs
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.EquipBox;
	import UI.MyButton;
	
	import data.DataPool;
	import data.SqlDb;

	public class BagItem extends Sprite
	{
		public function BagItem(type:String,temid:int,num:int,dqshow:Boolean = true)
		{
			var tspr:Sprite = new Sprite;
			
			var sgspe:Shape = new Shape;
			tspr.addChild(sgspe);	
			
			var temObj:Object = DataPool.getSel(type,temid);
			
			var tbx:EquipBox = new EquipBox(temObj,1);
			tbx.x = 0;
			tbx.y = 10;
			tspr.addChild(tbx);					
			
			sgspe.graphics.beginFill(0Xcc4477);
			sgspe.graphics.drawRect(tbx.x-10,tbx.y-10,tbx.width*2+40,tbx.height+20);
			
			if (dqshow){
				var dq:MyButton = new MyButton("丢弃",0xccccff);
				dq.x = tbx.width+dq.height+20;
				dq.y = (tbx.height-dq.height)/2+10;
				tspr.addChild(dq);
				dq.name = num.toString();
				dq.obj = temObj;
				dq.mobj = DataPool.getArr("bag")[num];
				dq.addEventListener(MouseEvent.CLICK,dqHandler);
			}
			var zb:MyButton = new MyButton("装备",0xccccff);
			zb.x = tbx.width*2-30;
			zb.y = (tbx.height-dq.height)/2+10;
			tspr.addChild(zb);
			zb.name = num.toString();
			zb.obj = temObj;
			zb.mobj = DataPool.getArr("bag")[num];
			zb.addEventListener(MouseEvent.CLICK,zbHandler);
			
			tspr.x = tbx.height/2;
			this.addChild(tspr);
			//equSpr.addContent(tspr,10);
		}
		private function dqHandler(e:MouseEvent):void{
			DataPool.getArr("bag").splice(int(e.currentTarget.name),1);
			delet(int(e.currentTarget.mobj.mainid));
			//equSpr.removeContents();
			alone.bagdialog.Refresh();
		}
		private function zbHandler(e:MouseEvent):void{
			if (int(e.currentTarget.obj.id)<20000){
				alone.playerdialog.addEqu(int(e.currentTarget.obj.id),int(e.currentTarget.obj.type)-1);
			}else{
				alone.playerdialog.addSki(int(e.currentTarget.obj.id),int(e.currentTarget.obj.type)-1);
			}
			DataPool.getArr("bag").splice(int(e.currentTarget.name),1);
			delet(int(e.currentTarget.mobj.mainid));
			alone.bagdialog.closeHandler();
		}
		private function delet(typeid:int):void{
			SqlDb.delet("bag",{mainid:typeid});	
		}
	}
}