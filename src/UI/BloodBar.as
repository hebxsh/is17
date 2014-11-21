package UI
{
	import flash.display.Sprite;

	public class BloodBar extends Sprite
	{
		private var m_maxNum:int = 0;
		private var m_mowNum:int = 0;
		private var m_bgSpr:Sprite ;
		private var m_upSpr:Sprite ;
		private var m_numtxt:MyText ;
		private var m_width:int = 0;
		private var m_height:int = 0;
		private var m_color:int = 0xff0000;
		public function BloodBar(maxNum:int,ewidth:int = 100,eheight:int = 5,numShow:Boolean = false,col:int = 0xff0000)
		{
			m_maxNum = maxNum;
			m_bgSpr = new Sprite;
			m_upSpr = new Sprite;
			m_width = ewidth;
			m_height = eheight;
			m_color = col;
			m_bgSpr.graphics.beginFill(0x999999);
			m_bgSpr.graphics.drawRect(0,0,ewidth,eheight);
			m_upSpr.graphics.beginFill(m_color);
			m_upSpr.graphics.drawRect(0,0,ewidth,eheight);
			this.addChild(m_bgSpr);
			this.addChild(m_upSpr);
			if (numShow){
				m_numtxt = new MyText("",12,0xffffff,"center",200);
				m_numtxt.x = (ewidth - 200)/2;
				m_numtxt.y = -5;
				this.addChild(m_numtxt);
			}
		}
		//重设最大值。
		public function ReMax(max:int):void{
			m_maxNum = max;
		}
		//刷新
		public function ReNum(now):void{
			m_upSpr.graphics.clear();
			m_upSpr.graphics.beginFill(m_color);
			var th:int = now/m_maxNum*m_width;
			if(m_numtxt)m_numtxt.setText(now+"/"+m_maxNum);
			if(th<0)th=0;
			m_upSpr.graphics.drawRect(0,0,th,m_height);
		}
	}
}