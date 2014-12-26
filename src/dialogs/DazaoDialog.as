package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.CodeImageIcon;
	import UI.EquipBox;
	import UI.MyButton;
	import UI.MyText;
	import UI.TabBar;
	import UI.ToolTip;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
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
		private var arrName:Array =[["剑","1&2$2&3","剑刃$剑柄",4,0],
									["衣","1&2$2&3","衣表$衣里",5,1],
									["刀","1&2$2&3","刀刃$刀柄",3,0],
									["扇","1&2$2&3","扇骨$扇面",4,0],
									["杖","1&2$2&3","杖身$杖头",3,0],
									["弓","1&2$2&3","弓骨$弓弦",4,0],
									["盾","1&2$2&3","盾被$盾衬",5,1]];
		//攻击属性对应
		private var gongArr:Array =["gongji","sudu","mingzhong","zhiming"];
		//防御属性对应
		private var fangArr:Array =["fangyu","shenfa","duobi","zhaojia"];
		//五行属性对应
		private var wuxingArr:Array =["jin","mu","shui","huo","tu","feng","lei","du","gu","zhou","hp","lingli"];
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
			
			var buildBtn:MyButton = new MyButton("打 造");
			buildBtn.x = 200;
			buildBtn.y = 660;
			buildBtn.addEventListener(MouseEvent.CLICK,buildBtnHandler);
			this.addChild(buildBtn);
		}
		//创建可选图标
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
		//显示装备类型
		private var itemType:int = 0;
		private function igcHandler(e:MouseEvent):void{
			reselect();	
			var tnum:int = int(e.target.name);
			var showStr:String = arrName[tnum][0]; 
			nameTxt.setText(showStr);
			itemType = arrName[tnum][4]; 
			showCailiao(tnum);
		}
		//刷新添加材料界面
		private function showCailiao(tnum:int):void{
			while(clSpr.numChildren>0){
				clSpr.getChildAt(0).removeEventListener(MouseEvent.CLICK,addClHandler);
				clSpr.removeChildAt(0);
			}
			var temCaiArr:Array = arrName[tnum][1].split("$");
			var temNameArr:Array = arrName[tnum][2].split("$");
			for (var i:int=0;i<temNameArr.length;i++){ 
				var sTxt:MyText = new MyText(temNameArr[i]+":");
				sTxt.x = 20;
				sTxt.y = i*60 + 110;
				clSpr.addChild(sTxt);
				
				var addClBtn:MyButton = new MyButton("<font color = '#ffffff' size='28'>+</font>",ColorInit.btnBgColor,200);
				addClBtn.x = 100;	
				addClBtn.y = i*60+100;
				addClBtn.name = temCaiArr[i];
				addClBtn.mstr = i.toString();
				clSpr.addChild(addClBtn);
				addClBtn.addEventListener(MouseEvent.CLICK,addClHandler);
			}
			for (i=0;i<arrName[tnum][3];i++){ 
				var fcTxt:MyText = new MyText("辅材:");
				fcTxt.x = 20;
				fcTxt.y = i*60 + 230;
				clSpr.addChild(fcTxt);
				
				var addFcClBtn:MyButton = new MyButton("<font color = '#ffffff' size='28'>+</font>",ColorInit.btnBgColor,200);
				addFcClBtn.x = 100;	
				addFcClBtn.y = i*60+220;
				addFcClBtn.name = "all";
				addFcClBtn.mstr = (i+temNameArr.length).toString();
				clSpr.addChild(addFcClBtn);
				addFcClBtn.addEventListener(MouseEvent.CLICK,addClHandler);
			}
		}
		//点击+号按钮
		private var mtype:int = 0;
		private var mClArr:Array = new Array();
		private var mdataArr:Array = new Array();
		private function addClHandler(e:MouseEvent):void{
			alone.bagdialog.setTitle(e.currentTarget.name,"material");	
			mtype = int(e.currentTarget.mstr);
		}
		//添加一个材料
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
			mdataArr.push(tdata);
		}
		//添加的材料自杀
		private function removeSkiHandler(e:MouseEvent):void{
			var tname:String = e.currentTarget.name;
			for (var i:int = 0;i<mClArr.length;i++){
				if(mClArr[i].name == tname){
					RefreshData.inser("bag",tname.slice(-5,tname.length));
					mClArr.splice(i,1);
					mdataArr.splice(i,1);
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
		/**
		 * 还原添加的材料
		 * */
		private function reselect():void{
			var temlen:int = mClArr.length;
			for (var i:int = 0;i<temlen;i++){
				RefreshData.inser("bag",mClArr[0].name.slice(-5,mClArr[0].name.length));
				mClArr.splice(0,1);
				mdataArr.splice(0,1);
				clshowSpr.removeChildAt(0);				
			}
		}
		//点击选项卡
		private function tabHandler(e:MouseEvent):void{
			reselect();	
		}
		//打造
		public function buildBtnHandler(e:MouseEvent = null):void{
			tatolJifa = 0;
			temstr = "";
			var haszhu:Boolean = false;
			var tooltip:ToolTip = new ToolTip();
			var temlen:int = mdataArr.length;
			for (var j:int = 0;j<temlen;j++){
				if(mClArr[j].name.slice(0,-5)=="0"){
					haszhu = true;
				}
			}	
			if (!haszhu){
				tooltip.show("请添加主材料");
				return;
			}
			
			for (var i:int = 0;i<temlen;i++){
				trace (mdataArr[i].type,mdataArr[i].name,mClArr[i].name.slice(0,-5));
				if(mClArr[i].name.slice(0,-5)=="0"){
					getZhucai(mdataArr[i],"0");
				}else if(mClArr[i].name.slice(0,-5)=="1"){
					getZhucai(mdataArr[i],"1");
				}else {
					getFucai(mdataArr[i],mClArr[i].name.slice(0,-5));
				}
			}	
			trace(temstr);
			trace("激发度：",tatolJifa);
		}
		//主材料激发度计算
		private var tatolJifa:int = 0;
		private function getZhucai(obj:Object,str:String):void{
			//材料生克
			var c_tint:int = 0;
			//激发度
			var c_jifadu:int = 0;
			//激发系数
			var c_xishu:Number = 0;
			//相克次数
			var c_xiangke:Number = 0;
			var c_temlen:int = mdataArr.length;
			//主材生克
			for (var i:int = 0;i<c_temlen;i++){
				if(mClArr[i].name.slice(0,-5)!=str){
					c_tint = GameInit.getWuxing(obj.type,int(mdataArr[i].type));
					if (int(mClArr[i].name.slice(0,-5))==1-int(str)){						
						c_xishu = 1;
					}else{
						c_xishu = .5;
					}
					if (c_tint==0){
						c_jifadu+=50*c_xishu;
					}else if(c_tint==1){
						c_jifadu+=100*c_xishu;
					}else if(c_tint==2){
						c_xiangke+=c_xishu;
					}
				}
			}
			//根据类型处理相关属性的出现	
			temstr = "类别："+nameTxt.getText();
			if(itemType == 0){
				for(var gongShuxing:String in obj){
					if(getGong(gongShuxing)&&obj[gongShuxing] != "0"){						
						temstr+="zhugongShuxing========"+int(obj[gongShuxing])*c_jifadu*c_xishu/100;						
					}
				}
			}else{
				for(var fangShuxing:String in obj){
					if(getFang(fangShuxing)&&obj[fangShuxing] != "0"){						
						temstr+="zhufangShuxing========"+int(obj[fangShuxing])*c_jifadu*c_xishu/100;						
					}
				}
			}
			tatolJifa+=c_jifadu;
			//五行生克
			var w_tint:int = 0;
			//计数
			//生
			var w_snum:int = 0;
			//克
			var w_knum:int = 0;
			//无
			var w_wnum:int = 0;
			//激发度
			var w_jifadu:int = 0;
			//激发系数
			var w_xishu:Number = 0;
			//相克次数
			var w_xiangke:Number = 0;
			//是否隐藏属性判断
			var w_yinpan:Boolean = false;
			
			for(var property:String in obj){
				if (obj[property] != "0"){
					if(property.indexOf("yin")){
						property.slice(2);
						w_yinpan = true;
					}else{
						w_yinpan = false;
					}
					if (GameInit.getWuxingId(property)>0){
						for (var j:int = 0;j<c_temlen;j++){
							if(mClArr[j].name.slice(0,-5)!=str){								
								w_tint = GameInit.getWuxing(GameInit.getWuxingId(property),int(mdataArr[j].type));
								trace (GameInit.getWuxingId(property),int(mdataArr[j].type),w_tint);
								if (int(mClArr[j].name.slice(0,-5))==1-int(str)){						
									w_xishu = 1;
								}else{
									w_xishu = .5;
								}
								if (w_tint==0){	
									if(w_yinpan){
										w_wnum++;
										if(w_wnum==2){
											w_wnum = 0;
											w_jifadu+=50*w_xishu;
										}
									}else{
										w_jifadu+=50*w_xishu;
									}
								}else if(w_tint==1){
									if(w_yinpan){
										w_snum++;
										if(w_snum==2){
											w_snum = 0;
											w_jifadu+=100*w_xishu;
										}
									}else{
										w_jifadu+=100*w_xishu;
									}
								}else if(w_tint==2){
									if(w_yinpan){
										w_knum++;
										if(w_knum==2){
											w_knum = 0;
											w_xiangke+=w_xishu;
										}
									}else{
										w_xiangke+=w_xishu;
									}
								}
							}
						}
						trace("主属性"+property+"激发度： ",w_jifadu,w_xishu,"主属性"+obj.name+"被克次数： ",w_xiangke);	
						temstr+=property+"========"+int(obj[property])*w_jifadu/100;
						tatolJifa+=w_jifadu;
					}					
				}				
			}
			trace("主材料"+obj.name+"激发度： ",c_jifadu,c_xishu,"主材料"+obj.name+"被克次数： " ,c_xiangke);			
		}
		//生成的装备说明
		private var temstr:String = "";
		private function getGong(str:String):Boolean{
			var tb:Boolean = false;
			for (var i:int = 0;i<gongArr.length;i++){
				if(gongArr[i]==str)tb = true;
			}
			return tb;
		}
		private function getFang(str:String):Boolean{
			var tb:Boolean = false;
			for (var i:int = 0;i<fangArr.length;i++){
				if(fangArr[i]==str)tb = true;
			}
			return 0;
		}
		private function getWuxing(str:String):Boolean{
			var tb:Boolean = false;
			for (var i:int = 0;i<wuxingArr.length;i++){
				if(wuxingArr[i]==str)tb = true;
			}
			return 0;
		}
		//辅材料激发度计算
		private function getFucai(obj:Object,str:String):void{
			var c_tint:int = 0;
			var c_jifadu:int = 0;
			var c_xishu:Number = 0;
			var c_xiangke:Number = 0;
			var c_temlen:int = mdataArr.length;
			for (var i:int = 0;i<c_temlen;i++){
				if(mClArr[i].name.slice(0,-5)!=str&&int(mClArr[i].name.slice(0,-5))>1){
					c_tint = GameInit.getWuxing(obj.type,int(mdataArr[i].type));
					if (int(mClArr[i].name.slice(0,-5))<2){						
						c_xishu = .4;
					}else{
						c_xishu = .2;
					}
					if (c_tint==0){
						c_jifadu+=50*c_xishu;
					}else if(c_tint==1){
						c_jifadu+=100*c_xishu;
					}else if(c_tint==2){
						c_xiangke++;
					}
				}
			}			
			//根据类型处理相关属性的出现
			if(itemType == 0){
				for(var gongShuxing:String in obj){
					if(getGong(gongShuxing)&&obj[gongShuxing] != "0"){						
						temstr+="fugongShuxing========"+int(obj[gongShuxing])*c_jifadu*c_xishu/100;						
					}
				}
			}else{
				for(var fangShuxing:String in obj){
					if(getFang(fangShuxing)&&obj[fangShuxing] != "0"){						
						temstr+="fufangShuxing========"+int(obj[fangShuxing])*c_jifadu*c_xishu/100;						
					}
				}
			}
			tatolJifa+=c_jifadu;
			//五行生克
			var w_tint:int = 0;
			//激发度
			var w_jifadu:int = 0;
			//激发系数
			var w_xishu:Number = 0;
			//相克次数
			var w_xiangke:Number = 0;
			
			for(var property:String in obj){
				if (obj[property] != "0"){
					if (GameInit.getWuxingId(property)>0){
						for (var j:int = 0;j<c_temlen;j++){
							if(mClArr[j].name.slice(0,-5)!=str){								
								w_tint = GameInit.getWuxing(GameInit.getWuxingId(property),int(mdataArr[j].type));
								trace (GameInit.getWuxingId(property),int(mdataArr[j].type),w_tint);
								if (int(mClArr[j].name.slice(0,-5))<2){						
									w_xishu = .4;
								}else{
									w_xishu = .2;
								}
								if (w_tint==0){
									w_jifadu+=50*w_xishu;
								}else if(w_tint==1){
									w_jifadu+=100*w_xishu;
								}else if(w_tint==2){									
									w_xiangke+=w_xishu;									
								}
							}
						}
						trace("辅属性"+property+"激发度： ",w_jifadu,w_xishu,"辅属性"+obj.name+"被克次数： ",w_xiangke);	
						temstr+=property+"========"+int(obj[property])*w_jifadu/100;
						tatolJifa+=w_jifadu;
					}					
				}				
			}
			trace("辅材料"+obj.name+"激发度： " ,c_jifadu,c_xishu,"辅材料"+obj.name+"被克次数： " ,c_xiangke);	
		}
		
		//关闭
		public function closeHandler(e:MouseEvent = null):void{
			reselect();
			this.theDest();		
		}
	}
}