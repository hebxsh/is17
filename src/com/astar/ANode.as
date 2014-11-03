package com.astar
{
	/**
	 * Represents a specific node evaluated as part of a pathfinding algorithm.
	 */
	public class ANode
	{
		/** 一个节点的尺寸 */
		public static var NODE_SIZE:int = 34;
		
		/** 节点列号 */
		public var x:int;
		
		/** 节点行号 */
		public var y:int;
		
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var walkable:Boolean = true;
		public var parent:ANode;
		public var costMultiplier:Number = 1.0;
		
		/** 屏幕坐标系中的x坐标 */
		public var posX:Number;
		/** 屏幕坐标系中的y坐标 */
		public var posY:Number;
		
		/** 埋葬深度 */
		public var buriedDepth:int = -1;
		
		/** 距离 */
		public var distance:Number;
		
		public function ANode(x:int, y:int)
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 判断两个节点屏幕位置是否一样
		 * @param otherNode
		 * @return 
		 * 
		 */		
		public function posEquals( otherNode:ANode ):Boolean
		{
			if( posX == otherNode.posX && posY == otherNode.posY )
			{
				return true;
			}
			return false;
		}
		
		/** 得到此节点到另一节点的网格距离 */
		public function getDistanceTo( targetNode:ANode ):Number
		{
			var disX:Number = targetNode.x - x;
			var disY:Number = targetNode.y - y;
			distance = Math.sqrt( disX * disX + disY * disY );
			return distance;
		}
	}
}