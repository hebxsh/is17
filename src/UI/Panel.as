package UI
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import data.GameInit; 

	public class Panel extends Sprite
	{
		/**被滚动对象*/
		private var bgSpr:Sprite;
		/**显示宽度*/
		private var _width:int;
		/**显示高度*/
		private var _height:int;
		/**判断鼠标按下*/
		private var _pan:Boolean = false;
		private var startY:int = 0;
		public function Panel(width:int = 0,height:int = 0,bgcolor:int = 0x000000)
		{
			super();
			if (width > 0 && height > 0)
			{
				_width = width;
				_height = height;
				render();
			}
		}
		public function render():void
		{			
			bgSpr = new Sprite();
			this.addChild(bgSpr);
			this.graphics.beginFill(0x000000,.1);
			this.graphics.drawRect(0,-20,_width,_height+40);
			this.addEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			this.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			var maskSpr:Sprite = new Sprite;
			maskSpr.graphics.beginFill(0xffffff);
			maskSpr.graphics.drawRect(0,0,_width,_height);
			this.addChild(maskSpr);
			bgSpr.mask = maskSpr;
			GameInit.m_stage.addEventListener(MouseEvent.MOUSE_UP,stopHandler);
		}
		private function downHandler(e:MouseEvent):void{
			_pan = true;
			startY = this.mouseY; 
		}
		private function moveHandler(e:MouseEvent):void{
			if(_pan){
				bgSpr.x = 0;
				bgSpr.y = bgSpr.y + (this.mouseY - startY);
				startY = this.mouseY;
				if(bgSpr.height+bgSpr.y-_height<0)bgSpr.y = _height - bgSpr.height ;
				if(bgSpr.y > 0 )bgSpr.y = 0;
			}
		}

		private function stopHandler(e:MouseEvent):void{
			_pan = false;
		}
		/**
		 * 添加内容
		 * @param obj
		 */
		public function addContent(obj:DisplayObject,spacing:int = 0):void
		{
			if (bgSpr.height>0)
			obj.y = bgSpr.height+spacing;
			else obj.y = bgSpr.height;
			bgSpr.addChild(obj);
		}
		
		/**
		 * 移除内容
		 * @param obj
		 */
		public function removeContent(obj:DisplayObject):void
		{
			bgSpr.removeChild(obj);
			this.graphics.clear();
		}
		/**
		 * 移除所有内容
		 * @param index		从哪里索引开始
		 * @param end		到哪里结束
		 */
		public function removeContents():void
		{
			while (bgSpr.numChildren>0)bgSpr.removeChildAt(0);
			bgSpr.y = 0;
		}
		/**
		 * 将滚动条拖到最后
		 */
		public function lastContents():void
		{
			if (bgSpr.height>_height){
				bgSpr.y = _height - bgSpr.height;
			}
		}
	}
}