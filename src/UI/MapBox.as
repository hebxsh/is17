package UI
{	
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	
	import data.GameInit;

	public class MapBox extends Sprite
	{
		private var levelArr:Array = [0xffffff,0x00DB00,0x0000E3,0x5E005E,0xF9F900];
		private var groundArr:Array = [["冰",0xffffff],["山",0x708090],["林",0x228B22],["路",0xCDa53F],["沙",0xff8dc],["水",0x00bfff],["土",0xCD553F],["穴",0x333333],["草",0x7cf000]];
		private var typeArr:Array = [["未","#ffffff"],["易","#7cf000"],["中","#eeee00"],["险","#ee0000"],["已","#777777"]];
		private var leiArr:Array = [["空","#ffffff"],["怪","#ff0000"],["静","#228B22"],["阵","#CDa53F"],["陷","#CD553F"],["宝","#F9F920"]];
		public var isuse:Boolean = true;
		public var showNum:int = 0;
		public var thang:int;
		public var tlie:int;
		private var maskHui:Sprite;
		private var m_fight:Boolean = false;
		private var m_level:int = 0;
		private var m_type:int = 0;
		private var m_ground:int = 0;
		private var m_lei:int = 0;
		private var m_alpha:Number = 1;
		private const tx:int = 2;
		private const ty:int = 2;
		private const tw:int = 84;
		private const th:int = 84;
		private var typetxt:MyText;
		private var leitxt:MyText;
		public function MapBox(type:int,leixing:int,gid:int,num:int)
		{
			showNum = num;
			createBox(type,leixing,gid,num);
		}
		private function createBox(type:int,leixing:int,gid:int,level:int):void{
			m_level = level;
			m_ground = gid;
			m_type = type;
			m_lei = leixing;
			
			this.graphics.beginFill(groundArr[gid][1]);
			this.graphics.lineStyle(4,levelArr[level]);
			this.graphics.drawRect(tx,ty,GameInit.m_mapwidth,GameInit.m_mapheight);
			this.graphics.endFill();
			
			var text:MyText = new MyText(groundArr[gid][0],20,0x000000,"center",GameInit.m_mapwidth);
			text.y = GameInit.m_mapheight - 35;
			this.addChild(text);
			
			typetxt = new MyText(("<font color='"+typeArr[m_type][1]+"'>"+typeArr[m_type][0]+"</font>"),20,0x000000,"center",50);
			//typetxt.x = GameInit.m_mapheight - 35;
			typetxt.filters = [new GlowFilter(0xffffff, 1.0, 2.0, 2.0, 10, 1, false, false)];
			this.addChild(typetxt);
			
			leitxt = new MyText(("<font color='"+leiArr[m_lei][1]+"'>"+leiArr[m_lei][0]+"</font>"),20,0x000000,"center",50);
			leitxt.x = 40;
			//leitxt.filters = [new GlowFilter(0xffffff, 1.0, 2.0, 2.0, 10, 1, false, false)];
			this.addChild(leitxt);
			
			maskHui = new Sprite();
			maskHui.graphics.beginFill(0x000000);
			maskHui.graphics.drawRect(0,0,GameInit.m_mapwidth+tx*2,GameInit.m_mapheight+ty*2);
			this.addChild(maskHui);
		}
		public function setStatus(typ:int):void{
			typetxt.setText("<font color='"+typeArr[typ][1]+"'>"+typeArr[typ][0]+"</font>");
			m_type = typ;
		}
		public function maskShow(show:Boolean = false):void{
			maskHui.visible = show;
			//m_fight = true;
		}
		public function maskAlpha(alpha:Number = .6):void{
			maskHui.alpha = alpha;
			m_alpha = alpha;
		}
		public function get malpha():Number{
			return m_alpha ;
		}
		public function get fight():Boolean{
			return m_fight;
		}
		public function set fight(tb:Boolean):void{
			m_fight = tb;
		}
		public function get level():int{
			return m_level;
		}
		public function get ground():int{
			return m_ground;
		}
		/**
		 * 地图类型
		 * */
		public function get type():int{
			return m_lei;
		}
		/**
		 * 地图状态
		 * */
		public function get status():int{
			return m_type;
		}
		public function get getalpha():Number{
			return m_alpha;
		}
	}
}