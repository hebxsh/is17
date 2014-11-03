package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.EquipBox;
	import UI.MyButton;
	import UI.MyText;
	import UI.TabBar;
	
	import data.DataPool;
	import data.GameInit;
	import data.PlayerInit;
	import data.SqlDb;
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
//		private var skill1:Sprite = new Sprite();
//		private var skill2:Sprite = new Sprite();
//		private var skill3:Sprite = new Sprite();
//		private var skill4:Sprite = new Sprite();
		private var equipSpr:Sprite = new Sprite();
		
		/**技能相关*/
		private var skillSpr:Sprite = new Sprite();
		private var aotuArr:Array = ["aut1","aut2","aut3","aut4"];
		private var zhuArr:Array = ["zhu1","zhu2","zhu3","zhu4"];
		private var xiuArr:Array = ["xiu1","xiu2","xiu3","xiu4"];
		private var skillStrArr:Array = [aotuArr,zhuArr,xiuArr];
		private var autoSpr:Sprite = new Sprite();
		private var zhuSpr:Sprite = new Sprite();
		private var xiuSpr:Sprite = new Sprite();
		private var autoSkiArr:Array = new Array();
		private var zhuSkiArr:Array = new Array();
		private var xiuSkiArr:Array = new Array();
		private var skillArr:Array = [autoSkiArr,zhuSkiArr,xiuSkiArr];
		
		private var itemArr:Array = [txtSpr,equipSpr,skillSpr];
		public function PlayerDialog()
		{
			init();
			this.visible = false;
		}
		//初始化
		private function init():void{	
			theTitle("人 物");
			this.graphics.beginFill(0Xcccc77);
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
			addSkill();
			
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
		//添加技能背景
		private function createSkill():void{
			createText(skillSpr,20,25,"自动技能",0x00EC00);
			createText(skillSpr,20,205,"主动技能",0x00EC00);
			createText(skillSpr,20,385,"修炼技能",0x00EC00);
			
			for (var i:int = 0;i<aotuArr.length;i++){
				createAddBg(autoSpr,autoSkiArr,i%2*190+20,int(i/2)*70+25,aotuArr[i]);
			}
			for ( i = 0;i<zhuArr.length;i++){
				createAddBg(zhuSpr,zhuSkiArr,i%2*190+20,int(i/2)*70+205,zhuArr[i]);
			}
			for ( i = 0;i<xiuArr.length;i++){
				createAddBg(xiuSpr,xiuSkiArr,i%2*190+20,int(i/2)*70+385,xiuArr[i]);
			}
			skillSpr.addChild(autoSpr);
			skillSpr.addChild(zhuSpr);
			skillSpr.addChild(xiuSpr);
			
//			createSki(skill1,20,20,"skill1");
//			createSki(skill2,210,20,"skill2");
//			createSki(skill3,20,110,"skill3");
//			createSki(skill4,210,110,"skill4");	
		}
		private function addSkill():void{
			for (var i:int = 0;i<skillStrArr.length;i++){
				for (var j:int = 0;j<skillStrArr[i].length;j++){
//					if(DataPool.getArr("user")[0].skill1>0){
//						skillid = getSkillid("skill1");
//						addSki(DataPool.getArr("user")[0].skill1);
//					}
					for(var property:String in DataPool.getArr("user")[0]){
						if (property == skillStrArr[i][j]&&DataPool.getArr("user")[0][property]!="0"){
							skillid = j;
							addSki(DataPool.getArr("user")[0][property],-1,i);
						}
					}
				}
			}
			
//			if(DataPool.getArr("user")[0].skill2>0){
//				skillid = getSkillid("skill2");
//				addSki(DataPool.getArr("user")[0].skill2);
//			}
//			if(DataPool.getArr("user")[0].skill3>0){
//				skillid = getSkillid("skill3");
//				addSki(DataPool.getArr("user")[0].skill3);
//			}
//			if(DataPool.getArr("user")[0].skill4>0){
//				skillid = getSkillid("skill4");
//				addSki(DataPool.getArr("user")[0].skill4);
//			}
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
		public function addEqu(id:int,tpid:int = -1):void{
			if (tpid==-1){
				tpid = typeid;								
			}else{
				if (tpid==2&&temEquSpr[tpid].numChildren>0)tpid=3;
				if (tpid==2&&temEquSpr[tpid].numChildren>0&&temEquSpr[tpid+1].numChildren>0)tpid=2+int(Math.random()*2);
				removeEqu(tpid);
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
				SqlDb.insert("bag",{id:tmid,num:1});	
				//DataPool.getArr("bag").push(xx);			
			}
			Refresh();
		}
		///////////////////////////////////////////////////////////////////////////////////////
		//添加装备背景
		
		private var skillid:int = 0;
		private var skilltype:int = 0;
		//添加技能栏
		private function createAddBg(ts:Sprite,tArr:Array,x:int,y:int,name:String):void{
			var tspr:Sprite = new Sprite();
			tspr.x = x;
			tspr.y = y;
			tspr.name = name;
			tspr.graphics.beginFill(0Xcc4477);
			tspr.graphics.drawRect(0,0,GameInit.m_equidwidth+4,GameInit.m_equidheight+4);	
			
			var tf:MyText = new MyText("+",36,0x00cc00,"center");
			tf.x = (GameInit.m_equidwidth-100)/2;
			tspr.addChild(tf);
			tspr.addEventListener(MouseEvent.CLICK,addSkiHandler);
			ts.addChild(tspr);
			
			var tsp:Sprite = new Sprite();
			tsp.x = x;
			tsp.y = y;
			tsp.name = name;
			tsp.addEventListener(MouseEvent.CLICK,setSkiHandler);
			ts.addChild(tsp);
			tArr.push(tsp);
		}
		//点击+号按钮
		private function addSkiHandler(e:MouseEvent):void{
			//trace (e.currentTarget.name);
			alone.skilldialog.setTitle();
			var tname:String = e.currentTarget.name;
			skillid = getSkillid(tname);
			skilltype = getSkillType(tname);
		}
		//点击装备
		private function setSkiHandler(e:MouseEvent):void{
			var tname:String = e.currentTarget.name;
			skillid = getSkillid(tname);
			skilltype = getSkillType(tname);
		}
		private function getSkillid(str:String):int{
			var tid:int = 0;
			return int(str.slice(3))-1;
		}
		private function getSkillType(str:String):int{
			var ttype:int = 0;
			switch(str.slice(0,3)){
				case "aut":
					ttype = 0;
					break;
				case "zhu":
					ttype = 1;
					break;
				case "xiu":
					ttype = 2;
					break;
			}
			return ttype;
		}
//		private function getSkillname(str:int):String{
//			var tid:String = "";
//			switch(str){
//				case 0:
//					tid = "skill1";
//					break;
//				case 1:
//					tid = "skill2";
//					break;
//				case 2:
//					tid = "skill3";
//					break;
//				case 3:
//					tid = "skill4";
//					break;
//			}
//			return tid;
//		}
		//添加更换技能
		public function addSki(id:int,tpid:int = -1,tnum:int = 0):void{
			if (tpid==-1){
				tpid = skillid;				
			}else{				
				tnum = skilltype;
				if (skillArr[tnum][0].numChildren == 0){
					tpid = skillid;	
				}else if (skillArr[tnum][1].numChildren == 0){
					tpid = skillid;	
				}else if (skillArr[tnum][2].numChildren == 0){
					tpid = skillid;	
				}else if (skillArr[tnum][3].numChildren == 0){
					tpid = skillid;	
				}else {
					tpid=int(Math.random()*4);
					removeSki(tpid);
				}
			}
			//DataPool.getArr("userskill")[id].using = ++tnum;
			refreshSkill(id,tnum+1);
			//获取技能等级
			var tdata:Object = DataPool.getSel("skill",id);
			tdata.nowlevel = DataPool.getSel("userskill",id).nowlevel;
			var tbx:EquipBox = new EquipBox(tdata);			
			skillArr[tnum][tpid].addChild(tbx);
			Refresh();
		}
		//更新技能状态
		private function refreshSkill(id:int,tnum:int):void{
			var arr:Array = DataPool.getArr("userskill");
			var len:int = arr.length;
			for (var i:int = 0;i<len;i++){
				if(arr[i].id == id){
					arr[i].useing = tnum;
					saveSkill("useing",tnum.toString(),"id",id.toString());
				}
			}
		}
		//移除技能
		public function removeSki(tnum:int,tpid:int = -1,tnum:int = 0):void{
			if (tpid==-1){
				tpid = skillid;
			}
			tnum = skilltype;
			while(skillArr[tnum][tpid].numChildren>0){
				var tmid:int = skillArr[tnum][tpid].getChildAt(0).edata.id;
				var tmlevel:int = skillArr[tnum][tpid].getChildAt(0).edata.level;
				var tmexp:int = skillArr[tnum][tpid].getChildAt(0).edata.exp;
				skillArr[tnum][tpid].removeChildAt(0);
				//refreshSkill(tmid,++tnum);
				saveSkill("useing",tnum.toString(),"id",tmid.toString());
				//var xx:Object = {id:tmid,num:1};
				/**添加移除技能，不改变技能列表，只更新技能状态。*/
				//SqlDb.insert("userskill",{id:tmid,level:tmlevel,exp:tmexp});
				//DataPool.getArr("bag").push(xx);			
			}
			Refresh();
		}
		//关闭面板
		private function closeHandler(e:MouseEvent):void{
			this.theDest();
		}
		
		//刷新属性
		public function Refresh():void{			
			PlayerInit.init();
			
			for(var i:int = 0;i<temEquSpr.length;i++){
				if(temEquSpr[i].numChildren>0){
					for(var property:String in temEquSpr[i].getChildAt(0).edata){
						PlayerInit.setSx(property,int(temEquSpr[i].getChildAt(0).edata[property]));
					}
				}else{
					//save(gettypename(i),"0");
				}
			}
			
			PlayerInit.maxhp = PlayerInit.hp;
			
			for (i = 0;i<m_sxArr.length;i++){
				m_sxArr[i][1].setText(PlayerInit.getSx(m_sxArr[i][0]));
			}

			//写入技能数据
			while(PlayerInit.p_skillArr.length>0){
				PlayerInit.p_skillArr.shift();
			}
			PlayerInit.p_skillArr = [];
			for(var tnum:int = 0;tnum<autoSkiArr.length;tnum++){
				//for(i = 0;i<skillArr[tnum].length;i++){
					if(autoSkiArr[tnum].numChildren>0){
						PlayerInit.p_skillArr.push(autoSkiArr[tnum].getChildAt(0).edata);
						//save(getSkillname(i),temSkiSpr[i].getChildAt(0).edata.id.toString());
					}else{
						//save(getSkillname(i),"0");
					}
				//}
			}
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
			SqlDb.save("user",{type:typestr,show:showstr});	
		}
		//保存技能
		private function saveSkill(typestr:String,showstr:String,namestr:String,nameshowstr:String):void{
			SqlDb.save("userskill",{type:typestr,show:showstr,typeName:namestr,nameShow:nameshowstr});	
		}
	}
}