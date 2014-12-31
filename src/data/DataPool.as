package data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.html.script.Package;

	public class DataPool
	{
		//public static var dataArr:Array = [equipArr,userArr,bagArr,selArr];
		public static var dataArr:Array ;
		public static var imgArr:Array ;
		public static var imgXmlArr:Array ;
		
		public function DataPool()
		{
			
		}
		public static function getSel(str:String,tid:int):Object{
			var temarr:Object = getArr(str);
			if (!temarr)return 0;
			if(temarr[0].length>1){
				for (var i:int = 0;i<temarr[0].length;i++){
					if(temarr[0][i].id == tid){
						return temarr[0][i];
						break;
					}
				}
			}else{
				for (var j:int = 0;j<temarr.length;j++){
					if(temarr[j].id == tid){
						return temarr[j];
						break;
					}
				}
			}
			return 0;
		}

		/*public static function getMonster(tid:int):Object{
			for (var i:int = 0;i<getArr("mountain").length;i++){
				if(getArr("mountain")[i].id == tid){
					return getArr("mountain")[i];
					break;
				}
			}
			return 0;
		}*/
		//根据类型返回数组
		public static function getArr(str:String):Array{
			if (!dataArr){
				dataArr = new Array();
				for (var i:int = 0;i<GameInit.dataArr.length;i++)dataArr.push(new Array());
			}
			return dataArr[GameInit.getlid(str)] as Array;
		}
		//写入数据到程序
		public static function setData(str:String,obj:Object):void{
			if (!dataArr){
				dataArr = new Array();
				for (var i:int = 0;i<GameInit.dataArr.length;i++)dataArr.push(new Object());
			}
			dataArr[GameInit.getlid(str)] = obj;
		}
		//写入图片数据到程序
		public static function setImgData(str:String,obj:Bitmap):void{
			if (!imgArr){
				imgArr = new Array();
			}
			imgArr.push([str,obj]);
		}
		//写入图片配置到程序
		public static function setImgXml(str:String,obj:XML):void{
			if (!imgXmlArr){
				imgXmlArr = new Array();
			}
			imgXmlArr.push([str,obj]);
		}
		/**
		 * 返回图片库
		 * */
		public static function getImgData(tstr:String):Bitmap{
			var tbitmap:Bitmap = new Bitmap;
			for (var i:int = 0;i<imgXmlArr.length;i++){
				var nodes:XMLList = imgXmlArr[i][1].child("sprite");trace (nodes[0].attribute("n"));
				var tb:Bitmap = getBitmap(imgXmlArr[i][0]);
				for (var j:int = 0;j<nodes.length();j++){
					if (nodes[j].attribute("n")==tstr){
						var bitmapdata:BitmapData = new BitmapData(int(nodes[j].attribute("w")),int(nodes[j].attribute("h")),true,0);
						var trect:Rectangle = new Rectangle(int(nodes[j].attribute("x")),int(nodes[j].attribute("y")),int(nodes[j].attribute("w")),int(nodes[j].attribute("h")));
						bitmapdata.copyPixels(tb.bitmapData,trect,new Point(0,0));
						tbitmap.bitmapData = bitmapdata;
						return tbitmap;
					}
				}
			}
			return tbitmap;
		}
		private static function getBitmap(str:String):Bitmap{
			var tbitmap:Bitmap;
			for (var i:int = 0;i<imgArr.length;i++){
				if (imgArr[i][0]==str){
					tbitmap =  imgArr[i][1];
					break;
				}
			}
			return tbitmap;
		}
	}
}