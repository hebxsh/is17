package UI
{	
	import flash.display.Sprite;

	public class MapBox extends Sprite
	{
		private var levelArr:Array = [0xffffff,0x00DB00,0x0000E3,0x5E005E,0xF9F900];
		private var groundArr:Array = [["泽",0x00CACA],["冰",0xFBFBFF],["山",0x3D7878],["沙",0xFFF0AC],["林",0x009100],["瘴",0x005757]];
		public var isuse:Boolean = true;
		public var showNum:int = 0;
		public var thang:int;
		public var tlie:int;
		private var maskHui:Sprite;
		private var m_fight:Boolean = false;
		private var m_level:int = 0;
		private var m_type:int = 0;
		private var m_ground:int = 0;
		private var m_alpha:Number;
		private const tx:int = 2;
		private const ty:int = 2;
		private const tw:int = 84;
		private const th:int = 84;
		public function MapBox(type:int,gid:int,num:int)
		{
			showNum = num;
			createBox(type,gid,num);
		}
		private function createBox(type:int,gid:int,level:int):void{
			m_level = level;
			m_ground = gid;
			m_type = type;
			
			this.graphics.beginFill(groundArr[gid][1]);
			this.graphics.lineStyle(4,levelArr[level]);
			this.graphics.drawRect(tx,ty,tw,th);
			this.graphics.endFill();
			
			var text:MyText = new MyText(groundArr[gid][0],20,0x000000,"center",tw);
			text.y = th - 35;
			this.addChild(text);
			
			maskHui = new Sprite();
			maskHui.graphics.beginFill(0x000000);
			maskHui.graphics.drawRect(0,0,tw+tx*2,th+ty*2);
			this.addChild(maskHui);
		}
		public function maskShow(show:Boolean = false):void{
			maskHui.visible = show;
			m_fight = true;
		}
		public function maskAlpha(alpha:Number = .6):void{
			maskHui.alpha = alpha;
			m_alpha = alpha;
		}
		public function get fight():Boolean{
			return m_fight;
		}
		public function get level():int{
			return m_level;
		}
		public function get ground():int{
			return m_ground;
		}
		public function get type():int{
			return m_type;
		}
		public function get getalpha():Number{
			return m_alpha;
		}
	}
}