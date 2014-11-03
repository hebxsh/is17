package UI
{	
	import flash.display.Sprite;
	
	public class MazeBox extends Sprite
	{
		private var maskHui:Sprite;
		private var m_alpha:Number;
		private var m_px:int = 0;
		private var m_py:int = 0;
		private const tw:int = 80;
		private const th:int = 80;
		public function MazeBox()
		{
			createBox();
		}
		private function createBox():void{
			this.graphics.beginFill(0x949449);
			//this.graphics.lineStyle(4,levelArr[level]);
			this.graphics.drawRect(0,0,tw,th);
			this.graphics.endFill();
			
			maskHui = new Sprite();
			maskHui.graphics.beginFill(0x000000);
			maskHui.graphics.drawRect(0,0,tw,th);
			this.addChild(maskHui);
		}
		public function maskShow(show:Boolean = false):void{
			maskHui.visible = show;

		}
		public function maskAlpha(alpha:Number = .6):void{
			maskHui.alpha = alpha;
			m_alpha = alpha;
		}

		public function set px(e:int):void{
			m_px = e;
		}
		public function get px():int{
			return m_px;
		}
		public function set py(e:int):void{
			m_py = e;
		}
		public function get py():int{
			return m_py;
		}
		public function get getalpha():Number{
			return m_alpha;
		}
	}
}