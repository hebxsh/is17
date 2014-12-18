package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	import UI.MyText;
	
	import data.DataPool;
	import data.GameInit;
	import data.PlayerInit;

	public class ItemShow extends Sprite
	{
		public function ItemShow(tdata:Object,ts:int = 0)
		{
			this.graphics.beginFill(0X556677);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			var tstr:String = "";
			tstr += "<font color='"+GameInit.getHtmlColor(tdata.level)+"'>"+tdata.name+"</font>\n";
			if(int(tdata.id)<20000){
				var ttype:String = "";
				if (tdata.type =="1")ttype = "武器";
				if (tdata.type =="2")ttype = "防具";
				if (tdata.type =="3")ttype = "法宝";
				tstr += "类型： "+ttype+"\n\n";
				
				for (var i:int = 0;i<PlayerInit.p_xsArr.length;i++){			
					for(var property:String in tdata){				
						if (property == PlayerInit.p_xsArr[i][0]){
							if(tdata[property]!="0")tstr += PlayerInit.getName(property)+"：  "+tdata[property]+"\n";
						}
					}
				} 
				
				if (ts!==1){
					var dropEqu:MyButton = new MyButton("卸下",0xccccff);
					dropEqu.x = (this.width - dropEqu.width)>>1;
					dropEqu.y = int(this.height*.85);
					dropEqu.name = tdata.id+"";
					dropEqu.addEventListener(MouseEvent.CLICK,remEquHandler);
					this.addChild(dropEqu);
				}
			}else if(int(tdata.id)<30000){
				//tstr += "<font color='"+GameInit.getHtmlColor(tdata.level)+"'>"+tdata.name+"</font>\n\n";
				var killNum:int;
				switch(tdata.type){
					case "1":
						tstr += "类型： 攻击技能\n\n";
						tstr += "作用目标："+tdata.targetnum+"\n";
						if(int(tdata.huihe)>1)tstr += "持续回合："+tdata.huihe+"\n";
						tstr += "对目标造成"+int((PlayerInit.gongji*(tdata.baiji+tdata.baixi*tdata.nowlevel)/100+(tdata.guji+tdata.guxi*tdata.nowlevel)+tdata.xiuzheng))+"伤害\n";
						break;
					case "2":
						tstr += "类型： 恢复技能\n\n";
						if(int(tdata.huihe)>1)tstr += "持续回合："+tdata.huihe+"\n";
						tstr += "获得"+ int(PlayerInit.lingli*(int(tdata.baiji)+int(tdata.baixi)*int(tdata.nowlevel))/100+int(tdata.guji)+int(tdata.guxi)*int(tdata.nowlevel)+int(tdata.xiuzheng))+"治疗\n";
						break;
					case "3":
						tstr += "类型： 状态技能\n\n";
						tstr += "作用目标："+tdata.targetnum+"\n";
						if(int(tdata.huihe)>1)tstr += "持续回合："+tdata.huihe+"\n";
						for (var k:int=0;k<GameInit.wxsxArr.length;k++){
							killNum = getFaSkillHert(tdata,GameInit.wxsxArr[k]);	
							if(killNum>0)tstr +="对目标造成</font><font color='#ff0000'>"+killNum+"</font>"+GameInit.getSxName(GameInit.wxsxArr[k])+"属性伤害\n";
						}
						for (var j:int=0;j<GameInit.gfsxArr.length;j++){
							var delNum:int = getDefSkillHert(tdata,GameInit.gfsxArr[j]);	
							if(delNum>0)tstr +="减少目标<font color='#ff0000'>"+delNum+"</font>"+GameInit.getSxName(GameInit.gfsxArr[j])+"\n";
						}
						break;
					case "4":
						tstr += "类型： 法术技能\n\n";
						tstr += "作用目标："+tdata.targetnum+"\n";
						if(int(tdata.huihe)>1)tstr += "持续回合："+tdata.huihe+"\n";
						for (var l:int=0;l<GameInit.wxsxArr.length;l++){
							killNum = getFaSkillHert(tdata,GameInit.wxsxArr[l]);	
							if(killNum>0)tstr +="对目标造成</font><font color='#ff0000'>"+killNum+"</font>"+GameInit.getSxName(GameInit.wxsxArr[l])+"属性伤害\n";
						}
						break;
					case "7":
						tstr += "类型： 生产技能\n\n";
						break;
					case "8":
						tstr += "类型： 被动技能\n\n";
						break;
					case "9":
						tstr += "类型： 使用技能\n\n";
						break;
				}
				if (ts!==1){
					var dropSki:MyButton = new MyButton("卸下",0xccccff);
					dropSki.x = (this.width - dropSki.width)>>1;
					dropSki.y = int(this.height*.85);
					dropSki.name = tdata.id+"";
					dropSki.addEventListener(MouseEvent.CLICK,remSkiHandler);
					this.addChild(dropSki);
				}
			}else if(int(tdata.id)<50000){
				switch(tdata.type){
					case "4":
						tstr += "类型： 辅助书籍\n\n";
						tstr += tdata.shuoming;
						if(tdata.skill!="0")
						tstr += "\n"+"可习得：\n";
						break;
					case "5":
						tstr += "类型：功法\n\n";
						tstr += "可领悟：\n";
						
						break;
				}
				if(tdata.skill!="0"){
					var temArr:Array = (tdata.skill as String).split(',');
					if(temArr){
						for ( j = 0;j<temArr.length;j++){
							var tlArr:Array = temArr[j].split("&");
							var temSkill:Object =  DataPool.getSel("skill",tlArr[0]);
							tstr += "<font color='"+GameInit.getHtmlColor(temSkill.level)+"'>"+temSkill.name+"</font>("+tlArr[1]+")\n";
						}
					}
				}
				
				if (ts!==1){
//					var dropSki:MyButton = new MyButton("卸下",0xccccff);
//					dropSki.x = (this.width - dropSki.width)>>1;
//					dropSki.y = int(this.height*.85);
//					dropSki.name = tdata.id+"";
//					dropSki.addEventListener(MouseEvent.CLICK,remSkiHandler);
//					this.addChild(dropSki);
				}
			}
			var tf:MyText = new MyText(tstr,20,0x000000,"left",360);
			tf.x = 50;
			tf.y = 50;
			this.addChild(tf);
			this.addEventListener(MouseEvent.CLICK,cloHandler);			
		}
		//计算debuff属性压制
		private function getDefSkillHert(skill:Object,nam:String):int{
			var hertnum:int = 0;		
			if(skill[nam]>0)
				hertnum = int(skill[nam]*(int(skill.baiji)+int(skill.baixi)*int(skill.nowlevel))/100+int(skill.guji)+int(skill.guxi)*int(skill.nowlevel)+int(skill.xiuzheng));
			return hertnum;
		}
		//计算法术技能伤害
		private function getFaSkillHert(skill:Object,nam:String):int{
			var hertnum:int = 0;
			if(skill[nam]>0)
				hertnum = int((PlayerInit.getSx(nam)+PlayerInit.lingli)*(int(skill.baiji)+int(skill.baixi)*int(skill.nowlevel))/100+int(skill.guji)+int(skill.guxi)*int(skill.nowlevel)+int(skill.xiuzheng));
			return hertnum;
		}
		private function remEquHandler(e:MouseEvent):void{
			alone.playerdialog.removeEqu();
		}
		private function remSkiHandler(e:MouseEvent):void{
			//alone.playerdialog.removeSki(0);
		}
		private function cloHandler(e:MouseEvent):void{
			alone.topSpr.removeChildAt(0);
		}
	}
}