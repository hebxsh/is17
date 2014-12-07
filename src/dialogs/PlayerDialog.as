package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.EquipBox;
	import UI.MyButton;
	import UI.MyText;
	import UI.Panel;
	import UI.TabBar;
	
	import data.ChangeData;
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	import data.PlayerInit;
	import data.RefreshData;

	/**
	 * 
	 * 人物面板
	 * 
	 * */
	public class PlayerDialog extends DialogObject
	{
		private var m_tab:TabBar;	
		private var m_sxArr:Array = new Array();
		private var txtSpr:Sprite = new Sprite();
		private var wuqi:Sprite = new Sprite();
		private var fangju:Sprite = new Sprite();
		private var fabao1:Sprite = new Sprite();
		private var fabao2:Sprite = new Sprite();

		private var equipSpr:Sprite = new Sprite();
		
		/**技能相关*/
		private var skillSpr:Sprite = new Sprite();
		private var skillArr:Array = new Array();	
		private var skillListArr:Array =new Array();
		private var skillPanel:Panel;	
//		private var aotuArr:Array = ["aut1","aut2","aut3","aut4"];
//		private var zhuArr:Array = ["zhu1","zhu2","zhu3","zhu4"];
//		private var xiuArr:Array = ["xiu1","xiu2","xiu3","xiu4"];		
//		private var skillStrArr:Array = [aotuArr,zhuArr,xiuArr];		
//		private var autoSpr:Sprite = new Sprite();
//		private var zhuSpr:Sprite = new Sprite();
//		private var xiuSpr:Sprite = new Sprite();
//		private var autoSkiArr:Array = new Array();
//		private var zhuSkiArr:Array = new Array();
//		private var xiuSkiArr:Array = new Array();	
		
		private var itemArr:Array = [txtSpr,equipSpr,skillSpr];		
		
		public function PlayerDialog()
		{
			init();
			this.visible = false;
		}
		//初始化
		private function init():void{	
			theTitle("人 物");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			m_tab = new TabBar(["属 性","装 备","技 能"]);
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
			
			createTxt();
			createEquip();	
			addEquip();
			createSkill();
			
			var closeBtn:MyButton = new MyButton("X",0xff0000);
			closeBtn.x = 420;
			closeBtn.y = 10;
			closeBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(closeBtn);
			
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
		//生成属性说明
		private function createTxt():void{
			var panelArr1:Array = new Array;
			var panelArr2:Array = new Array;
			var panelArr3:Array = new Array;
			
			for (var i:int = 0;i<PlayerInit.p_xsArr.length;i++){
				for(var property:String in DataPool.getArr("user")[0]){				
					if (property == PlayerInit.p_xsArr[i][0]){
						if(PlayerInit.p_xsArr[i][2]=="1"){
							panelArr1.push(PlayerInit.p_xsArr[i]);
						}else if(PlayerInit.p_xsArr[i][2]=="2"){
							panelArr2.push(PlayerInit.p_xsArr[i]);
						}else if(PlayerInit.p_xsArr[i][2]=="3"){
							panelArr3.push(PlayerInit.p_xsArr[i]);
						}
					}
				}
			} 
			createText(txtSpr,20,25,"基本",0x00EC00);
			createText(txtSpr,20,145,"战斗",0x00EC00);
			createText(txtSpr,20,345,"灵力",0x00EC00);
			for (i=0;i<panelArr1.length;i++){
				createText(txtSpr,20+int(i/2)*200,60+i%2*40,panelArr1[i][1]);
				createDynamicText(90+int(i/2)*200,60+i%2*40,DataPool.getArr("user")[0][panelArr1[i][0]],panelArr1[i][0]);
			}
			
			for (i=0;i<panelArr2.length;i++){
				createText(txtSpr,20+i%2*200,180+int(i/2)*40,panelArr2[i][1]);
				createDynamicText(90+i%2*200,180+int(i/2)*40,DataPool.getArr("user")[0][panelArr2[i][0]],panelArr2[i][0]);
			}
			
			for (i=0;i<panelArr3.length;i++){
				createText(txtSpr,20+int(i/5)*200,380+i%5*40,panelArr3[i][1]);
				createDynamicText(90+int(i/5)*200,380+i%5*40,DataPool.getArr("user")[0][panelArr3[i][0]],panelArr3[i][0]);
			}
			
		}
		private function getName():void{
			
		}		
		//添加装备背景
		private function createEquip():void{
			createEqu(wuqi,20,20,"wuqi");
			createEqu(fangju,210,20,"fangju");
			createEqu(fabao1,20,110,"fabao1");
			createEqu(fabao2,210,110,"fabao2");	
		}
		private function addEquip():void{
			if(DataPool.getArr("user")[0].wuqi>0){
				typeid = gettypeid("wuqi");
				addEqu(DataPool.getArr("user")[0].wuqi);
			}
			if(DataPool.getArr("user")[0].fangju>0){
				typeid = gettypeid("fangju");
				addEqu(DataPool.getArr("user")[0].fangju);
			}
			if(DataPool.getArr("user")[0].fabao1>0){
				typeid = gettypeid("fabao1");
				addEqu(DataPool.getArr("user")[0].fabao1);
			}
			if(DataPool.getArr("user")[0].fabao2>0){
				typeid = gettypeid("fabao2");
				addEqu(DataPool.getArr("user")[0].fabao2);
			}
		}
		//添加技能容器
		private var addSkillBtn:MyButton;
		private function createSkill():void{
			if (!skillPanel){
				skillPanel= new Panel(400,560);
				skillPanel.y = 20;
				skillSpr.addChild(skillPanel);
				
				addSkillBtn = new MyButton("<font color = '#ffffff' size='28'>+</font>",ColorInit.btnBgColor,200);
				addSkillBtn.x = 20;
				addSkillBtn.addEventListener(MouseEvent.CLICK,addSkiHandler);
			}	
			skillPanel.removeContents();
			skillListArr = [];
			var skillStr:String = DataPool.getArr("user")[0].skill;
			skillListArr = skillStr.split(",");
			for (var i:int = 0;i<skillListArr.length;i++){
				createAddBg(skillListArr[i],i);
			}

			skillPanel.addContent(addSkillBtn,20);			
		}
		override public function theOpen():void{
			this.visible = true;
			//init();
		}
		//添加文本
		private function createText(tspr:Sprite,x:int,y:int,str:String = "",col:int = 0):void{
			var tf:MyText = new MyText(str,20,col);
			tf.x = x;
			tf.y = y;
			tspr.addChild(tf);
		}
		//添加动态文本
		private function createDynamicText(x:int,y:int,str:String = "",name:String = ""):void{
			var tf:MyText = new MyText(str,20);
			tf.x = x;
			tf.y = y;
			txtSpr.addChild(tf);
			m_sxArr.push([name,tf]);
		}
		//添加装备背景
		private var temEquSpr:Array = new Array();
		private var typeid:int = 0;
		//添加装备栏
		private function createEqu(tsp:Sprite,x:int,y:int,name:String):void{
			var tspr:Sprite = new Sprite();
			tspr.x = x;
			tspr.y = y;
			tspr.name = name;
			tspr.graphics.beginFill(0Xcc4477);
			tspr.graphics.drawRect(0,0,GameInit.m_equidwidth+4,GameInit.m_equidheight+4);	

			var tf:MyText = new MyText("+",36,0x00cc00,"center");
			tf.x = (GameInit.m_equidwidth-100)/2;
			tspr.addChild(tf);
			tspr.addEventListener(MouseEvent.CLICK,addEquHandler);
			equipSpr.addChild(tspr);
			
			tsp.x = x;
			tsp.y = y;
			tsp.name = name;
			tsp.addEventListener(MouseEvent.CLICK,setEquHandler);
			equipSpr.addChild(tsp);
			temEquSpr.push(tsp);
		}	
		//点击+号按钮
		private function addEquHandler(e:MouseEvent):void{
			alone.bagdialog.setTitle(e.currentTarget.name,"equip");	
			typeid = gettypeid(e.currentTarget.name);
		}
		//点击装备
		private function setEquHandler(e:MouseEvent):void{
			typeid = gettypeid(e.currentTarget.name);
		}
		private function gettypeid(str:String):int{
			var tid:int = 0;
			switch(str){
				case "wuqi":
					tid = 0;
					break;
				case "fangju":
					tid = 1;
					break;
				case "fabao1":
					tid = 2;
					break;
				case "fabao2":
					tid = 3;
					break;
			}
			return tid;
		}
		private function gettypename(str:int):String{
			var tid:String = "";
			switch(str){
				case 0:
					tid = "wuqi";
					break;
				case 1:
					tid = "fangju";
					break;
				case 2:
					tid = "fabao1";
					break;
				case 3:
					tid = "fabao2";
					break;
			}
			return tid;
		}
		//添加更换装备
		public function addEqu(id:int,tpid:int = -1,mainid:int = 0):void{
			if (tpid==-1){
				tpid = typeid;								
			}else{
				if (tpid==2&&temEquSpr[tpid].numChildren>0)tpid=3;
				if (tpid==2&&temEquSpr[tpid].numChildren>0&&temEquSpr[tpid+1].numChildren>0)tpid=2+int(Math.random()*2);
				removeEqu(tpid);
				RefreshData.puton("equip",gettypename(tpid),id.toString(),gettypename(tpid),mainid.toString());
			}			
			var tbx:EquipBox = new EquipBox(DataPool.getSel("equip",id));
			temEquSpr[tpid].addChild(tbx);
			Refresh();			
		}
		//移除装备
		public function removeEqu(tpid:int = -1):void{
			if (tpid==-1){
				tpid = typeid;
			}
			while(temEquSpr[tpid].numChildren>0){
				var tmid:int = temEquSpr[tpid].getChildAt(0).edata.id;
				temEquSpr[tpid].removeChildAt(0);
				var xx:Object = {id:tmid,num:1};
				//SqlDb.insert("bag",{id:tmid,num:1});	
				//DataPool.getArr("bag").push(xx);	
				RefreshData.unload("equip",gettypename(tpid),"0",gettypename(tpid),tmid.toString());
			}
			Refresh();
		}
		/**技能相关///////////////////////////////////////////////////////////////////////////*/
		
		private var skillNum:int = 0;
		//添加一个技能
		private function createAddBg(skillid,skillnum:int):void{
			if(skillid=="")return;
			var tspr:Sprite = new Sprite();
			tspr.graphics.beginFill(0Xcc4477);
			tspr.graphics.drawRect(0,0,360,50);	
			
			var tdata:Object = DataPool.getSel("skill",skillid);
			tdata.nowlevel = DataPool.getSel("userskill",skillid).nowlevel;
			var tbx:EquipBox = new EquipBox(tdata,1);	
			tspr.addChild(tbx);	
			//添加技能到技能里列表
			PlayerInit.p_skillArr.push(tdata);
			
			var jianBtn:MyButton = new MyButton("X",0xff0000);
			jianBtn.x = 310;			
			jianBtn.name = skillnum.toString();			
			jianBtn.addEventListener(MouseEvent.CLICK,removeSkiHandler);
			tspr.addChild(jianBtn);	
			tspr.x = 20;
			skillPanel.addContent(tspr,10);
		}
		//点击+号按钮
		private function addSkiHandler(e:MouseEvent):void{
			//trace (e.currentTarget.name);
			alone.skilldialog.setTitle("zb");			
		}
		//点击X号按钮
		private function removeSkiHandler(e:MouseEvent):void{
			skillNum = int(e.currentTarget.name);
			var temStr:String = "";
			for (var i:int = 0;i<skillListArr.length;i++){
				if (i!=skillNum){
					temStr += skillListArr[i];
					if(i<skillListArr.length-1){
						temStr += ",";
					}
				}
			}
			RefreshData.unload("skill","skill",temStr,"skill",temStr);
		}

		//添加更换技能
		public function addSki(id:int):void{			
			RefreshData.puton("skill","skill",DataPool.getArr("user")[0]["skill"]+","+id,"skill",DataPool.getArr("user")[0]["skill"]+","+id);
		}
		
		//关闭面板
		private function closeHandler(e:MouseEvent):void{
			this.theDest();
		}
		
		//刷新属性
		public function Refresh():void{
			//刷新显示技能
			createSkill();
			//初始化基础属性
			PlayerInit.init();
			//添加修炼技能属性
			var temSkillArr:Array = DataPool.getArr("userskill");
			if(temSkillArr){
				for(var m:int = 0;m<temSkillArr.length;m++){
					var temSkillObj:Object = DataPool.getSel("skill",int(temSkillArr[m].id));
					if(temSkillObj&&temSkillObj["type"]!="8")continue;
					for(var temSkillItem:String in temSkillObj){
						PlayerInit.setSx(temSkillItem,int(temSkillObj[temSkillItem])*int(temSkillArr[m].nowlevel));
					}
				}
			}
			//添加书籍阅读属性
			var temBookArr:Array = DataPool.getArr("userskill");
			if(temBookArr){
				for(var n:int = 0;n<temBookArr.length;n++){
					var temBookObj:Object = DataPool.getSel("book",int(temBookArr[n].id));
					if(temBookObj&&temBookObj["type"]!="4")continue;
					for(var temBookItem:String in temBookObj){
						PlayerInit.setSx(temBookItem,int(temBookObj[temBookItem])*int(temBookArr[n].nowlevel));
					}
				}
			}
			//根据身上装备添加属性
			for(var i:int = 0;i<temEquSpr.length;i++){
				if(temEquSpr[i].numChildren>0){
					for(var property:String in temEquSpr[i].getChildAt(0).edata){
						PlayerInit.setSx(property,int(temEquSpr[i].getChildAt(0).edata[property]));
					}
				}else{
					//save(gettypename(i),"0");
				}
			}
			//设定最大生命值
			PlayerInit.maxhp = PlayerInit.hp;
			//刷新显示属性
			for (i = 0;i<m_sxArr.length;i++){
				m_sxArr[i][1].setText(PlayerInit.getSx(m_sxArr[i][0]));
			}

			//将自动释放的技能写入释放技能列表
			while(PlayerInit.p_skillArr.length>0){
				PlayerInit.p_skillArr.shift();
			}
			PlayerInit.p_skillArr = [];
//			for(var tnum:int = 0;tnum<autoSkiArr.length;tnum++){
//				//for(i = 0;i<skillArr[tnum].length;i++){
//					if(autoSkiArr[tnum].numChildren>0){
//						PlayerInit.p_skillArr.push(autoSkiArr[tnum].getChildAt(0).edata);
//						//save(getSkillname(i),temSkiSpr[i].getChildAt(0).edata.id.toString());
//					}else{
//						//save(getSkillname(i),"0");
//					}
//				//}
//			}
		}
		//写入数值
		private function setText(str:String):void{
		
		}
		//保存数据
		public function saveData():void{
			for(var i:int = 0;i<temEquSpr.length;i++){
				if(temEquSpr[i].numChildren>0){
					save(gettypename(i),temEquSpr[i].getChildAt(0).edata.id.toString());
				}else{
					save(gettypename(i),"0");
				}
			}
			for(var tnum:int = 0;tnum<skillArr.length;tnum++){
				for(i = 0;i<skillArr[tnum].length;i++){
					if(skillArr[tnum][i].numChildren>0){
						//save(getSkillname(i),skillArr[tnum][i].getChildAt(0).edata.id.toString());
					}else{
						//save(getSkillname(i),"0");
					}
				}
			}
		}
		//保存玩家
		private function save(typestr:String,showstr:String):void{
			//SqlDb.save("user",{type:typestr,show:showstr});	
			var geiaward:ChangeData = new ChangeData();
			geiaward.refreshData("user","save",{type:typestr,show:showstr});
		}
	}
}