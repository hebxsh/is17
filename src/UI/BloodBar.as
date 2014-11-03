package UI
{
	import flash.display.Sprite;

	public class BloodBar extends Sprite
	{
		private var m_maxNum:int = 0;
		private var m_mowNum:int = 0;
		private var m_bgSpr:Sprite ;
		private var m_upSpr:Sprite ;
		private var m_width:int = 0;
		private var m_height:int = 0;
		public function BloodBar(maxNum:int,ewidth:int = 100,eheight:int = 5)
		{
			m_maxNum = maxNum;
			m_bgSpr = new Sprite;
			m_upSpr = new Sprite;
			m_width = ewidth;
			m_height = eheight;
			m_bgSpr.graphics.beginFill(0x999999);
			m_bgSpr.graphics.drawRect(0,0,ewidth,eheight);
			m_upSpr.graphics.beginFill(0xff0000);
			m_upSpr.graphics.drawRect(0,0,ewidth,eheight);
			this.addChild(m_bgSpr);
			this.addChild(m_upSpr);
		}
		public function ReNum(now):void{
			m_upSpr.graphics.clear();
			m_upSpr.graphics.beginFill(0xff0000);
			var th:int = now/m_maxNum*m_width;
			if(th<0)th=0;
			m_upSpr.graphics.drawRect(0,0,th,m_height);
		}
	}
}