package UI
{
	import flash.display.Sprite;
	import data.ColorInit;

	public class MyButton extends Sprite
	{
		private var m_obj:Object;
		private var m_mobj:Object;
		public function MyButton(label:String,color:uint = ColorInit.btnBgColor,width:int = 50,height:int = 50)
		{
			this.graphics.beginFill(color);
			this.graphics.drawRect(0,0,width,height);	

			var tf:MyText = new MyText(label,20,ColorInit.btnTxtColor,"center",width);
			tf.y = 10;
			this.addChild(tf);
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