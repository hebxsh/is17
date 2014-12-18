package UI
{
	import flash.display.Sprite;
	
	import data.ColorInit;

	public class CodeImageIcon extends Sprite
	{
		private var arrjian:Array = [[4,4],[4,11],[22,27],[17,32],[18,33],[21,33],[25,29],[32,36],[36,32],[29,25],[33,21],[33,18],[32,17],[27,22],[11,4],[4,4]];
		private var arrjia:Array = [[4,16],[10,19],[14,12],[12,25],[8,33],[17,36],[20,31],[24,36],[33,33],[28,22],[27,13],[32,20],[38,14],[28,4],[23,6],[18,6],[12,4]];
		private var arrzhui:Array = [[25,15],[23,7],[32,4],[36,12],[25,15]];
		private var arrdao:Array = [[11,3],[5,12],[23,28],[26,21]];
		private var arrjue:Array = [[4,10],[8,7],[12,5],[16,4],[20,5],[24,7],[28,8],[32,7],[36,6]];
		private var arrzhang:Array = [[34,34],[15,15],[15,9],[10,6],[5,8],[5,14],[9,15],[11,12]];
		private var arrgong:Array = [[6,36],[9,32],[10,20],[16,16],[20,10],[32,9],[36,6],[36,6]];
		private var arrdun:Array = [[6,6],[6,28],[20,34],[34,28],[34,6],[20,10]];
		private var selName:String;
		
		public function CodeImageIcon()
		{
		}
		/**
		 * 0:剑***1:衣***2:坠***3:书***4:诀***5:刀***6:扇***7:杖***8:弓***9盾***
		 * */
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
				case 5:
					stdao();
					break;
				case 6:
					stshan();
					break;
				case 7:
					stzhang();
					break;
				case 8:
					stgong();
					break;
				case 9:
					stdun();
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
		private function stdao():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(1,ColorInit.iconLineColor);
			//this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.moveTo(arrdao[0][0],arrdao[0][1]);
			this.graphics.beginFill(ColorInit.iconLineColor);
			for (var i:int = 1;i<arrdao.length-1;i++){
				var xc:Number = (arrdao[i][0] + arrdao[i + 1][0]) / 2;
				var yc:Number = (arrdao[i][1] + arrdao[i + 1][1]) / 2;
				this.graphics.curveTo(arrdao[i][0],arrdao[i][1],xc,yc);
			}
			this.graphics.lineTo(arrdao[3][0],arrdao[3][1]);
			this.graphics.lineTo(arrdao[0][0],arrdao[0][1]);
			this.graphics.moveTo(arrjian[2][0],arrjian[2][1]);
			for (var j:int = 2;j<arrjian.length-2;j++){
				this.graphics.lineTo(arrjian[j][0],arrjian[j][1]);
			}
		}		
		private function stshan():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			
			DrawSector(27,27,22,130,160,ColorInit.iconLineColor);
			DrawSector(27,27,5,130,-20,ColorInit.iconLineColor);
		}
		private function stzhang():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(3,ColorInit.iconLineColor);
			///this.graphics.moveTo(arrzhang[0][0],arrzhang[0][1]);
			for (var i:int = 1;i<arrzhang.length;i++){
				this.graphics.moveTo(arrzhang[i-1][0],arrzhang[i-1][1]);
				this.graphics.lineTo(arrzhang[i][0],arrzhang[i][1]);
			}
		}
		private function stgong():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(2,ColorInit.iconLineColor);
			//this.graphics.beginFill(ColorInit.iconLineColor);
			this.graphics.moveTo(arrgong[0][0],arrgong[0][1]);
			this.graphics.beginFill(ColorInit.iconBgColor);
			for (var i:int = 1;i<arrgong.length-1;i++){
				var xc:Number = (arrgong[i][0] + arrgong[i + 1][0]) / 2;
				var yc:Number = (arrgong[i][1] + arrgong[i + 1][1]) / 2;
				this.graphics.curveTo(arrgong[i][0],arrgong[i][1],xc,yc);
			}
			this.graphics.moveTo(arrgong[6][0],arrgong[6][1]);
		}
		private function stdun():void{
			this.graphics.beginFill(ColorInit.iconBgColor);
			this.graphics.drawRect(0,0,40,40);
			this.graphics.lineStyle(3,ColorInit.iconLineColor);
			this.graphics.beginFill(ColorInit.iconLineColor);
			
			this.graphics.moveTo(arrdun[0][0],arrdun[0][1]);
			this.graphics.curveTo(arrdun[1][0],arrdun[1][1],arrdun[2][0],arrdun[2][1]);
			this.graphics.moveTo(arrdun[2][0],arrdun[2][1]);
			this.graphics.curveTo(arrdun[3][0],arrdun[3][1],arrdun[4][0],arrdun[4][1]);
			this.graphics.moveTo(arrdun[4][0],arrdun[4][1]);
			this.graphics.lineTo(arrdun[5][0],arrdun[5][1]);
			this.graphics.lineTo(arrdun[0][0],arrdun[0][1]);
		}
		
		private function DrawSector(x:Number=200,y:Number=200,r:Number=100,angle:Number=27,startFrom:Number=270,color:Number=0xff0000):void {
			this.graphics.beginFill(color,50);

			this.graphics.lineStyle(0,ColorInit.iconLineColor);
			this.graphics.moveTo(x,y);
			angle=(Math.abs(angle)>360)?360:angle;
			var n:Number=Math.ceil(Math.abs(angle)/45);
			var angleA:Number=angle/n;
			angleA=angleA*Math.PI/180;
			startFrom=startFrom*Math.PI/180;
			this.graphics.lineTo(x+r*Math.cos(startFrom),y+r*Math.sin(startFrom));
			for (var i:int=1; i<=n; i++) {
				startFrom+=angleA;
				var angleMid:Number=startFrom-angleA/2;
				var bx:Number=x+r/Math.cos(angleA/2)*Math.cos(angleMid);
				var by:Number=y+r/Math.cos(angleA/2)*Math.sin(angleMid);
				var cx:Number=x+r*Math.cos(startFrom);
				var cy:Number=y+r*Math.sin(startFrom);
				this.graphics.curveTo(bx,by,cx,cy);
			}
			if (angle!=360) {
				this.graphics.lineTo(x,y);
			}
			this.graphics.endFill();// if you want a sector without filling color , please remove this line.
		}
	}
}