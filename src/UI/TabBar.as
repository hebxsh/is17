package UI
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class TabBar extends Sprite
	{
		private var barArr:Array = new Array;
		private var m_index:int = 0;
		public function TabBar(arr:Array)
		{
			for (var i:int = 0;i<arr.length;i++){
				var tbtn:MyButton = new MyButton(arr[i],0xccaa77,70);
				tbtn.x = i*(tbtn.width+5);
				tbtn.name = i.toString();
				tbtn.addEventListener(MouseEvent.CLICK,clickHandler);
				if (i==0)tbtn.select(true);
				this.addChild(tbtn);
				barArr.push(tbtn);
			}
		}
		private function clickHandler(e:MouseEvent):void{
			var ti:int = int(e.currentTarget.name);
			m_index = ti;
			downBar(ti);
		}
		private function downBar(ti:int):void{
			for (var i:int = 0;i<barArr.length;i++){
				if (i==ti)barArr[i].select(true);
				else barArr[i].select(false);
			}
		}
		public function getIndex():int{
			return m_index;
		}
		public function setIndex(ti:int):void{
			downBar(ti);
		}
	}
}