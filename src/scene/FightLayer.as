package scene
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import UI.BloodBar;
	import UI.MyButton;
	import UI.MyText;
	import UI.Panel;
	import UI.ToolTip;
	
	import data.ChangeData;
	import data.ColorInit;
	import data.DataInit;
	import data.DataPool;
	import data.GameInit;
	import data.Monster;
	import data.PlayerInit;
	import data.Reward;
	import data.SqlDb;
	
	import dialogs.DialogObject;
	import dialogs.UserLogin;
	
	import event.CommEvent;

	public class FightLayer extends DialogObject
	{
		private var m_panel:Panel;
		private var queBtn:MyButton;
		private var m_level:int = 0;
		private var tooltip:ToolTip;
		
		private var showStr:String = "";
		private var monSpr:Sprite;
		private var monsterArr:Array = new Array();
		private var liveMonArr:Array = new Array();
		private var killNum:int = 0;
		private var delNum:int = 0;
		private var timer:Timer ;
		private var text:MyText;
		//private var monsterSpr:Sprite;
		
		private var playerbloodbar:BloodBar;
		private var playerNameTxt:MyText;
		
		private var jinduArr:Array = new Array();
		private var arrErArr:Array = new Array();
		//判断是否战斗结束
		private var isOver:Boolean = false;
		
		public function FightLayer()
		{
		}
		override public function theOpen():void{
			this.visible = true;
			init();
			showFight();
		}
		//初始化战斗显示面板
		private function init():void{
			tooltip = new ToolTip();
			theTitle("战斗信息");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			if(!monSpr)monSpr = new Sprite();
			this.addChild(monSpr);
			if(!m_panel)m_panel = new Panel(GameInit.m_stage.stageWidth*0.8,GameInit.m_stage.stageHeight*0.5);
			m_panel.x = (GameInit.m_stage.stageWidth - m_panel.width)/2;
			m_panel.y = 220;
			this.addChild(m_panel);
			
			if(!queBtn) queBtn = new MyButton("确定");
			queBtn.x = (GameInit.m_stage.stageWidth-queBtn.width)>>1;
			queBtn.y = GameInit.m_stage.stageHeight*0.9;
			queBtn.visible = false;
			queBtn.addEventListener(MouseEvent.CLICK,cloHandler);
			this.addChild(queBtn);
			arrErArr.push(PlayerInit);
		}
		//刷新敌人，玩家等。
		public function showFight():void{
			
			while (monsterArr.length>0)monsterArr.shift();
			monsterArr = [];
			while (monSpr.numChildren>0)monSpr.removeChildAt(0);
			
			for (var i:int = 0;i<m_level+2;i++){
				var monster:Monster = new Monster();
				monster.x = i%3*120;
				monster.y = int(i/3)*50;
				monster.init(m_level);
				monSpr.addChild(monster);
				monsterArr.push(monster);
				arrErArr.push(monster);
				
			}
			if(!playerbloodbar)playerbloodbar = new BloodBar(PlayerInit.hp);
			playerbloodbar.x = 50;
			playerbloodbar.y = 640;
			playerbloodbar.ReNum(PlayerInit.hp);
			this.addChild(playerbloodbar);
			if(!playerNameTxt)playerNameTxt = new MyText(PlayerInit.name);
			playerNameTxt.x = playerbloodbar.x;
			playerNameTxt.y = playerbloodbar.y+7;
			
			this.addChild(playerNameTxt);
			//重置状态
			isOver = false;
			//写入速度
			
			for (i = 0;i<arrErArr.length;i++){
				jinduArr.push(0);
			}
			
			timer = new Timer(GameInit.FITERDELAY);
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			timer.start();
			
		}
		//生成战斗记录
		private function getActionList(item:*):void{
			showStr = "";
			if (item.p_type == 0){				
				if(!isOver){
					userSkill();
				}
			}else{
				dotHert(item);
				killPlayer(item);
			}
			
			text = new MyText(showStr,20,0x000000,"left",360);
			text.x = 10;			
			m_panel.addContent(text);
			m_panel.lastContents();
		}
		//时间显示战斗记录
		private function timerHandler(e:TimerEvent):void{
			getAction();
		}
		//玩家使用技能攻击怪物
		private function userSkill():void{
			//取出活的开砍
			liveMonArr = [];
			for(var i:int = 0;i<monsterArr.length;i++){
				if(monsterArr[i].p_die == false){
					liveMonArr.push([monsterArr[i],i]);
				}
			}
			
			//玩家使用技能攻击怪物
			if (PlayerInit.p_skillArr.length>0&&Math.random()>0){
				//如果释放技能，取得一个随机技能
				var rsk:int = int(Math.random()*PlayerInit.p_skillArr.length);
				var skill:Object = DataInit.getCopy(getSkill(rsk));
				//循环个数
				for (i = 0;i<skill.targetnum;i++){
					//取出一个活的
					if(liveMonArr.length<=0)break;
					var livenum:int = int(Math.random()*liveMonArr.length);
					var monster:Monster = liveMonArr[livenum][0];
					liveMonArr.splice(livenum,1);				
					//判断技能属性
					switch(skill.type){
						case "1":
							killNum = getGongSkillHert(skill,monster);
							if (killNum<0)killNum=0;
							showStr +="你使用"+"<font color='"+GameInit.getHtmlColor(int(skill.level))+"'>"+skill.name+"</font>对<font color='#003fe0'>"+monster.name+"</font>造成了<font color='#ff0000'>"+killNum+"</font>伤害\n";
							killMonster(monster);
							break;
						case "2":
							killNum = int(PlayerInit.gongji*skill.percentage/100);
							if (PlayerInit.hp + killNum>PlayerInit.maxhp)PlayerInit.hp = PlayerInit.maxhp;
							showStr +="你使用"+"<font color='"+GameInit.getHtmlColor(int(skill.level))+"'>"+skill.name+"</font><font color='#003fe0'></font>获得了<font color='#ff0000'>"+killNum+"</font>治疗\n";
							break;
						case "3":
							for (var k:int=0;k<GameInit.wxsxArr.length;k++){
								killNum = getFaSkillHert(skill,monster,GameInit.wxsxArr[k]);
								if (killNum<0)killNum=0;
								if(monster.hp<=0)break;
								if(killNum>0)showStr +="你使用"+"<font color='"+GameInit.getHtmlColor(int(skill.level))+"'>"+skill.name+"</font>对<font color='#003fe0'>"+monster.name+"</font>造成了<font color='#ff0000'>"+killNum+"</font>"+GameInit.getSxName(GameInit.wxsxArr[k])+"属性伤害\n";
								killMonster(monster);
							}
							if (!selDot(monster,int(skill.id),int(skill.huihe)))break;
							for (var j:int=0;j<GameInit.gfsxArr.length;j++){
								delNum = getDefSkillHert(skill,monster,GameInit.gfsxArr[j]);	
								if(delNum>0)showStr +="<font color='#003fe0'>"+monster.name+"</font>减少了<font color='#ff0000'>"+delNum+"</font>"+GameInit.getSxName(GameInit.gfsxArr[j])+"\n";
								debMonster(monster,GameInit.gfsxArr[j],delNum);
							}
							break;
						case "4":
							for (var l:int=0;l<GameInit.wxsxArr.length;l++){
								killNum = getFaSkillHert(skill,monster,GameInit.wxsxArr[l]);
								if (killNum<0)killNum=0;
								if(monster.hp<=0)break;
								if(killNum>0)showStr +="你使用"+"<font color='"+GameInit.getHtmlColor(int(skill.level))+"'>"+skill.name+"</font>对<font color='#003fe0'>"+monster.name+"</font>造成了<font color='#ff0000'>"+killNum+"</font>"+GameInit.getSxName(GameInit.wxsxArr[l])+"属性伤害\n";
								killMonster(monster);
							}
							break;
						case "5":
							break;
					}
					//如果是dot技能	
					if (int(skill.huihe)>1){
						skill.huihe = int(skill.huihe)-1;
						if (selDot(monster,int(skill.id),int(skill.huihe))){
							monster.p_dotArr.push(skill);
						}
					}
				}
				
			}else{//普通攻击
				livenum = int(Math.random()*liveMonArr.length);
				monster = liveMonArr[livenum][0];
				killNum = PlayerInit.gongji-monster.fangyu;
				if (killNum<0)killNum=0;
				showStr +="你对<font color='#003fe0'>"+monster.name+"</font>造成了<font color='#ff0000'>"+killNum+"</font>伤害\n";
				killMonster(monster);			
			}
		}
		//查询dot技能
		private function selDot(monster:Monster,sid:int,huihe:int):Boolean{
			var bol:Boolean = true;
			for(var i:int= 0; i<monster.p_dotArr.length;i++){
				if(monster.p_dotArr[i].id == sid){
					monster.p_dotArr[i].huihe = huihe;
					bol = false;			
				}
			}
			return bol;
		}
		//结算dot技能伤害
		private function dotHert(monster:Monster):void{
			for each(var temSkill:Object in monster.p_dotArr){
				if (!monster.p_die){//如果存活
					temSkill.huihe--;
					//判断技能属性
					switch(temSkill.type){
						case "1":							
							killNum = getGongSkillHert(temSkill,monster);
							if (killNum<0)killNum=0;
							showStr ="<font color='#003fe0'>"+monster.name+"</font>受到了"+"<font color='"+GameInit.getHtmlColor(int(temSkill.level))+"'>"+temSkill.name+"</font><font color='#ff0000'>"+killNum+"</font>伤害"+temSkill.huihe+"\n";
							killMonster(monster);
							break;
						case "2":
							killNum = int(PlayerInit.gongji*temSkill.percentage/100);
							if (PlayerInit.hp + killNum>PlayerInit.maxhp)PlayerInit.hp = PlayerInit.maxhp;
							showStr +="你使用"+"<font color='"+GameInit.getHtmlColor(int(temSkill.level))+"'>"+temSkill.name+"</font><font color='#003fe0'></font>获得了<font color='#ff0000'>"+killNum+"</font>治疗\n";
							break;
						case "3":
							for (var k:int=0;k<GameInit.wxsxArr.length;k++){
								killNum = getFaSkillHert(temSkill,monster,GameInit.wxsxArr[k]);
								if (killNum<0)killNum=0;
								if(monster.hp<=0)break;
								if(killNum>0)showStr +="<font color='#003fe0'>"+monster.name+"</font>受到了"+"<font color='"+GameInit.getHtmlColor(int(temSkill.level))+"'>"+temSkill.name+"</font><font color='#ff0000'>"+killNum+"</font>"+GameInit.getSxName(GameInit.wxsxArr[k])+"属性伤害\n";
								killMonster(monster);
							}
							break;
						case "4":
							for (var l:int=0;l<GameInit.wxsxArr.length;l++){
								killNum = getFaSkillHert(temSkill,monster,GameInit.wxsxArr[l]);
								if (killNum<0)killNum=0;
								if(monster.hp<=0)break;
								if(killNum>0)showStr +="<font color='#003fe0'>"+monster.name+"</font>受到了"+"<font color='"+GameInit.getHtmlColor(int(temSkill.level))+"'>"+temSkill.name+"</font><font color='#ff0000'>"+killNum+"</font>"+GameInit.getSxName(GameInit.wxsxArr[l])+"属性伤害\n";
								killMonster(monster);
							}
							break;
						case "5":
							break;
					}
					
					if (temSkill.huihe<=0){
						if (temSkill.type == 3){
						}						
						monster.p_dotArr.splice(monster.p_dotArr.indexOf(temSkill),1);
						
					}
				}
			}
		}
		//计算攻击技能伤害
		private function getGongSkillHert(skill:Object,mon:Monster):int{
			var hertnum:int = 0;
			hertnum = int(PlayerInit.gongji*(int(skill.baiji)+int(skill.baixi)*int(skill.nowlevel))/100+int(skill.guji)+int(skill.guxi)*int(skill.nowlevel)+int(skill.xiuzheng))-mon.fangyu;
			return hertnum;
		}
		//计算debuff属性压制
		private function getDefSkillHert(skill:Object,mon:Monster,nam:String):int{
			var hertnum:int = 0;		
			if(skill[nam]>0)
				hertnum = int(skill[nam]*(int(skill.baiji)+int(skill.baixi)*int(skill.nowlevel))/100+int(skill.guji)+int(skill.guxi)*int(skill.nowlevel)+int(skill.xiuzheng));
			return hertnum;
		}
		//计算法术技能伤害
		private function getFaSkillHert(skill:Object,mon:Monster,nam:String):int{
			var hertnum:int = 0;
			if(skill[nam]>0)
			hertnum = int((PlayerInit.getSx(nam)+PlayerInit.lingli)*(int(skill.baiji)+int(skill.baixi)*int(skill.nowlevel))/100+int(skill.guji)+int(skill.guxi)*int(skill.nowlevel)+int(skill.xiuzheng))-mon.lingli-mon.getSx(nam);
			return hertnum;
		}
		//怪物扣血，是否杀死怪物
		private function killMonster(mon:Monster):void{
			mon.hp-=killNum;			
			mon.bloodbar.ReNum(mon.hp);
			//杀死
			if (mon.hp<=0&&!mon.p_die){
				showStr +="你斩杀了<font color='#003fe0'>"+mon.name+"</font>\n";
				tooltip.show("你斩杀了"+mon.name);				
				mon.p_die = true;
				
				var allKill:Boolean = true;
				for (var i:int=0;i<monsterArr.length;i++){
					if(!monsterArr[i].p_die){
						allKill=false;
						break;
					}
				}
				if(allKill){
					//获取奖励  杀死所有怪物获取
					isOver = true;
					queBtn.visible = true;
					Reward.getitem(m_level);
					timer.removeEventListener(TimerEvent.TIMER,timerHandler);
				}								
			}
		}
		/**
		 * 添加获得物品到战斗信息
		 * */
		public function showReward(showstr:String):void{
			text = new MyText(showstr,20,0x000000,"left",360);
			text.x = 10;			
			m_panel.addContent(text);
			m_panel.lastContents();
		}

		//debuff效果
		private function debMonster(mon:Monster,str:String,num:int):void{
			var tnum:int;
			if(num>0){
				tnum = mon.getSx(str) - num;
				mon.setSx(str,tnum);
			}
		}
		
		//怪物攻击玩家
		private function killPlayer(monster:Monster):void{
			killNum = monster.gongji - PlayerInit.fangyu;
			(killNum<0)?killNum=0:0;
			showStr+="<font color='#003fe0'>"+monster.name+"</font>对你造成了<font color='#ff0000'>"+killNum+"</font>伤害\n";
			PlayerInit.hp -= killNum;
			//玩家扣血以及血条变化
			if (killNum<0)killNum=0;
			playerbloodbar.ReNum(PlayerInit.hp);
			//判断玩家是否战死。
			if(PlayerInit.hp<=0)
			{
				showStr+="你被<font color='#003fe0'>"+monster.name+"</font>击败了！";
				die();
			}
		}
		//获取技能
		private function getSkill(rsk:int):Object{
			return PlayerInit.p_skillArr[rsk];
		}
		//获取速度排序
		private function getAction():void{			
			//取得行动单位去行动
			for ( var i:int = 0;i<arrErArr.length;i++){
				jinduArr[i] += arrErArr[i].sudu;
				if (jinduArr[i]>=1000){
					jinduArr[i] = 0;
					getActionList(arrErArr[i]);
					break; 
				}					
			}		
		}
		
		private function progressBar():void{
			
		}
		//关闭
		private function cloHandler(e:MouseEvent):void{
			while (arrErArr.length>0)arrErArr.shift();
			arrErArr = [];
			m_panel.removeContents();
			this.graphics.clear();
			this.theDest();
		}
		public function set level(lev:int):void{
			m_level = lev;
		}
		private function die():void{
			isOver = true;
			queBtn.visible = true;
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			PlayerInit.p_status = 1;
		}
	}
}