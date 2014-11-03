package data
{
	public class PlayerInit
	{
		public static var p_type:int = 0;
		
		public static var maxhp:int = 0;		
		public static var name:String = "";
		public static var hp:int = 0;
		public static var lingli:int = 0;
		public static var zhenfa:int = 0;
		public static var xueshi:int = 0;
		public static var tili:int = 0;
		public static var gongji:int = 0;
		public static var fangyu:int = 0;
		public static var shenfa:int = 0;
		public static var sudu:int = 0;
		public static var mingzhong:int = 0;
		public static var duobi:int = 0;
		public static var zhiming:int = 0;
		public static var zhaojia:int = 0;
		public static var jin:int = 0;
		public static var mu:int = 0;
		public static var shui:int = 0;
		public static var huo:int = 0;
		public static var tu:int = 0;
		public static var feng:int = 0;
		public static var lei:int = 0;
		public static var du:int = 0;
		public static var gu:int = 0;
		public static var zhou:int = 0;

		public static var p_status:int = 0;
		public static var p_custom:int = 0;
		
		public static var p_skillArr:Array = new Array;
		public static var p_wuqi:int = 0;
		public static var p_fangju:int = 0;
		public static var p_fabao1:int = 0;
		public static var p_fabao2:int = 0;
		
		public static const p_xsArr:Array = [["hp","气血",1,0],["lingli","灵力",1,0],["zhenfa","阵法",1,0],["xueshi","学识",1,0],["tili","体力",0,0],["gongji","攻击",2,0],["fangyu","防御",2,0],["shenfa","身法",2,0],["sudu","速度",2,0],["mingzhong","命中",2,0],["duobi","躲避",2,0],["zhiming","致命",2,0],["zhaojia","招架",2,0],["jin","金",3,0],["mu","木",3,0],["shui","水",3,0],["huo","火",3,0],["tu","土",3,0],["feng","风",3,0],["lei","雷",3,0],["du","毒",3,0],["gu","蛊",3,0],["zhou","咒",3,0]];
		/**
		 * 玩家属性类。
		 * 折腾半天还是用了旧方法
		 * */
		public function PlayerInit()
		{
		}
		public static function init():void{
			var obj:Object = DataPool.getArr("user");			
			for (var i:int = 0;i<p_xsArr.length;i++){
				p_xsArr[i][3] = int(DataPool.getArr("user")[0][p_xsArr[i][0]]);
			}
			
			maxhp = int(DataPool.getArr("user")[0].hp);		
			name = DataPool.getArr("user")[0].name;
			hp = int(DataPool.getArr("user")[0].hp);
			lingli = int(DataPool.getArr("user")[0].lingli);
			zhenfa = int(DataPool.getArr("user")[0].zhenfa);
			xueshi = int(DataPool.getArr("user")[0].xueshi);
			tili = int(DataPool.getArr("user")[0].tili);
			gongji = int(DataPool.getArr("user")[0].gongji);
			fangyu = int(DataPool.getArr("user")[0].fangyu);
			shenfa = int(DataPool.getArr("user")[0].shenfa);
			sudu = int(DataPool.getArr("user")[0].sudu);
			mingzhong = int(DataPool.getArr("user")[0].mingzhong);
			duobi = int(DataPool.getArr("user")[0].duobi);
			zhiming = int(DataPool.getArr("user")[0].zhiming);
			zhaojia = int(DataPool.getArr("user")[0].zhaojia);
			jin = int(DataPool.getArr("user")[0].jin);
			mu = int(DataPool.getArr("user")[0].mu);
			shui = int(DataPool.getArr("user")[0].shui);
			huo = int(DataPool.getArr("user")[0].huo);
			tu = int(DataPool.getArr("user")[0].tu);
			feng = int(DataPool.getArr("user")[0].feng);
			lei = int(DataPool.getArr("user")[0].lei);
			du = int(DataPool.getArr("user")[0].du);
			gu = int(DataPool.getArr("user")[0].gu);
			zhou = int(DataPool.getArr("user")[0].zhou);
		}
		//返回属性值
		public static function getSx(str:String):int{
			var tnum:int;
			if (str == "hp")tnum = hp;
			if (str == "lingli")tnum = lingli;
			if (str == "zhenfa")tnum = zhenfa;
			if (str == "xueshi")tnum = xueshi;
			if (str == "tili")tnum = tili;
			if (str == "gongji")tnum = gongji;
			if (str == "fangyu")tnum = fangyu;
			if (str == "shenfa")tnum = shenfa;
			if (str == "sudu")tnum = sudu;
			if (str == "mingzhong")tnum = mingzhong;
			if (str == "duobi")tnum = duobi;
			if (str == "zhiming")tnum = zhiming;
			if (str == "zhaojia")tnum = zhaojia;
			if (str == "jin")tnum = jin;
			if (str == "mu")tnum = mu;
			if (str == "shui")tnum = shui;
			if (str == "huo")tnum = huo;
			if (str == "tu")tnum = tu;
			if (str == "feng")tnum = feng;
			if (str == "lei")tnum = lei;
			if (str == "du")tnum = du;
			if (str == "gu")tnum = gu;
			if (str == "zhou")tnum = zhou;
			return tnum;
		}
		public static function getName(str:String):String{
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
		public static function setSx(str:String,num:int,sd:Boolean = false):void{
			//for (var i:int = 0;i<p_xsArr.length;i++){				
				//if (str == p_xsArr[i][0]){
			if (sd){
				if (str == "hp")hp = num;
				if (str == "lingli")lingli = num;
				if (str == "zhenfa")zhenfa= num;
				if (str == "xueshi")xueshi = num;
				if (str == "tili")tili = num;
				if (str == "gongji")gongji = num;
				if (str == "fangyu")fangyu = num;
				if (str == "shenfa")shenfa = num;
				if (str == "sudu")sudu = num;
				if (str == "mingzhong")mingzhong = num;
				if (str == "duobi")duobi = num;
				if (str == "zhiming")zhiming = num;
				if (str == "zhaojia")zhaojia = num;
				if (str == "jin")jin = num;
				if (str == "mu")mu = num;
				if (str == "shui")shui = num;
				if (str == "huo")huo = num;
				if (str == "tu")tu = num;
				if (str == "feng")feng = num;
				if (str == "lei")lei = num;
				if (str == "du")du = num;
				if (str == "gu")gu = num;
				if (str == "zhou")zhou = num;
			}else{
				if (str == "hp")hp += num;
				if (str == "lingli")lingli += num;
				if (str == "zhenfa")zhenfa+= num;
				if (str == "xueshi")xueshi += num;
				if (str == "tili")tili += num;
				if (str == "gongji")gongji += num;
				if (str == "fangyu")fangyu += num;
				if (str == "shenfa")shenfa += num;
				if (str == "sudu")sudu += num;
				if (str == "mingzhong")mingzhong += num;
				if (str == "duobi")duobi += num;
				if (str == "zhiming")zhiming += num;
				if (str == "zhaojia")zhaojia += num;
				if (str == "jin")jin += num;
				if (str == "mu")mu += num;
				if (str == "shui")shui += num;
				if (str == "huo")huo += num;
				if (str == "tu")tu += num;
				if (str == "feng")feng += num;
				if (str == "lei")lei += num;
				if (str == "du")du += num;
				if (str == "gu")gu += num;
				if (str == "zhou")zhou += num;
			}
					
				//}				
			//}
		}
	}
}