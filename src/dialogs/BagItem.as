package dialogs
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.EquipBox;
	import UI.MyButton;
	
	import data.DataPool;
	import data.RefreshData;

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
			var showTxt:String = "装备";
			if (int(temObj.id)>30000&&int(temObj.id)<40000){
				showTxt = "打造";
			}else if (int(temObj.id)>40000&&int(temObj.id)<50000){
				if(temObj.type == "4"){
					showTxt = "阅读";
				}else{
					showTxt = "修炼";
				}
			}
			var zb:MyButton = new MyButton(showTxt,0xccccff);
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
				alone.playerdialog.addEqu(int(e.currentTarget.obj.id),int(e.currentTarget.obj.type)-1,int(e.currentTarget.mobj.mainid));
				DataPool.getArr("bag").splice(int(e.currentTarget.name),1);
				delet(int(e.currentTarget.mobj.mainid));
				alone.bagdialog.closeHandler();
			}else if(int(e.currentTarget.obj.id)<30000){
				RefreshData.inser("userskill",e.currentTarget.obj.id);
				alone.bagdialog.closeHandler();
			}else if(int(e.currentTarget.obj.id)<40000){
				alone.dazaodialog.addCailiao(int(e.currentTarget.obj.id));
				alone.bagdialog.closeHandler();
			}else if(int(e.currentTarget.obj.id)<50000){
				if(e.currentTarget.obj.type=="4"){
					RefreshData.inser("userskill",e.currentTarget.obj.id);	
					alone.xiuliandialog.m_tab.setIndex(2);
					alone.xiuliandialog.visible = true;
					alone.xiuliandialog.Refresh();
					alone.xiuliandialog.addSki(int(e.currentTarget.obj.id));
					alone.bagdialog.closeHandler();
				}else if(e.currentTarget.obj.type=="5"){
					RefreshData.inser("userskill",e.currentTarget.obj.id);	
					alone.xiuliandialog.m_tab.setIndex(0);
					alone.xiuliandialog.visible = true;
					alone.xiuliandialog.Refresh();
					alone.xiuliandialog.addSki(int(e.currentTarget.obj.id));
					alone.bagdialog.closeHandler();
				}
			}			
		}
		private function delet(typeid:int):void{
			RefreshData.delet("bag",typeid.toString());
		}
	}
}