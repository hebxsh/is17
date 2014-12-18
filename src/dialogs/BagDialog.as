package dialogs
{
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.Panel;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	
	public class BagDialog extends DialogObject	{
		private var equPanel:Panel;
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
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			if(!equPanel)equPanel = new Panel(400,600);
			equPanel.x = 40;
			equPanel.y = 90;
			this.addChild(equPanel);
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
			Refresh();
		}
		/**
		 * 打开背包面板
		 * 装备位置或者类型，显示类型。
		 * */
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
				case "book":
					theTitle("书 籍");
					break;	
			}
			theOpen();
		}

		//刷新装备
		public function Refresh():void{	
			if(!equPanel)return;
			equPanel.removeContents();
			
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
			if(DataPool.getArr("bag")){
				for (var i:int = 0;i<DataPool.getArr("bag").length;i++){
					var temid:int = DataPool.getArr("bag")[i].id;
					if(temid<20000){
						tmStr = "equip";
					}else if(temid>30000&&temid<40000){
						tmStr = "material";
					}else if(temid>40000&&temid<50000){
						tmStr = "book";
					}
					if (DataPool.getSel(tmStr,temid)){
						if (m_es == "bag"){						
							var bagitem:BagItem = new BagItem(tmStr,temid,i);
							equPanel.addContent(bagitem,10);
							
						}else if(m_es == "equip"&&tmStr=="equip"){
							var temEquObj:Object = DataPool.getSel("equip",temid);
							if(temEquObj.type == typeid){
								var equitem:BagItem = new BagItem("equip",temid,i);
								equPanel.addContent(equitem,10);
							}
						}else if(m_es == "book"&&tmStr=="book"){
							var temBookObj:Object = DataPool.getSel("book",temid);
							if(temBookObj.type == m_type){//判断显示的书籍类型
								var bookitem:BagItem = new BagItem("book",temid,i);
								equPanel.addContent(bookitem,10);
							}
						}else if(m_es == "material"&&tmStr=="material"){
							var temMaterialObj:Object = DataPool.getSel("material",temid);
							var typeArr:Array = m_type.split("&");
							for(var m:int = 0;m<typeArr.length;m++){
								if(temMaterialObj.type == typeArr[m]){//判断显示的书籍类型
									var Materialitem:BagItem = new BagItem("material",temid,i);
									equPanel.addContent(Materialitem,10);
								}
							}
						}
					}
				}
			}
		}
		
		public function closeHandler(e:MouseEvent = null):void{
			equPanel.removeContents();
			//while(equPanel.numChildren>0)equPanel.removeChildAt(0);
			//equPanel.graphics.clear();
			this.theDest();
		}
	}
}