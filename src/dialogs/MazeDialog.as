package dialogs
{
	import com.astar.ANode;
	import com.astar.AStar;
	import com.astar.NodeGrid;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import UI.MazeBox;
	import UI.MyButton;
	
	import data.GameInit;
	import data.Maze;
	import data.Reward;

	public class MazeDialog extends DialogObject
	{
		private var m_level:int = 0;
		private var mazeMap:Vector.<Object>;
		private var mazeArr:Array = new Array;
		private var hang:int;
		private var lie:int;
		private var startPos:Point = new Point();
		private var endPos:Point = new Point();
		private var _path:Array = new Array();
		private var mazeSpr:Sprite;
		private var playerSpr:Sprite;
		private var leaveSpr:Sprite;
		private var shiye:int = 2;
		private var cloBtn:MyButton;
		private var _grid:NodeGrid;
		private var _cellsize:int = 80;
		private var _moveSpeed:int = 10;
		private var _index:int = 0;
		private const maphang:int = 7;
		private const maplie:int = 9;
		public function MazeDialog()
		{
		}
		override public function theOpen():void{
			alone.maplayer.visible = false;
			this.visible = true;
			//init();
			reSet();
		}
		//初始化
		private function init():void{
			var maze:Maze = new Maze(maphang+m_level*2,maplie+m_level*2);
			mazeMap = maze.getmaze();
			lie = mazeMap.length;
			hang = mazeMap[0].length;
			mazeSpr = new Sprite();
			this.addChild(mazeSpr);
			
			playerSpr = new Sprite;
			playerSpr.graphics.beginFill(0xff0000);
			playerSpr.graphics.drawCircle(0,0,30);
			
			for (var i:int = 0;i<mazeMap.length;i++){
				mazeArr.push(new Array);
				for (var j:int = 0;j<mazeMap[i].length;j++){
					var temBox:MazeBox = new MazeBox();
					temBox.x = i*temBox.width;
					temBox.y = j*temBox.height;
					temBox.px = i;
					temBox.py = j;
					/*if(mazeMap[i][j]>0){
						//temBox.maskAlpha(0);						
					}*/
					if (mazeMap[i][j]==2){
						startPos.x = i;
						startPos.y = j;
						playerSpr.x = i*temBox.width+temBox.width/2;
						playerSpr.y = j*temBox.height+temBox.height/2;
					}
					if (mazeMap[i][j]==3){
						leaveSpr = new Sprite;
						leaveSpr.graphics.beginFill(0x00cc88);
						leaveSpr.graphics.drawCircle(0,0,30);
						leaveSpr.x = i*temBox.width+temBox.width/2;
						leaveSpr.y = j*temBox.height+temBox.height/2;
						leaveSpr.visible = false;
					}
					mazeArr[i].push(temBox);
					mazeSpr.addChild(temBox);
				}
			}	
			leaveSpr.addEventListener(MouseEvent.CLICK,mcHandler);
			mazeSpr.addChild(leaveSpr);
			mazeSpr.x = GameInit.m_stage.stageWidth/2-playerSpr.x;
			mazeSpr.y = GameInit.m_stage.stageHeight/2-playerSpr.y;
			mazeSpr.addChild(playerSpr);
			//this.addEventListener(MouseEvent.MOUSE_DOWN,dragHandler);
			//GameInit.m_stage.addEventListener(MouseEvent.MOUSE_UP,stopHandler);	
			makeGrid();
			maskMap();
			cloBtn = new MyButton("退出");
			cloBtn.x = GameInit.m_stage.stageWidth - cloBtn.width;
			cloBtn.y = GameInit.m_stage.stageHeight - cloBtn.height*2;
			cloBtn.addEventListener(MouseEvent.CLICK,closeHandler);
			this.addChild(cloBtn);
		}
		/*private function dragHandler(e:MouseEvent):void{
			mazeSpr.startDrag();
		}
		private function stopHandler(e:MouseEvent):void{
			mazeSpr.stopDrag();
		}*/
		//点击移动事件
		private function mcHandler(e:MouseEvent):void{
			var pos:Point = new Point(e.currentTarget.x/_cellsize,e.currentTarget.y/_cellsize);  
			_index = 0;
			if (pos.x>=0&&pos.y>=0&&pos.x<lie&&pos.y<hang){
				startPos.x = int(playerSpr.x/_cellsize);
				startPos.y = int(playerSpr.y/_cellsize);
				onGridClick (pos);
			}
		}
		//显示地图遮挡
		private function maskMap():void{
			for (var i:int = 0;i<mazeMap.length;i++){
				for (var j:int = 0;j<mazeMap[i].length;j++){
					if(mazeMap[i][j]>0&&getDistance(i,j)){						
						mazeArr[i][j].maskAlpha(0);
						mazeArr[i][j].addEventListener(MouseEvent.CLICK,mcHandler);
					}
				}
			}
			if(getDistance(leaveSpr.x/_cellsize,leaveSpr.y/_cellsize))leaveSpr.visible = true;
		}
		//计算距离
		private function getDistance(tx:int,ty:int):Boolean{
			var dist:Number = Math.sqrt((int(playerSpr.x/_cellsize) - tx)*(int(playerSpr.x/_cellsize) - tx) + (int(playerSpr.y/_cellsize) - ty)*(int(playerSpr.y/_cellsize) - ty));
			var tb:Boolean;
			if (dist < shiye)tb = true;
			else tb = false;
			return tb;	
		}
		//设定等级
		public function set level(lev:int):void{
			m_level = lev;
		}
		
		//将地图障碍点等信息写入寻路node
		private function makeGrid():void
		{
			_grid = new NodeGrid(lie,hang);
			//放入障碍点			
			for(var i:int = 0; i < lie; i++)
			{
				for(var j:int = 0; j < hang; j++)
				{	
					if (mazeMap[i][j] == 0) {
						_grid.setWalkable(i,j,false);
					}
				}
			}
		}
		//确定初始点结束点等数据来计算路径
		private function onGridClick(endpos:Point):void
		{	
			//获取相对于背景的起始点和终点
			var startPosX:int = startPos.x;
			var startPosY:int = startPos.y;
			
			var endPosX:int = endpos.x;
			var endPosY:int = endpos.y;	
			
			//根据地图变化确定正确的起始点跟结束点			
			/**/var startNode:ANode = _grid.getNode(startPosX, startPosY);	
			var endNode:ANode = _grid.getNode(endPosX, endPosY);
			
			if( endNode.walkable == false )
			{
				var replacer:ANode = _grid.findReplacer(startNode, endNode);
				if( replacer )
				{
					endPosX = replacer.x;
					endPosY = replacer.y;
				}else{
					/*_path = [_grid.getNode(endPosX, endPosY)];
					_index = 0;
					addEventListener(Event.ENTER_FRAME, onEnterFrame);*/
				}
			}
			_grid.setStartNode(startPosX, startPosY);
			_grid.setEndNode(endPosX, endPosY);
			
			//trace (startPosX+"**"+startPosY+"**"+endPosX+"**"+endPosY);
			findPath();
			
		}
		// 寻找路径
		public function findPath():void
		{
			var astar:AStar = new AStar();
			if (astar.findPath(_grid))
			{
				//startPos = endpos;
				//得到平滑路径
				astar.floyd();
				//在路径中去掉起点节点，避免玩家对象走回头路
				astar.floydPath.shift();
				
				//这个是路径
				_path = astar.floydPath;
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		//移动帧事件
		private function onEnterFrame(event:Event):void
		{				
			maskMap();
			var _Point:Point = new Point(int(playerSpr.x/_cellsize),int(playerSpr.y/_cellsize));
			if (mazeMap[_Point.x][_Point.y] == 3){
				closeHandler();
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			//玩家到达目的地
			if (_path.length == 0)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			else
			{
				var dx:Number;
				var dy:Number;
				
				dx = _path[_index].x * _cellsize - playerSpr.x + _cellsize/2;
				dy = _path[_index].y * _cellsize - playerSpr.y + _cellsize/2;
				
				var dist:Number = Math.sqrt(dx * dx + dy * dy);
				
				//到达当前目的地
				if (dist < _moveSpeed)
				{
					_index++;
					//已到最后一个目的地，则停下
					if (_index >= _path.length)
					{
						removeEventListener(Event.ENTER_FRAME, onEnterFrame);
						return;
					}
						//未到最后一个目的地，则在index++后重头进行行走逻辑
					else
					{
						onEnterFrame(event);
					}
				}
					//行走
				else
				{
					var angle:Number = Math.atan2(dy, dx);
					//角色朝向
					//_player.setwalk(angle);
					
					var speedX:Number = _moveSpeed * Math.cos(angle);
					var speedY:Number = _moveSpeed * Math.sin(angle);
					//trace (_player.y+stage.stageHeight+speedY>hang*_cellSize);
					mazeSpr.x -= speedX;										
					mazeSpr.y -= speedY;
					playerSpr.x += speedX ;
					playerSpr.y += speedY;
				}
			}
		}
		//重置
		private function reSet(e:MouseEvent = null):void{
			this.init();
		}
		//关闭离开
		private function closeHandler(e:MouseEvent = null):void{
			//获取奖励
			Reward.getitem(m_level);
			alone.maplayer.visible = true;
			if (cloBtn)cloBtn.removeEventListener(MouseEvent.CLICK,closeHandler);
			mazeArr = [];
			if (mazeSpr){
				while(mazeSpr.numChildren>0){
					mazeSpr.getChildAt(0).removeEventListener(MouseEvent.CLICK,mcHandler);
					mazeSpr.removeChildAt(0);
				}
			}
			this.theDest();
		}
	}
}