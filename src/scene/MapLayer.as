package scene
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import UI.MapBox;
	import UI.MyButton;
	import UI.MyText;
	
	import data.DataPool;
	import data.Explore;
	import data.Fight;
	import data.GameInit;
	import data.Map;
	import data.PlayerInit;
	
	import dialogs.DialogObject;


	public class MapLayer extends DialogObject
	{
		public var hang:int = 10;
		public var lie:int = 8;
		private var mapArr:Array ;
		private var view:int = 1;
		private var m_level:int = 0;
		private var mapSpr:Sprite;
		private var resetBtn:MyButton;
		private var titleTxt:MyText;
		//private var mapSpr:Sprite;
		public function MapLayer()
		{
			//init();
		}
		override public function theOpen():void{
			this.visible = true;
			//init();
			reSet();
		}
		//初始化
		private function init():void{
			if(!mapSpr){
				mapSpr = new Sprite;				
				this.addChild(mapSpr);
				mapSpr.addEventListener(MouseEvent.MOUSE_DOWN,tdHandler);
				mapSpr.addEventListener(MouseEvent.MOUSE_UP,tuHandler);
			}
			if(!resetBtn){
				resetBtn = new MyButton("下一关",0xccaa77,80);
				resetBtn.x = GameInit.m_stage.stageWidth - resetBtn.width;
				resetBtn.y = GameInit.m_stage.stageHeight - resetBtn.height*2;
				resetBtn.addEventListener(MouseEvent.CLICK,nextCustom);				
				this.addChild(resetBtn);
			}
			resetBtn.visible = false;
			if(!titleTxt){
				titleTxt = new MyText(DataPool.getArr("mountain")[m_level].name);
				titleTxt.x = (GameInit.m_stage.stageWidth-titleTxt.width)>>1;
				titleTxt.y = titleTxt.height*2;
				titleTxt.filters = [new GlowFilter(0xffffff, 1.0, 2.0, 2.0, 10, 1, false, false)];
				this.addChild(titleTxt);
			}
			titleTxt.setText(DataPool.getArr("mountain")[m_level].name);
			var map:Map = new Map();
			var temArr:Array = map.getmap(m_level);
			hang = DataPool.getArr("mountain")[m_level].hang;
			lie = DataPool.getArr("mountain")[m_level].lie;
			
			mapArr = new Array;
			for (var i:int = 0;i<hang;i++){
				mapArr.push(new Array());
				for (var j:int = 0;j<lie;j++){
					var tbox:MapBox = new MapBox(0,temArr[i][j].type,temArr[i][j].ground,temArr[i][j].level);
					tbox.x = j*(tbox.width+2);
					tbox.y = i*(tbox.width+2);
					tbox.thang = j;
					tbox.tlie = i;
					tbox.addEventListener(MouseEvent.CLICK,tcHandler);
					mapSpr.addChild(tbox);
					mapArr[i].push(tbox);
				}
			}
			var rp:Boolean = true;
			//定位到0级图
			while (rp){
				var tx:int = Math.random()*hang;
				var ty:int = Math.random()*lie;
				if (temArr[tx][ty].ground == 3){
					mapArr[tx][ty].maskAlpha();
					mapSpr.x = int((GameInit.m_stage.stageWidth - GameInit.m_mapwidth-6)/2-(GameInit.m_mapwidth+6)*ty);
					mapSpr.y = int((GameInit.m_stage.stageHeight - GameInit.m_mapheight-6)/2-(GameInit.m_mapheight+6)*tx);
					rp = false;
				}
			}			
		}
		//点击事件
		private var selBox:MapBox;
		private function tcHandler(e:MouseEvent):void{
			selBox = e.currentTarget as MapBox;
			if (selBox.fight){
				fighting(selBox,selBox.type,selBox.level);
			}else{
				if (selBox.getalpha == .6){
					explore(selBox,1);
					//tb.setStatus(int(tb.level/2)+1);
				}else if(selBox.getalpha == 0){
					//无反应
				}
			}
		}
		//按下事件
		private function tdHandler(e:MouseEvent):void{
			mapSpr.startDrag();
		}
		//弹起事件
		private function tuHandler(e:MouseEvent):void{
			mapSpr.stopDrag();
		}
		//战斗
		private function fighting(tb:MapBox,etyp:int,elev:int):void{
			var fight:Fight = new Fight();
			fight.fighting(etyp,elev);
			//PlayerInit.p_hp-=(elev+1);			
			alone.upui.Refresh();
			
			
//			if (PlayerInit.p_status == 1){
//				var e:CommEvent = new CommEvent(CommEvent.GAMEOVER);
//				dispatchEvent(e);
//				this.gameOver();
//			}else{
//				
//				if (elev == 4){
//					m_level++;
//					PlayerInit.p_custom++;
//					resetBtn.visible = true;
//				}
//				//展开其他相关地图
//				var th:int = tb.tlie;
//				var tl:int = tb.thang;	
//				//tb.visible = false;
//				for (var i:int = 0;i<hang;i++){
//					for (var j:int = 0;j<lie;j++){
//						if (i-th<=view&&i-th>0||th-i<=view&&th-i>0){
//							mapArr[i][tl].maskAlpha();
//						}
//						if (j-tl<=view&&j-tl>0||tl-j<=view&&tl-j>0){
//							mapArr[th][j].maskAlpha();
//						}
//					}
//				}
//			}
		}
		public function fightOver(bol:Boolean):void{
			//判断下一关
//			if (""){
//				m_level++;
//				PlayerInit.p_custom++;
//				resetBtn.visible = true;
//			}
//			
			if(bol){
				selBox.setStatus(4);
				selBox.fight = false;
			}
			//展开其他相关地图
			var th:int = selBox.tlie;
			var tl:int = selBox.thang;	
			//tb.visible = false;
			for (var i:int = 0;i<hang;i++){
				for (var j:int = 0;j<lie;j++){
					if (i-th<=view&&i-th>0||th-i<=view&&th-i>0){
						if(mapArr[i][tl].malpha==1){
							mapArr[i][tl].maskAlpha();
						}
					}
					if (j-tl<=view&&j-tl>0||tl-j<=view&&tl-j>0){
						if(mapArr[th][j].malpha==1){
							mapArr[th][j].maskAlpha();
						}
					}
				}
			}
		}
		/**
		 * 探索
		 * */
		private function explore(tb:MapBox,tp:int):void{
			PlayerInit.tili -=tp;
			var expl:Explore = new Explore();
			expl.exp(tb);
			alone.upui.Refresh();
			tb.fight = true;
			tb.maskAlpha(0);
		}
		public function set level(e:int):void{
			m_level = e;
		}
		//游戏结束
		private function gameOver():void{
			reSet();
		}
		//下一关
		private function nextCustom(e:MouseEvent = null):void{
			resetBtn.visible = false;
			reSet();
		}
		//重置
		private function reSet(e:MouseEvent = null):void{
			mapArr = [];
			if (mapSpr){
				while(mapSpr.numChildren>0){
					mapSpr.getChildAt(0).removeEventListener(MouseEvent.CLICK,tcHandler);
					mapSpr.removeChildAt(0);
				}
			}
			this.init();
		}
	}
}