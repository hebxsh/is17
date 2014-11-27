package UI
{
	import flash.display.Sprite;
	
	import data.ColorInit;

	public class CodeImageIcon extends Sprite
	{
		private var arrjian:Array = [[4,4],[4,11],[22,27],[17,32],[18,33],[21,33],[25,29],[32,36],[36,32],[29,25],[33,21],[33,18],[32,17],[27,22],[11,4],[4,4]];
		private var arrjia:Array = [[4,16],[10,19],[14,12],[12,25],[8,33],[17,36],[20,31],[24,36],[33,33],[28,22],[27,13],[32,20],[38,14],[28,4],[23,6],[18,6],[12,4]];
		private var arrzhui:Array = [[25,15],[23,7],[32,4],[36,12],[25,15]];
		private var arrjue:Array = [[4,10],[8,7],[12,5],[16,4],[20,5],[24,7],[28,8],[32,7],[36,6]];
		
		/**
		 * 0:剑***1:甲***2:坠***3:书***4:诀***
		 * */
		public function CodeImageIcon()
		{
		}
		public function createIcon(id:int):void{
			switch(id){
				case 0:
					stjian();
					break;
				case 1:
					stjia();
					break;
				case 2:
					stzhui();
					break;
				case 3:
					stshu();
					break;
				case 4:
					stjue();
					break;
			}
		}
		private function stjian():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(1,ColorInit.iconLineColor);
			this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.moveTo(arrjian[0][0],arrjian[0][1]);
			for (var i:int = 1;i<arrjian.length;i++){
				this.graphics.lineTo(arrjian[i][0],arrjian[i][1]);
			}
		}
		private function stjia():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(1,ColorInit.iconLineColor);
			this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.moveTo(arrjia[0][0],arrjia[0][1]);
			for (var i:int = 1;i<arrjia.length;i++){
				this.graphics.lineTo(arrjia[i][0],arrjia[i][1]);
			}
		}
		private function stzhui():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(2,ColorInit.iconLineColor);
			//this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.moveTo(arrzhui[0][0],arrzhui[0][1]);
			this.graphics.beginFill(ColorInit.iconBgColor);
			for (var i:int = 1;i<arrzhui.length-1;i++){
				var xc:Number = (arrzhui[i][0] + arrzhui[i + 1][0]) / 2;
				var yc:Number = (arrzhui[i][1] + arrzhui[i + 1][1]) / 2;
				this.graphics.curveTo(arrzhui[i][0],arrzhui[i][1],xc,yc);
			}
			this.graphics.curveTo(arrzhui[i][0],arrzhui[i][1],xc,yc);
			this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.drawCircle(23,17,1);
			this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.drawCircle(16,25,8);
		}
		private function stshu():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(1,ColorInit.iconLineColor);
			this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.drawRect(8,4,24,32);
			this.graphics.lineStyle(1,ColorInit.iconBgColor);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(10,6,6,20);
			this.graphics.lineStyle(1,ColorInit.iconBgColor);
			this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.drawRect(30,3,3,8);
			this.graphics.drawRect(30,11,3,9);
			this.graphics.drawRect(30,20,3,9);
			this.graphics.drawRect(30,29,3,8);
		}
		private function stjue():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(1,ColorInit.iconBgColor);	
			this.graphics.beginFill(ColorInit.iconLineColor);
			for (var i:int = 0;i<arrjue.length-1;i++){
				this.graphics.moveTo(arrjue[i][0],arrjue[i][1]);
				this.graphics.lineTo(arrjue[i][0],arrjue[i][1]+24);
				this.graphics.lineTo(arrjue[i+1][0],arrjue[i+1][1]+24);
				this.graphics.lineTo(arrjue[i+1][0],arrjue[i+1][1]);
				this.graphics.lineTo(arrjue[i][0],arrjue[i][1]);
			}
			for (var j:int = 0;j<arrjue.length-1;j++){				
				this.graphics.moveTo(arrjue[j][0],arrjue[j][1]+4);
				this.graphics.lineTo(arrjue[j+1][0],arrjue[j+1][1]+4);
				this.graphics.moveTo(arrjue[j][0],arrjue[j][1]+20);
				this.graphics.lineTo(arrjue[j+1][0],arrjue[j+1][1]+20);
			}
		}
	}
}