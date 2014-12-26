package data
{
	import flash.display.Stage;

	public class GameInit
	{
		public static var m_equidwidth:int = 166;
		public static var m_equidheight:int = 46;
		public static var m_mapwidth:int = 84;
		public static var m_mapheight:int = 84;
		public static var m_stage:Stage;
		public static var tipArr:Array = new Array;
		public static var levelArr:Array = [0xffffff,0x00DB00,0x0000E3,0xbc02bc,0xF9F900];
		public static var levelHtmlArr:Array = ["#ffffff","#00DB00","#0000E3","#bc02bc","#F9F900"];
		public static var dataArr:Array = ["equip","mountain","monster","skill","book","material","sel","user","userskill","bag"];
		public static const LOCALDATALEN:int = 6;
		public static var leiArr:Array = ["zhenfa","migong","guaiwu","baowu"];
		public static var levNameArr:Array = ["初学乍练","初窥门径","登堂入室","了然於胸","渐入佳境","驾轻就熟","略有小成","出类拔萃","心领神会","登峰造极","深不可测","一代宗师","举世无双","震古铄今","随心所欲","出神入化","返璞归真","超凡入圣","天人合一","破碎虚空"];
		public static const p_xsArr:Array = [["hp","气血",1,0],["lingli","灵力",1,0],["zhenfa","阵法",1,0],["xueshi","学识",1,0],["tili","体力",0,0],["gongji","攻击",2,0],["fangyu","防御",2,0],["shenfa","身法",2,0],["sudu","速度",2,0],["mingzhong","命中",2,0],["duobi","躲避",2,0],["zhiming","致命",2,0],["zhaojia","招架",2,0],["jin","金",3,0],["mu","木",3,0],["shui","水",3,0],["huo","火",3,0],["tu","土",3,0],["feng","风",3,0],["lei","雷",3,0],["du","毒",3,0],["gu","蛊",3,0],["zhou","咒",3,0]];
		public static const p_xslArr:Array = ["","金","木","水","火","土","无","风","雷","毒","蛊","咒"];
		public static const p_SklArr:Array = ["",["金","3","2"],["木","4&9","5&7"],["水","2&11","4"],["火","5","1&10"],["土","1&9","3&11"],["无","0","0"],["风","8&4","9"],["雷","11&1","3&10"],["毒","10","1&8"],["蛊","7","11"],["咒","9","7"]];
		public static const wxsxArr:Array = ["jin","mu","shui","huo","tu","feng","lei","du","gu","zhou"];
		public static const gfsxArr:Array = ["gongji","fangyu","shenfa","sudu","mingzhong","duobi","zhiming","zhaojia","lingli","hp"];
		public static var FITERDELAY:int = 50;
		public static const ISRELESE:Boolean = false;
		
		private static const LOCALURL:String = "http://127.0.0.1/";
		private static const SERVERURL:String = "http://tayee.sinaapp.com/";
		/**登陆*/
		private static const LOGINURL:String = "login.php";	
		/**加载资源*/
		private static const LOADDATAURL:String = "loaddata.php";
		/**修改资源*/
		private static const CHANGEDATAURL:String = "changedata.php";
		public function GameInit()
		{
			
		}
		/**
		 * 数据表id
		 * */
		public static function getlid(str:String):int{
			var tlid:int;
			for (var i:int = 0;i<dataArr.length;i++){
				if (str==dataArr[i])tlid=i;
			}
			return tlid;
		}
		/**
		 * 获取颜色
		 * */
		public static function getColor(ti:int):int{
			return levelArr[ti];
		}
		/**
		 * 获取html颜色
		 * */
		public static function getHtmlColor(ti:int):String{
			return levelHtmlArr[ti];
		}
		/**
		 * 获取等级名
		 * */
		public static function getLevName(ti:int):String{
			return levNameArr[ti];
		}
		/**
		 * 返回属性值
		 * */
		public static function getSx(str:String):int{
			var tstr:int;
			for (var i:int = 0;i<p_xsArr.length;i++){	
				//for(var property:String in DataPool.getArr("user")[0]){	
				if (str == p_xsArr[i][0]){
					tstr = p_xsArr[i][3];						
				}
				//}
			}
			return tstr;
		}
		/**
		 * 返回属性名
		 * */
		public static function getSxName(str:String):String{
			var tstr:String;
			for (var i:int = 0;i<p_xsArr.length;i++){	
				//for(var property:String in DataPool.getArr("user")[0]){	
				if (str == p_xsArr[i][0]){
					tstr = p_xsArr[i][1].toString();						
				}
				//}
			}
			return tstr;
		}
		/**
		 * 返回材料属性类型
		 * */
		public static function getSxLeixing(str:int):String{
			var tstr:String;

			tstr = p_xslArr[str].toString();						

			return tstr;
		}
		/**
		 * 返回登陆地址
		 * */
		public static function getLoginUrl():String{
			var tstr:String;
			if(ISRELESE){
				tstr = SERVERURL+LOGINURL;
			}else{
				tstr = LOCALURL+LOGINURL;	
			}
			return tstr;
		}
		/**
		 * 返回加载地址
		 * */
		public static function getLoadDataUrl():String{
			var tstr:String;
			if(ISRELESE){
				tstr = SERVERURL+LOADDATAURL;
			}else{
				tstr = LOCALURL+LOADDATAURL;	
			}
			return tstr;
		}
		/**
		 * 返回刷新地址
		 * */
		public static function getChangeDataUrl():String{
			var tstr:String;
			if(ISRELESE){
				tstr = SERVERURL+CHANGEDATAURL;
			}else{
				tstr = LOCALURL+CHANGEDATAURL;	
			}
			return tstr;
		}
		/**
		 * 返回生克
		 * */
		public static function getWuxing(sk2:int,sk1:int):int{
			var sk:int = 0;
			var xx:String;
			var shengArr:Array = p_SklArr[sk1][1].split("&");
			for (var i:int = 0;i<shengArr.length;i++){
				if(int(shengArr[i]) == sk2)sk = 1;//相生
			}
			var keArr:Array = p_SklArr[sk1][2].split("&");
			for (var j:int = 0;j<keArr.length;j++){
				if(int(keArr[j]) == sk2)sk = 2;//相克
			}
			return sk;
		}
		/**
		 * 返回五行id
		 * */
		public static function getWuxingId(str:String):int{
			var tstr:String = "" ;
			for (var i:int = 0;i<p_xsArr.length;i++){	
				//for(var property:String in DataPool.getArr("user")[0]){	
				if (str == p_xsArr[i][0]){					
					tstr = p_xsArr[i][1];
				}
				//}
			}
			return p_xslArr.indexOf(tstr);
		}
	}
}