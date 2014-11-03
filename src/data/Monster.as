package data
{
	import flash.display.Sprite;
	
	import UI.BloodBar;
	import UI.MyText;

	public class Monster extends BasicsObject
	{
		private var monsterSpr:Sprite;
		public var bloodbar:BloodBar;
		public function Monster()
		{
		}
		public function init(elev):void{
			var temnum:int = getNum(elev);	

//			for (var i = 0;i<nameArr.length;i++){	
//				for(var property:String in DataPool.getArr("monster")[temnum]){
//					if (property == nameArr[i][0]){
//						xsArr[i] = int(DataPool.getArr("monster")[temnum][property]);					
//
//					}
//				}
//			}
			maxhp = int(DataPool.getArr("monster")[temnum].hp);		
			name = DataPool.getArr("monster")[temnum].name;
			hp = int(DataPool.getArr("monster")[temnum].hp);
			lingli = int(DataPool.getArr("monster")[temnum].lingli);
			zhenfa = int(DataPool.getArr("monster")[temnum].zhenfa);
			xueshi = int(DataPool.getArr("monster")[temnum].xueshi);
			tili = int(DataPool.getArr("monster")[temnum].tili);
			gongji = int(DataPool.getArr("monster")[temnum].gongji);
			fangyu = int(DataPool.getArr("monster")[temnum].fangyu);
			shenfa = int(DataPool.getArr("monster")[temnum].shenfa);
			sudu = int(DataPool.getArr("monster")[temnum].sudu);
			mingzhong = int(DataPool.getArr("monster")[temnum].mingzhong);
			duobi = int(DataPool.getArr("monster")[temnum].duobi);
			zhiming = int(DataPool.getArr("monster")[temnum].zhiming);
			zhaojia = int(DataPool.getArr("monster")[temnum].zhaojia);
			jin = int(DataPool.getArr("monster")[temnum].jin);
			mu = int(DataPool.getArr("monster")[temnum].mu);
			shui = int(DataPool.getArr("monster")[temnum].shui);
			huo = int(DataPool.getArr("monster")[temnum].huo);
			tu = int(DataPool.getArr("monster")[temnum].tu);
			feng = int(DataPool.getArr("monster")[temnum].feng);
			lei = int(DataPool.getArr("monster")[temnum].lei);
			du = int(DataPool.getArr("monster")[temnum].du);
			gu = int(DataPool.getArr("monster")[temnum].gu);
			zhou = int(DataPool.getArr("monster")[temnum].zhou);
			
			
			monsterSpr = new Sprite;
			monsterSpr.x = 50;
			monsterSpr.y = 80;
			addChild(monsterSpr);
			
			bloodbar = new BloodBar(hp);			
			monsterSpr.addChild(bloodbar);
			var arrNameTxt:MyText = new MyText(name);
			arrNameTxt.x = bloodbar.x;
			arrNameTxt.y = bloodbar.y+7;
			monsterSpr.addChild(arrNameTxt);
			
		}
		public function getSx(str:String):int{
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
		public function setSx(str:String,tnum:int):void{
			if (str == "hp") hp = tnum;
			if (str == "lingli") lingli = tnum;
			if (str == "zhenfa") zhenfa = tnum;
			if (str == "xueshi") xueshi = tnum;
			if (str == "tili") tili = tnum;
			if (str == "gongji") gongji = tnum;
			if (str == "fangyu") fangyu = tnum;
			if (str == "shenfa") shenfa = tnum;
			if (str == "sudu") sudu = tnum;
			if (str == "mingzhong") mingzhong = tnum;
			if (str == "duobi") duobi = tnum;
			if (str == "zhiming") zhiming = tnum;
			if (str == "zhaojia") zhaojia = tnum;
			if (str == "jin") jin = tnum;
			if (str == "mu") mu = tnum;
			if (str == "shui") shui = tnum;
			if (str == "huo") huo = tnum;
			if (str == "tu") tu = tnum;
			if (str == "feng") feng = tnum;
			if (str == "lei") lei = tnum;
			if (str == "du") du = tnum;
			if (str == "gu") gu = tnum;
			if (str == "zhou") zhou = tnum;
		}
		private function getNum(elev):int{
			var temArr:Array = new Array;
			for (var i:int = 0;i<DataPool.getArr("monster").length;i++){
				if(DataPool.getArr("monster")[i].level == elev+1)temArr.push(i);
			}
			return temArr[int(Math.random()*temArr.length)];
		}
		
	}
}