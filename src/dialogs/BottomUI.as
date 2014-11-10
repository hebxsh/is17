package dialogs
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import UI.MyButton;
	
	import data.ColorInit;

	public class BottomUI extends Sprite
	{	
		private var player:MyButton;
		private var bag:MyButton;
		private var custom:MyButton;
		private var xiulian:MyButton;
		public function BottomUI()
		{
			init();
		}
		private function init():void{
			this.graphics.beginFill(ColorInit.uiUpColor);
			this.graphics.drawRect(0,0,480,50);
			
			if (!player)
				player = new MyButton("人物");
			player.addEventListener(MouseEvent.CLICK,pcHandler);
			this.addChild(player);
			
			if (!bag)
				bag = new MyButton("背包");
			bag.x = player.x + player.width +5;
			bag.addEventListener(MouseEvent.CLICK,bcHandler);
			this.addChild(bag);
			
			if (!custom)
				custom = new MyButton("关卡");
			custom.x = bag.x+bag.width+5;
			custom.addEventListener(MouseEvent.CLICK,ccHandler);
			this.addChild(custom);
			
			if (!xiulian)
				xiulian = new MyButton("修炼");
			xiulian.x = custom.x+custom.width+5;
			xiulian.addEventListener(MouseEvent.CLICK,xlHandler);
			this.addChild(xiulian);
		}
		private function pcHandler(e:MouseEvent):void{
			alone.playerdialog.theOpen();
			alone.playerdialog.Refresh();			
		}
		private function bcHandler(e:MouseEvent):void{
			alone.bagdialog.setTitle();
			//alone.bagdialog.Refresh();			
		}
		private function ccHandler(e:MouseEvent):void{
			alone.customdialog.theOpen();
			alone.customdialog.Refresh();			
		}
		private function xlHandler(e:MouseEvent):void{
			alone.xiuliandialog.theOpen();
			alone.xiuliandialog.Refresh();
		}
	}
}