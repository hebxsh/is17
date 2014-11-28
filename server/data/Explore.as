package data
{
	import UI.MapBox;
	import UI.ToolTip;

	public class Explore
	{
		public function Explore()
		{
		}
		public function exp(tb:MapBox):void{
			tips(tb.type);
		}
		private function tips(etype:int):void{
			var tooltip:ToolTip = new ToolTip();
			if (etype==0){
				tooltip.show("远方传来阵阵野兽的嘶吼声。");
			}else if (etype==1){
				tooltip.show("这里好安静，怕是有个强大的阵法陷阱。");
			}else if (etype==2){
				tooltip.show("这里地形复杂，看不到道路。");
			}else{
				tooltip.show("这里看起来没什么危险。");
			}			
		}
	}
}