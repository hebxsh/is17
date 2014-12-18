package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.CodeImageIcon;
	import UI.EquipBox;
	import UI.MyButton;
	import UI.MyText;
	import UI.TabBar;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	import data.PlayerInit;
	import data.RefreshData;

	/**
	 * 打造类
	 * */
	
	public class DazaoDialog extends DialogObject
	{
		public var m_tab:TabBar;		
		private var bgSpr:Sprite = new Sprite();
		private var clSpr:Sprite = new Sprite();
		private var clshowSpr:Sprite = new Sprite();
		//数字对应图标
		private var leiarr:Array = [0,1,5,6,7,8,9];
		//文字对应类型
		private var arrName:Array = [["剑","1&2","剑刃","剑柄"],["衣","1&2","衣表","衣里"],["刀","1&2","刀刃","刀柄"],["扇","1&2","扇骨","扇面"],["杖","1&2","杖身","杖头"],["弓","1&2","弓骨","弓弦"],["盾","1&2","盾被","盾衬"]];
		private var nameTxt:MyText;
		public function DazaoDialog()
		{
			theTitle("打 造");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			m_tab = new TabBar(["打 造","炼 宝"]);
			m_tab.x = (GameInit.m_stage.stageWidth-400)>>1;
			m_tab.y = 70;
			m_tab.addEventListener(MouseEvent.CLICK,tabHandler);
			this.addChild(m_tab);
			
			
			//灰色背景
			this.graphics.beginFill(0X998877);
			this.graphics.drawRect((GameInit.m_stage.stageWidth-400)>>1,120,400,600);
			
			bgSpr.x = 40;
			bgSpr.y = 120;
			this.addChild(bgSpr);
			
			clSpr.x = 40;
			clSpr.y = 120;
			this.addChild(clSpr);				
			
			clshowSpr.x = 40;
			clshowSpr.y = 120;
			this.addChild(clshowSpr);	
			
			var sTxt:MyText = new MyText("当前选择：");
			sTxt.x = 10;
			sTxt.y = 60;
			bgSpr.addChild(sTxt);
			
			nameTxt = new MyText("");
			nameTxt.x = 110;
			nameTxt.y = 60;
			bgSpr.addChild(nameTxt);

			createShow();
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
		}
		//创建修炼界面
		private function createShow():void{
			for (var i:int = 0;i<leiarr.length;i++){
				var ig:CodeImageIcon = new CodeImageIcon();
				ig.x = i*50+10;
				ig.y = 10;
				ig.createIcon(leiarr[i]);
				ig.name = i.toString();
				ig.addEventListener(MouseEvent.CLICK,igcHandler);
				bgSpr.addChild(ig);
			}
		}
		private function igcHandler(e:MouseEvent):void{
			var tnum:int = int(e.target.name);
			var showStr:String = arrName[tnum][0]; 
			nameTxt.setText(showStr);
			showCailiao(tnum);
		}
		//刷新添加材料界面
		private function showCailiao(tnum:int):void{
			while(clSpr.numChildren>0){
				clSpr.getChildAt(0).removeEventListener(MouseEvent.CLICK,addClHandler);
				clSpr.removeChildAt(0);
			}
			for (var i:int=2;i<arrName[tnum].length;i++){ 
				var sTxt:MyText = new MyText(arrName[tnum][i]+":");
				sTxt.x = 20;
				sTxt.y = i*60 - 10;
				clSpr.addChild(sTxt);
				
				var addClBtn:MyButton = new MyButton("<font color = '#ffffff' size='28'>+</font>",ColorInit.btnBgColor,200);
				addClBtn.x = 100;	
				addClBtn.y = i*60-20;
				addClBtn.name = arrName[tnum][1];
				addClBtn.mstr = (i-2).toString();
				clSpr.addChild(addClBtn);
				addClBtn.addEventListener(MouseEvent.CLICK,addClHandler);
			}
		}
		//点击+号按钮
		private var mtype:int = 0;
		private var mClArr:Array = new Array();
		private function addClHandler(e:MouseEvent):void{
			alone.bagdialog.setTitle(e.currentTarget.name,"material");	
			mtype = int(e.currentTarget.mstr);
		}
		//添加一个技能
		public function addCailiao(materialid:int):void{
			var tspr:Sprite = new Sprite();
			tspr.graphics.beginFill(0Xcc4477);
			tspr.graphics.drawRect(0,0,280,50);	
			
			var tdata:Object = DataPool.getSel("material",materialid);
			var tbx:EquipBox = new EquipBox(tdata,1);	
			tspr.addChild(tbx);	
			
			var jianBtn:MyButton = new MyButton("X",0xff0000);
			jianBtn.x = 230;			
			jianBtn.name = mtype+""+materialid;			
			jianBtn.addEventListener(MouseEvent.CLICK,removeSkiHandler);
			tspr.addChild(jianBtn);	
			tspr.x = 100;	
			tspr.y =  mtype*60+100;
			tspr.name = mtype+""+materialid;	
			clshowSpr.addChild(tspr);
			mClArr.push(tspr);
		}
		//添加的材料自杀
		private function removeSkiHandler(e:MouseEvent):void{
			var tname:String = e.currentTarget.name;
			for (var i:int = 0;i<mClArr.length;i++){
				if(mClArr[i].name == tname){
					mClArr.splice(i,1);
					clshowSpr.removeChildAt(i);
				}
			}
		}
		//刷新
		public function Refresh():void{
			refreshShow(m_tab.getIndex());
		}
		private function refreshShow(tab:int):void{
			
		}

		//点击选项卡
		private function tabHandler(e:MouseEvent):void{
				
		}		
		//关闭
		public function closeHandler(e:MouseEvent = null):void{
			this.theDest();		
		}
	}
}