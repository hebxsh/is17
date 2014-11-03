/**
 * VERSION: 1.00
 * DATE: 5/10/2010
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com;
 * by a〇
 **/
package com.greensock.plugins 
{	
	import com.greensock.TweenLite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	public class TransformAroundCenterPlugin extends TransformAroundGridPlugin
	{
		/** @private **/
		public static const API:Number = 1.0;
		
		public function TransformAroundCenterPlugin() 
		{
			super();
			this.propName = "transformAroundCenter";
			this.overwriteProps = ["scaleX", "scaleY", "rotation"];
		}
		
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean 
		{
			value.position = 4;
			super.onInitTween(target, value, tween);
			return true;
		}		
	}

}