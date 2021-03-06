package UI
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import data.ColorInit;

	public class MyText extends Sprite
	{
		private var text:TextField;
		private var m_width:int;
		private var m_height:int;
		public function MyText(txt:String = "",size:int = 20,color:int = ColorInit.textColor,algin:String = "left",width:int=100)
		{
			var my_fmt:TextFormat = new TextFormat();//常用样式
			my_fmt.size = size;
			my_fmt.font = "微软雅黑";
			my_fmt.color = color;
		
			if(!text)text = new TextField();
			text.mouseEnabled =false;
			text.width = width;			
			//text.border = true;
			text.defaultTextFormat = my_fmt;
			switch(algin){
				case "left":
					text.autoSize = TextFieldAutoSize.LEFT;
					break;
				case "center":					
					text.autoSize = TextFieldAutoSize.CENTER;
					break;
				case "right":					
					text.autoSize = TextFieldAutoSize.RIGHT;
					break;
			}
			if (width>200){
				text.wordWrap = true;
			}
			text.htmlText = txt;
			this.addChild(text);
			//return text;
		}
		public function get twidth():int{
			return m_width;
		}
		public function get theight():int{
			return m_height;
		}
		public function setText(txt:String):void{
			text.htmlText = txt;
		}
		public function getText():String{
			return text.text;
		}
		public function setAlgin(txt:String):void{
			text.autoSize = txt;
		}
	}
}