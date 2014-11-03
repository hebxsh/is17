package com.astar
{
	import flash.geom.Point;

	/**
	 * 寻路算法中使用到的数学方法 
	 * @author S_eVent
	 * 
	 */	
	public class MathUtil
	{
		
		/**
		 * 根据两点确定这两点连线的二元一次方程 y = ax + b或者 x = ay + b
		 * @param ponit1
		 * @param point2
		 * @param type		指定返回函数的形式。为0则根据x值得到y，为1则根据y得到x
		 * 
		 * @return 由参数中两点确定的直线的二元一次函数
		 */		
		public static function getLineFunc(ponit1:Point, point2:Point, type:int=0):Function
		{
			var resultFuc:Function;
			

			// 先考虑两点在一条垂直于坐标轴直线的情况，此时直线方程为 y = a 或者 x = a 的形式
			if( ponit1.x == point2.x )
			{
				if( type == 0 )
				{
					throw new Error("两点所确定直线垂直于y轴，不能根据x值得到y值");
				}
				else if( type == 1 )
				{
					resultFuc =	function( y:Number ):Number
								{
									return ponit1.x;
								}
						
				}
				return resultFuc;
			}
			else if( ponit1.y == point2.y )
			{
				if( type == 0 )
				{
					resultFuc =	function( x:Number ):Number
					{
						return ponit1.y;
					}
				}
				else if( type == 1 )
				{
					throw new Error("两点所确定直线垂直于y轴，不能根据x值得到y值");
				}
				return resultFuc;
			}
			
			// 当两点确定直线不垂直于坐标轴时直线方程设为 y = ax + b
			var a:Number;
			
			// 根据
			// y1 = ax1 + b
			// y2 = ax2 + b
			// 上下两式相减消去b, 得到 a = ( y1 - y2 ) / ( x1 - x2 ) 
			a = (ponit1.y - point2.y) / (ponit1.x - point2.x);
			
			var b:Number;
			
			//将a的值代入任一方程式即可得到b
			b = ponit1.y - a * ponit1.x;
			
			//把a,b值代入即可得到结果函数
			if( type == 0 )
			{
				resultFuc =	function( x:Number ):Number
							{
								return a * x + b;
							}
			}
			else if( type == 1 )
			{
				resultFuc =	function( y:Number ):Number
				{
					return (y - b) / a;
				}
			}
			
			return resultFuc;
		}
		
		/**
		 * 得到两点间连线的斜率 
		 * @param ponit1	
		 * @param point2
		 * @return 			两点间连线的斜率 
		 * 
		 */		
		public static function getSlope( ponit1:Point, point2:Point ):Number
		{
			return (point2.y - ponit1.y) / (point2.x - ponit1.x); 
		}
		
		

	}
}