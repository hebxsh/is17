package dialogs
{
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.Panel;
	
	import data.DataPool;
	import data.GameInit;
	
	public class BagDialog extends DialogObject	{
		private var equSpr:Panel;
		private var m_type:String;
		private var m_es:String;
		public function BagDialog()
		{
			
		}
		override public function theOpen():void{
			this.visible = true;
			init();
		}
		private function init():void{			
			this.graphics.beginFill(0Xcccc77);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			equSpr = new Panel(400,600);
			equSpr.x = 40;
			equSpr.y = 90;
			this.addChild(equSpr);
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
			Refresh();
		}
		public function setTitle(type:String = "bag",es:String = "bag"):void{
			theTitle("背 包");
			m_type = type;
			m_es = es;
			switch(type){
				case "wuqi":
					theTitle("武 器");
					break;
				case "fangju":
					theTitle("防 具");
					break;
				case "fabao1":
					theTitle("法 宝");
					break;
				case "fabao2":
					theTitle("法 宝");
					break;				
			}
			theOpen();
		}

		//刷新装备
		public function Refresh():void{	
			equSpr.removeContents();
			
			var typeid:int = 0;
			switch(m_type){
				case "wuqi":
				typeid = 1;
				break;
				case "fangju":
				typeid = 2;
				break;
				case "fabao1":
				typeid = 3;
				break;
				case "fabao2":
				typeid = 3;
				break;
			}
			
			var tmStr:String = "";
			var xx:Object = DataPool.getArr("bag");
			for (var i:int = 0;i<DataPool.getArr("bag").length;i++){
				var temid:int = DataPool.getArr("bag")[i].id;
				if(temid<20000)tmStr = "equip";
				else if(temid>40000&&temid<50000)tmStr = "book";
				if (DataPool.getSel(tmStr,temid)){
					if (m_es == "bag"){						
						var bagitem:BagItem = new BagItem(tmStr,temid,i);
						equSpr.addContent(bagitem,10);
						
					}else if(m_es == "equip"&&tmStr=="equip"){
						var temEquObj:Object = DataPool.getSel("equip",temid);
						if(temEquObj.type == typeid){
							var equitem:BagItem = new BagItem("equip",temid,i);
							equSpr.addContent(equitem,10);
						}
					}
				}
			}
		}
		
		public function closeHandler(e:MouseEvent = null):void{
			equSpr.removeContents();
			//while(equSpr.numChildren>0)equSpr.removeChildAt(0);
			equSpr.graphics.clear();
			this.theDest();
		}
	}
}