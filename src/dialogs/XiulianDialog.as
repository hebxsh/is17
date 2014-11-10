package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.MyText;
	import UI.TabBar;
	
	import data.GameInit;

	public class XiulianDialog extends DialogObject
	{
		private var m_tab:TabBar;
		private var gongfaSpr:Sprite = new Sprite();	
		private var skillSpr:Sprite = new Sprite();
		private var readSpr:Sprite = new Sprite();	
		private var itemArr:Array = [gongfaSpr,skillSpr,readSpr];
		public function XiulianDialog()
		{
			theTitle("修 炼");
			this.graphics.beginFill(0Xcccc77);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			m_tab = new TabBar(["功 法","技 能","阅 读"]);
			m_tab.x = (GameInit.m_stage.stageWidth-400)>>1;
			m_tab.y = 70;
			m_tab.addEventListener(MouseEvent.CLICK,tabHandler);
			this.addChild(m_tab);
			
			//灰色背景
			this.graphics.beginFill(0X998877);
			this.graphics.drawRect((GameInit.m_stage.stageWidth-400)>>1,120,400,600);
			
			//加载三个界面
			for (var i:int = 0;i<itemArr.length;i++){
				itemArr[i].x = (GameInit.m_stage.stageWidth-400)>>1;
				itemArr[i].y =  120;
				itemArr[i].visible = (i==0?true:false);
				this.addChild(itemArr[i]);
			}
			
			createGongfa();
			createSkill();
			createRead();
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
		}
		private function createGongfa():void{
			var xltxt:MyText = new MyText("当前修炼：");
			xltxt.x = 20;
			xltxt.y = 20;
			gongfaSpr.addChild(xltxt);
			
			var ghBtn:MyButton = new MyButton("更换");
			ghBtn.x = 320;
			ghBtn.y = 10;
			ghBtn.addEventListener(MouseEvent.CLICK,ghgfHandler);
			gongfaSpr.addChild(ghBtn);
		}
		private function createSkill():void{
			var xltxt:MyText = new MyText("当前修炼：");
			xltxt.x = 20;
			xltxt.y = 20;
			skillSpr.addChild(xltxt);
			
			var ghBtn:MyButton = new MyButton("更换");
			ghBtn.x = 320;
			ghBtn.y = 10;
			ghBtn.addEventListener(MouseEvent.CLICK,ghskHandler);
			skillSpr.addChild(ghBtn);
		}
		private function createRead():void{
			var xltxt:MyText = new MyText("当前阅读：");
			xltxt.x = 20;
			xltxt.y = 20;
			readSpr.addChild(xltxt);
			
			var ghBtn:MyButton = new MyButton("更换");
			ghBtn.x = 320;
			ghBtn.y = 10;
			ghBtn.addEventListener(MouseEvent.CLICK,ghrdHandler);
			readSpr.addChild(ghBtn);
		}
		private function ghgfHandler(e:MouseEvent):void{
			trace ("更换功法");
		}
		private function ghskHandler(e:MouseEvent):void{
			trace ("更换技能");
		}
		private function ghrdHandler(e:MouseEvent):void{
			trace ("更换书籍");
		}
		//点击选项卡
		private function tabHandler(e:MouseEvent):void{
			for (var i:int = 0;i<itemArr.length;i++){
				if(i==m_tab.getIndex()){
					itemArr[i].visible = true;
				}else{
					itemArr[i].visible = false;
				}
			}
		}
		//刷新属性
		public function Refresh():void{
			
		}
		//关闭
		public function closeHandler(e:MouseEvent = null):void{
			this.theDest();
		}
	}
}