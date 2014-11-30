package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import UI.BloodBar;
	import UI.MyButton;
	import UI.MyText;
	import UI.TabBar;
	import UI.ToolTip;
	
	import data.ChangeData;
	import data.ColorInit;
	import data.DataInit;
	import data.DataPool;
	import data.GameInit;
	import data.RefreshData;
	
	import event.CommEvent;

	public class XiulianDialog extends DialogObject
	{
		private var m_tab:TabBar;
		private var timer:Timer = new Timer(1000);
		private var bgSpr:Sprite = new Sprite();	
//		private var skillSpr:Sprite = new Sprite();
//		private var readSpr:Sprite = new Sprite();	
//		private var itemArr:Array = [bgSpr,skillSpr,readSpr];
		private var xltxt:MyText;
		private var xlBar:BloodBar ;
		private var ghBtn:MyButton ;
		private var gfSkill:Object;
		private var xlIndex:int = 0;
		private var tabId:int = 0;
		public function XiulianDialog()
		{
			theTitle("修 炼");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			m_tab = new TabBar(["功 法","技 能","阅 读"]);
			m_tab.x = (GameInit.m_stage.stageWidth-400)>>1;
			m_tab.y = 70;
			m_tab.addEventListener(MouseEvent.CLICK,tabHandler);
			this.addChild(m_tab);
			
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			//灰色背景
			this.graphics.beginFill(0X998877);
			this.graphics.drawRect((GameInit.m_stage.stageWidth-400)>>1,120,400,600);
			
			
			bgSpr.x = 40;
			bgSpr.y = 120;
			this.addChild(bgSpr);
//			//加载三个界面
//			for (var i:int = 0;i<itemArr.length;i++){
//				itemArr[i].x = (GameInit.m_stage.stageWidth-400)>>1;
//				itemArr[i].y =  120;
//				itemArr[i].visible = (i==0?true:false);
//				this.addChild(itemArr[i]);
//			}
			
			createShow(0);
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
		}
		//创建修炼界面
		private function createShow(tab:int):void{
			xltxt = new MyText(showTxt(tab));
			xltxt.x = 20;
			xltxt.y = 20;			
			bgSpr.addChild(xltxt);
			
			gfSkill = DataInit.getCopy(getBookSkill(tab+2));
			
			xlBar = new BloodBar(DataInit.levelExp(gfSkill.nowlevel),280,10,true,0x33aa22);
			xlBar.x = 20;
			xlBar.y = 90;
			xlBar.ReNum(gfSkill.exp);
			bgSpr.addChild(xlBar);
			
			xltxt.setText(showTxt(tab)+"<font color='"+GameInit.getHtmlColor(gfSkill.level)+"'>"+gfSkill.name+"</font>");
			
			ghBtn = new MyButton("更换");
			ghBtn.x = 340;
			ghBtn.y = 10;
			ghBtn.addEventListener(MouseEvent.CLICK,ghHandler);
			bgSpr.addChild(ghBtn);
			
			ghBtn = new MyButton(showTxt(tab,true));
			ghBtn.x = 340;
			ghBtn.y = 70;
			ghBtn.addEventListener(MouseEvent.CLICK,xlHandler);
			bgSpr.addChild(ghBtn);			
		}
		//刷新
		private function refreshShow(tab:int):void{
			gfSkill = DataInit.getCopy(getBookSkill(tab+2));
			if(!gfSkill){
				xltxt.setText("无");			
				xlBar.ReMax(0);
				xlBar.ReNum(0);
				return;
			}
			xltxt.setText(showTxt(tab)+"<font color='"+GameInit.getHtmlColor(gfSkill.level)+"'>"+gfSkill.name+"</font>");			
			xlBar.ReMax(DataInit.levelExp(gfSkill.nowlevel));
			xlBar.ReNum(gfSkill.exp);
		}
		//文字显示
		private function showTxt(tabxl:int,tabbtn:Boolean = false):String{
			var str:String;
			switch (tabxl){
				case 0 :
					str = "修炼";
					break;
				case 1 :
					str = "修炼";
					break;
				case 2 :
					str = "阅读";
					break;
				case 3 :
					break;
			}
			if (!tabbtn){
				str = "当前"+str+"：";
			}
			return str;
		}
		
		//更换相关技能
		private function ghHandler(e:MouseEvent):void{
			alone.skilldialog.setTitle("xl");
		}
		/**
		 * 更换修炼技能
		 * */
		public function addSki(id:int):void{
			this.timer.stop();
			DataPool.getArr("userskill")[xlIndex].xiulian = 0;
			DataPool.getSel("userskill",id).xiulian = m_tab.getIndex()+2;
			if(gfSkill)
			RefreshData.updateData("userskill","xiulian","0","id",gfSkill.id.toString());
			RefreshData.updateData("userskill","xiulian",(m_tab.getIndex()+2)+"","id",id.toString());
			refreshShow(m_tab.getIndex());
		}
		//点击修炼按钮
		private function xlHandler(e:MouseEvent):void{
			this.timer.start();
		}		
		//获取相关技能
		private function getBookSkill(tabid:int):Object{
			var bookskill:Object;
			for (var i:int = 0;i<DataPool.getArr("userskill").length;i++){
				var tid:int = DataPool.getArr("userskill")[i].id;
				var txiu:int = DataPool.getArr("userskill")[i].xiulian;
				if (txiu==tabid){
					if(tid<40000){
						if (DataPool.getSel("skill",tid)){
							bookskill = DataPool.getSel("skill",tid);
							bookskill.nowlevel = DataPool.getArr("userskill")[i].nowlevel;
							bookskill.exp = DataPool.getArr("userskill")[i].exp;
						}
					}else if(tid>40000){
						if (DataPool.getSel("book",tid)){
							bookskill = DataPool.getSel("book",tid);
							bookskill.nowlevel = DataPool.getArr("userskill")[i].nowlevel;
							bookskill.exp = DataPool.getArr("userskill")[i].exp;
						}
					}
					xlIndex = i;
				}
			}
			return bookskill;
		}
		//增加修炼经验
		private function timerHandler(e:TimerEvent):void{
			++gfSkill.exp;
			if (gfSkill.exp<DataInit.levelExp(gfSkill.nowlevel)){
				xlBar.ReNum(gfSkill.exp);
			}else{//升级
				if (gfSkill.nowlevel+1==gfSkill.maxlevel){
					timer.stop();
				}else{
					RefreshData.updateData("userskill","exp","0","id",gfSkill.id.toString());
					RefreshData.updateData("userskill","nowlevel",gfSkill.nowlevel+1+"","id",gfSkill.id.toString());
					refreshShow(m_tab.getIndex());
				}
			}			
		}
		//点击选项卡
		private function tabHandler(e:MouseEvent):void{
			this.timer.stop();
			refreshShow(m_tab.getIndex());
			
			if(!gfSkill)return;
			RefreshData.updateData("userskill","exp",gfSkill.exp.toString(),"id",gfSkill.id.toString());
			RefreshData.updateData("userskill","nowlevel",gfSkill.nowlevel.toString(),"id",gfSkill.id.toString());			
		}		
		//关闭
		public function closeHandler(e:MouseEvent = null):void{
			this.timer.stop();
			this.theDest();
			if(!gfSkill)return;
			RefreshData.updateData("userskill","exp",gfSkill.exp.toString(),"id",gfSkill.id.toString());
			RefreshData.updateData("userskill","nowlevel",gfSkill.nowlevel.toString(),"id",gfSkill.id.toString());
			
		}
	}
}