package UI
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import data.GameInit;
	
	import dialogs.ItemShow;

	public class EquipBox extends Sprite
	{		
		private var m_level:int = 0;
		private const tx:int = 2;
		private const ty:int = 2;
		private var m_type:int = 0;
		private var m_name:String = "";
		private var m_data:Object;
		private var m_id:int;
		//是否显示卸下
		private var m_xs:int;
		public function EquipBox(tdata:Object,tid:int = 0)
		{
			//showNum = num;
			m_data = tdata;
			m_xs = tid;
			m_type = tdata.type;
			m_id = tdata.id;
			createBox(tdata.level,tdata.name);
		}
		//生成装备显示
		private var xiux:int = 0;
		private function createBox(level:int,name:String):void{
			m_level = level;
			m_name = name;
			
			this.graphics.lineStyle(4,GameInit.getColor(level));
			this.graphics.beginFill(0xaaaacc);
			this.graphics.drawRect(tx,ty,GameInit.m_equidwidth,GameInit.m_equidheight);
			this.graphics.endFill();
			
			if (m_id<20000||m_id>40000){
			var ig:CodeImageIcon = new CodeImageIcon();
				ig.x = 4;
				ig.y = 4;
				ig.createIcon(m_type-1);
				this.addChild(ig);
				xiux = 40;
			}
			
			var text:MyText = new MyText(name,20,GameInit.getColor(level),"center");
			text.x = (GameInit.m_equidwidth + xiux- 100)>>1 ;
			text.y = (GameInit.m_equidheight - text.height)>>1;
			this.addChild(text);
			
			this.addEventListener(MouseEvent.CLICK,showHandler);
		}
		//点击事件
		private function showHandler(e:MouseEvent):void{
			var tes:ItemShow = new ItemShow(m_data,m_xs);
			alone.topSpr.addChild(tes);
		}
		public function get etype():int{
			return m_type;
		}
		public function get ename():String{
			return m_name;
		}
		public function get elevel():int{
			return m_level;
		}
		public function get edata():Object{
			return m_data;
		}
	}
}