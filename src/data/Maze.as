package data 
{
	public class Maze 
	{
		private var thewidth:int;
		private var theheight:int;
		public const RIGHT:uint=2;
		public const LEFT:uint=3;
		public const DOWN:uint=4;
		public const UP:uint = 5;
		
		private var mazeArr:Vector.<Object> = new Vector.<Object>;
		
		public function Maze(_thewidth:int = 11,_theheight:int = 11) 
		{
			thewidth = _thewidth;
			theheight = _theheight;
		}
		public function getmaze():Vector.<Object> {
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
			var vx:int;
			var vy:int;
			xStack.push(1);
			yStack.push(1);
			
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
			setPB(2);
			setPB(3);
			return mazeArr;
		}
		//写入玩家宝箱出口等
		private function setPB(enum:int):void {
			var pb:Boolean = true;
			while(pb){
				var tx:int = Math.random()*mazeArr.length;
				var ty:int = Math.random()*mazeArr[0].length;
				if (mazeArr[tx][ty]==1){
					mazeArr[tx][ty] = enum;
					pb = false;
				}
			}
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