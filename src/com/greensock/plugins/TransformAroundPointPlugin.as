/**
 * VERSION: 1.00
 * DATE: 5/10/2010
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com;
 * by a〇
 **/
package com.greensock.plugins 
{
	import com.greensock.plugins.TransformMatrixPlugin;
	import com.greensock.TweenLite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Transform;
	
	public class TransformAroundPointPlugin extends TransformMatrixPlugin
	{
		/** @private **/
		public static const API:Number = 1.0;
		/** @private **/
		private static const _DEG2RAD:Number = Math.PI / 180;
		/** @private **/
		private static const _RAD2DEG:Number = 180 / Math.PI;
		/** @private **/
		protected var _point:Point;
		
		public function TransformAroundPointPlugin() 
		{
			super();
			this.propName = "transformAroundPoint";
			this.overwriteProps = ["scaleX", "scaleY", "rotation", "point"];
		}
		
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean 
		{
			_transform = target.transform as Transform;
			_matrix = _transform.matrix;
			var matrix:Matrix = _matrix.clone();
			_txStart = matrix.tx;
			_tyStart = matrix.ty;
			_aStart = matrix.a;
			_bStart = matrix.b;
			_cStart = matrix.c;
			_dStart = matrix.d;
			
			if ("x" in value) {
				_txChange = (typeof(value.x) == "number") ? value.x - _txStart : Number(value.x);
			} else if ("tx" in value) {
				_txChange = value.tx - _txStart;
			} else {
				_txChange = 0;
			}
			if ("y" in value) {
				_tyChange = (typeof(value.y) == "number") ? value.y - _tyStart : Number(value.y);
			} else if ("ty" in value) {
				_tyChange = value.ty - _tyStart;
			} else {
				_tyChange = 0;
			}
			_aChange = ("a" in value) ? value.a - _aStart : 0;
			_bChange = ("b" in value) ? value.b - _bStart : 0;
			_cChange = ("c" in value) ? value.c - _cStart : 0;
			_dChange = ("d" in value) ? value.d - _dStart : 0;
			
			if ("shortRotation" in value) {
				value.rotation = getRotation(target["rotation"], (typeof(value.shortRotation["rotation"]) == "number") ? Number(value.shortRotation["rotation"]) : target["rotation"] + Number(value.shortRotation["rotation"]));
			}
			if (("rotation" in value) || ("scale" in value) || ("scaleX" in value) || ("scaleY" in value)) {
				var ratioX:Number, ratioY:Number;
				var scaleX:Number = Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b); //Bugs in the Flex framework prevent DisplayObject.scaleX from working consistently, so we must determine it using the matrix.
				if (matrix.a < 0 && matrix.d > 0) {
					scaleX = -scaleX;
				}
				var scaleY:Number = Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d); //Bugs in the Flex framework prevent DisplayObject.scaleY from working consistently, so we must determine it using the matrix.
				if (matrix.d < 0 && matrix.a > 0) {
					scaleY = -scaleY;
				}
				var angle:Number = Math.atan2(matrix.b, matrix.a); //Bugs in the Flex framework prevent DisplayObject.rotation from working consistently, so we must determine it using the matrix
				if (matrix.a < 0 && matrix.d >= 0) {
					angle += (angle <= 0) ? Math.PI : -Math.PI;
				}
				
				var finalAngle:Number = ("rotation" in value) ? (typeof(value.rotation) == "number") ? value.rotation * _DEG2RAD : Number(value.rotation) * _DEG2RAD + angle : angle;
				
				if (finalAngle != angle) {
					if ("rotation" in value) {
						_angleChange = finalAngle - angle;
						finalAngle = angle; //to correctly affect the skewX calculations below
					} else {
						matrix.rotate(finalAngle - angle);
					}
				}
				
				if ("scale" in value) {
					ratioX = Number(value.scale) / scaleX;
					ratioY = Number(value.scale) / scaleY;
					if (typeof(value.scale) != "number") { //relative value
						ratioX += 1;
						ratioY += 1;
					}
				} else {
					if ("scaleX" in value) {
						ratioX = Number(value.scaleX) / scaleX;
						if (typeof(value.scaleX) != "number") { //relative value
							ratioX += 1;
						}
					}
					if ("scaleY" in value) {
						ratioY = Number(value.scaleY) / scaleY;
						if (typeof(value.scaleY) != "number") { //relative value
							ratioY += 1;
						}
					}
				}
				
				if (ratioX) {
					matrix.a *= ratioX;
					matrix.b *= ratioX;
				}
				if (ratioY) {
					matrix.c *= ratioY;
					matrix.d *= ratioY;
				}
				_aChange = matrix.a - _aStart;
				_bChange = matrix.b - _bStart;
				_cChange = matrix.c - _cStart;
				_dChange = matrix.d - _dStart;
				
				scaleX = Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b);
				if (matrix.a < 0 && matrix.d > 0) {
					scaleX = -scaleX;
				}
				scaleY = Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d);
				if (matrix.d < 0 && matrix.a > 0) {
					scaleY = -scaleY;
				}
			}
			
			_point = ("point" in value && value.point is Point) ? Point(value.point) : new Point(_txStart, _tyStart);
			_txChange = (_point.x - _txStart) * (1 - scaleX);
			_tyChange = (_point.y - _tyStart) * (1 - scaleY);
			
			return true;
		}
		
		override public function set changeFactor(n:Number):void 
		{
			_matrix.a = _aStart + (n * _aChange);
			_matrix.b = _bStart + (n * _bChange);
			_matrix.c = _cStart + (n * _cChange);
			_matrix.d = _dStart + (n * _dChange);
			
			var origin:Matrix = new Matrix(1, 0, 0, 1, 0, 0);
			if (_angleChange) {
				_matrix.rotate(_angleChange * n);
				origin.rotate(_angleChange * n);
			}
			
			_matrix.tx = _txStart + (n * _txChange);
			_matrix.ty = _tyStart + (n * _tyChange);
			var _disX:Number = (_matrix.tx - _point.x) * origin.a + (_matrix.ty - _point.y) * origin.c - (_matrix.tx - _point.x);
			var _disY:Number = (_matrix.tx - _point.x) * origin.b + (_matrix.ty - _point.y) * origin.d - (_matrix.ty - _point.y);
			_matrix.tx += _disX;
			_matrix.ty += _disY;
			_transform.matrix = _matrix;
		}
		
		private function getRotation(start:Number, end:Number):Number {
			var diff:Number = (end - start) % 360;
			if (diff != diff % 180) {
				diff = (diff < 0) ? diff + 360 : diff - 360;
			}
			return start + diff;
		}	
		
	}

}