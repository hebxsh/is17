package UI
{
	import flash.display.Sprite;
	
	import data.ColorInit;

	public class MyButton extends Sprite
	{
		private var m_obj:Object;
		private var m_mobj:Object;
		private var m_tf:MyText
		public function MyButton(label:String,color:uint = ColorInit.btnBgColor,width:int = 50,height:int = 50)
		{
			this.graphics.beginFill(color);
			this.graphics.drawRect(0,0,width,height);	

			m_tf = new MyText(label,20,ColorInit.btnTxtColor,"center",width);
			m_tf.y = 10;
			this.addChild(m_tf);
		}

		public function select(sel:Boolean = false):void{
			if (sel){
				this.graphics.beginFill(ColorInit.btnSelColor);
				this.graphics.drawRect(0,0,width,height);	
			}else{
				this.graphics.beginFill(ColorInit.btnBgColor);
				this.graphics.drawRect(0,0,width,height);
			}
		}
		public function setTxt(txt:String):void{
			m_tf.setText(txt);
		}
		public function get obj():Object{
			return m_obj;
		}
		public function set obj(ob:Object):void{
			m_obj = ob;
		}
		
		public function get mobj():Object{
			return m_mobj;
		}
		public function set mobj(ob:Object):void{
			m_mobj = ob;
		}
	}
}