package dialogs
{
	import flash.display.Sprite;
	
	import UI.MyText;
	import data.GameInit;
	public class DialogObject extends Sprite
	{
		private var text:MyText;
		public function DialogObject()
		{
			this.theDest();
		}
		public function theTitle(txt:String ,color:int = 0xff0000):void{			
			if(!text)text = new MyText(txt,36,0xff0000,"center");
			text.x = (GameInit.m_stage.stageWidth-text.width)/2;
			text.y = 5;
			text.setText(txt);
			this.addChild(text);
		}
		public function theOpen():void{
			this.visible = true;
		}
		public function theDest():void{
			//if(parent)
			//	parent.removeChild(this);
			this.visible = false;
		}
	}
}