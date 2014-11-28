package data 
{
	import flash.utils.getTimer;
	public class map 
	{
		private var thewidth:int;
		private var theheight:int;
		public const RIGHT:uint=2;
		public const LEFT:uint=3;
		public const DOWN:uint=4;
		public const UP:uint = 5;
		public var boxX:int ;
		public var boxY:int ;
		
		private var mazeArr:Vector.<Object> = new Vector.<Object>;
		private var mapBgArr:Vector.<Object> = new Vector.<Object>;
		private var mapLayArr:Vector.<Object> = new Vector.<Object>;
		private var mapArr:Array = [mapBgArr,mapLayArr];
		
		public function map(_thewidth:int = 11,_theheight:int = 11) 
		{
			thewidth = _thewidth;
			theheight = _theheight;
		}
		
		public function getmap():Array {
			for (var i:int = 0; i < thewidth; i++ ) {
				var bgtheheightArr:Vector.<int> = new Vector.<int>;
				var laytheheightArr:Vector.<int> = new Vector.<int>;
				for (var j:int = 0; j < theheight; j++ ) {
					bgtheheightArr.push(0);
					laytheheightArr.push(0);
				}
				mapBgArr.push(bgtheheightArr);
				mapLayArr.push(laytheheightArr);
			}
			
			addHill();
			addTree();
			addXiang(10);
			return mapArr;
		}
		//添加山水平地
		private function addHill(tw:int = 8,th:int = 6):void{
			var fScl:Number = 0.005;
			var z:Number = .005*getTimer();
			for (var i:int=0;i<thewidth;i++) {
				for (var j:int=0;j<theheight;j++) {					
					var g:uint = Math.round(255*Simplex.noise(fScl*i,fScl*j,fScl*z));
					mapBgArr[i][j] = g;	
				}
			}
		}
		private function addTree(tw:int = 8,th:int = 6):void{
			var fScl:Number = 0.01;
			var z:Number = .01*getTimer();
			for (var i:int=0;i<thewidth;i++) {
				for (var j:int=0;j<theheight;j++) {					
					var g:uint = Math.round(2*Simplex.noise(fScl*i,fScl*j,fScl*z))+3;
					//if (g==3)
						//mapBgArr[i][j] = g;	
				}
		}
		}
		private function addXiang(num:int = 0 ):void{
			var i:int = 0;
			while (i<num) {
				var tmw:int = thewidth*Math.random();
				var tmh:int = theheight*Math.random();
				if (mapBgArr[tmw][tmh] >0&&Math.random()>0.9){
					mapLayArr[tmw][tmh] = 8;
					i++;
				}
				
			}
		}
		/*
		 ***********************************************************************************
		 * 以下是生成迷宫地图的脚本
		*/
		public function getmaze1():Vector.<Object> {
			mazeArr = createmaze();
			var temArr:Vector.<Object> = new Vector.<Object>;
			for (var i:int = 0; i < theheight*2-1; i++ ) {
				var ttArr:Vector.<int> = new Vector.<int>;
				for (var j:int = 0; j < thewidth * 2 - 1; j++ ) {
					if (i % 2 == 0 && j % 2 == 0) {
						ttArr.push(mazeArr[i/2][j/2]);
					}else if (i % 2 == 1 && j % 2 == 0) {
						if((mazeArr[int((i-1)/2)][int(j/2)])==0&&(mazeArr[int((i-1)/2)+1][int(j/2)])==0){
							ttArr.push(0);
						}else {
							ttArr.push(1);
						}
					}else if (i % 2 == 0 && j % 2 == 1) {
						if((mazeArr[int(i/2)][int((j-1)/2)])==0&&(mazeArr[int(i/2)][int((j-1)/2)+1])==0){
							ttArr.push(0);
						}else {
							ttArr.push(1);
						}
					}else {
						ttArr.push(1);
					}
				}
				temArr.push(ttArr);
			}

			return temArr;
		}	
		public function createmaze():Vector.<Object> {			
			
			for (var i:int = 0; i < theheight; i++ ) {
				var mazetheheightArr:Vector.<int> = new Vector.<int>;
				for (var j:int = 0; j < thewidth; j++ ) {
					mazetheheightArr.push(0);
				}
				mazeArr.push(mazetheheightArr);
			}
			var xStack:Vector.<int> = new Vector.<int>;
			var yStack:Vector.<int> = new Vector.<int>;
			var sides:Vector.<int> = new Vector.<int>;
			var vx:int = 1 + int(Math.random() * ( theheight/ 2 - 1)) * 2;
			var vy:int = 1 + int(Math.random() * (thewidth / 2 - 1)) * 2;
			//saveObj.saveData("startX", vx);
			//saveObj.saveData("startY", vy);
			xStack.push(vx);
			yStack.push(vy);
			
			while (xStack.length > 0) {
				vx=xStack[xStack.length-1];
				vy=yStack[yStack.length-1];
				sides.length=0;
				
				//判断得到的方向是否可行
				//为什么要加2这样在不可取的地方会生成空白处
				if (getTile(vx + 2, vy)) {
					sides.push(RIGHT);
				}
				if (getTile(vx - 2, vy)) {
					sides.push(LEFT);
				}
				if (getTile(vx,vy+2)) {
					sides.push(DOWN);
				}
				if (getTile(vx,vy-2)) {
					sides.push(UP);
				}
				//拥有了一个路径的话
				if (sides.length>0) {
					//随机得到一个可取的方向
					var side:int=sides[int(Math.random()*sides.length)];
					//向可取的方向填充两个空格
					//将记录写入数组约等于写入了一组坐标
					switch (side) {
						case RIGHT :
							setTile(vx + 1, vy, false);
							setTile(vx + 2, vy, false);
							xStack.push(vx + 2);
							yStack.push(vy);
							break;
						case LEFT :
							setTile(vx - 1, vy, false);
							setTile(vx - 2, vy, false);
							xStack.push(vx - 2);
							yStack.push(vy);
							break;
						case DOWN :
							setTile(vx, vy + 1, false);
							setTile(vx, vy + 2, false);
							xStack.push(vx);
							yStack.push(vy + 2);
							break;
						case UP :
							setTile(vx, vy - 1, false);
							setTile(vx, vy - 2, false);
							xStack.push(vx);
							yStack.push(vy - 2);
							break;
					}
				}
				//如果四方向皆为死路，清除这一组。				
				else {
					xStack.pop();
					yStack.pop();
				}
			}
			return mazeArr;
		}
		//判断格子是否已经遍历到
		private function getTile(x:int, y:int):Boolean {
			if (x < 0 || y < 0 || x >= theheight || y >= thewidth) {
				return false;
			}
			return mazeArr[x][y]<1;
		}
		//写入格子
		private function setTile(x:int, y:int, solid:Boolean):void {
			mazeArr[x][y] = 1;
		}
	}
}