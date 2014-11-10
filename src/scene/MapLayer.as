package scene
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
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
	
	import event.CommEvent;

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
					var tbox:MapBox = new MapBox(temArr[i][j].type,temArr[i][j].ground,temArr[i][j].level);
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
				if (temArr[tx][ty].level == 0){
					mapArr[tx][ty].maskAlpha();	
					rp = false;
				}
			}
			mapSpr.x = int((GameInit.m_stage.stageWidth-mapSpr.width)/2);
			mapSpr.y = int((GameInit.m_stage.stageHeight-mapSpr.height)/2);
		}
		//点击事件
		private function tcHandler(e:MouseEvent):void{
			var tb:MapBox = e.currentTarget as MapBox;
			if (tb.fight){
				fighting(tb,tb.type,tb.level);				
			}else{				
				if (tb.getalpha > 0){
					explore(tb,1);					
				}else{
					//无反应
				}
			}
		}
		//战斗
		private function fighting(tb:MapBox,etyp:int,elev:int):void{
			var fight:Fight = new Fight();
			fight.fighting(etyp,elev);
			//PlayerInit.p_hp-=(elev+1);			
			alone.upui.Refresh();
			if (PlayerInit.p_status == 1){
				var e:CommEvent = new CommEvent(CommEvent.GAMEOVER);
				dispatchEvent(e);
				this.gameOver();
			}else{
				
				if (elev == 4){
					m_level++;
					PlayerInit.p_custom++;
					resetBtn.visible = true;
				}
				//展开其他相关地图
				var th:int = tb.tlie;
				var tl:int = tb.thang;	
				tb.visible = false;
				for (var i:int = 0;i<hang;i++){
					for (var j:int = 0;j<lie;j++){
						if (i-th<=view&&i-th>0||th-i<=view&&th-i>0){
							mapArr[i][tl].maskAlpha();
						}
						if (j-tl<=view&&j-tl>0||tl-j<=view&&tl-j>0){
							mapArr[th][j].maskAlpha();
						}
					}
				}
			}
		}
		//探索
		private function explore(tb:MapBox,tp:int):void{
			PlayerInit.tili -=tp;
			var expl:Explore = new Explore();
			expl.exp(tb);
			alone.upui.Refresh();
			tb.maskShow();
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