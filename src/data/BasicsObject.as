package data
{
	import flash.display.Sprite;
	
	public class BasicsObject extends Sprite
	{
		//基础属性
		public var p_type:int = 1;
		private var p_maxhp:int = 0;		
		private var p_name:String = "";
		private var p_hp:int = 0;
		private var p_lingli:int = 0;
		private var p_zhenfa:int = 0;
		private var p_xueshi:int = 0;
		private var p_tili:int = 0;
		private var p_gongji:int = 0;
		private var p_fangyu:int = 0;
		private var p_shenfa:int = 0;
		private var p_sudu:int = 0;
		private var p_mingzhong:int = 0;
		private var p_duobi:int = 0;
		private var p_zhiming:int = 0;
		private var p_zhaojia:int = 0;
		private var p_jin:int = 0;
		private var p_mu:int = 0;
		private var p_shui:int = 0;
		private var p_huo:int = 0;
		private var p_tu:int = 0;
		private var p_feng:int = 0;
		private var p_lei:int = 0;
		private var p_du:int = 0;
		private var p_gu:int = 0;
		private var p_zhou:int = 0;
		
		public var p_die:Boolean = false;
		
		public var p_dotArr:Array = new Array();
		//public var p_nameArr:Array = [["name",p_name],["hp",p_hp],["lingli",p_lingli],["zhenfa",p_zhenfa],["xueshi",p_xueshi],["tili",p_tili],["gongji",p_gongji],["fangyu",p_fangyu],
		//							["shenfa",p_shenfa],["sudu",p_sudu],["mingzhong",p_mingzhong],["duobi",p_duobi],["zhiming",p_zhiming],["zhaojia",p_zhaojia],
		//							["jin",p_jin],["mu",p_mu],["shui",p_shui],["huo",p_huo],["tu",p_tu],["feng",p_feng],["lei",p_lei],["du",p_du],["gu",p_gu],["zhou",p_zhou]];
		//public var p_xsArr:Array = [p_name,p_hp,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,p_name,];
		
		public function BasicsObject()
		{
		}
		
		/**
		 * 名字
		 * */
//		public function set pname(e:String):void{
//			p_name = e;
//		}
//		public function get pname():String{
//			return p_name;
//		}		
		/**
		 * 最大气血
		 * */
		public function set maxhp(e:int):void{
			p_maxhp = e;
		}
		public function get maxhp():int{
			return p_maxhp;
		}
		/**
		 * 气血
		 * */
		public function set hp(e:int):void{
			p_hp = e;
		}
		public function get hp():int{
			return p_hp;
		}
		/**
		 * 攻击
		 * */
		public function set gongji(e:int):void{
			p_gongji = e;
		}
		public function get gongji():int{
			return p_gongji;
		}
		/**
		 * 防御
		 * */
		public function set fangyu(e:int):void{
			p_fangyu = e;
		}
		public function get fangyu():int{
			return p_fangyu;
		}
		/**
		 * 身法
		 * */
		public function set shenfa(e:int):void{
			p_shenfa = e;
		}
		public function get shenfa():int{
			return p_shenfa;
		}
		/**
		 * 速度
		 * */
		public function set sudu(e:int):void{
			p_sudu = e;
		}
		public function get sudu():int{
			return p_sudu;
		}
		/**
		 * 命中
		 * */
		public function set mingzhong(e:int):void{
			p_mingzhong = e;
		}
		public function get mingzhong():int{
			return p_mingzhong;
		}
		/**
		 * 躲避
		 * */
		public function set duobi(e:int):void{
			p_duobi = e;
		}
		public function get duobi():int{
			return p_duobi;
		}
		/**
		 * 招架
		 * */
		public function set zhaojia(e:int):void{
			p_zhaojia = e;
		}
		public function get zhaojia():int{
			return p_zhaojia;
		}
		/**
		 * 致命
		 * */
		public function set zhiming(e:int):void{
			p_zhiming = e;
		}
		public function get zhiming():int{
			return p_zhiming;
		}
		/**
		 * 金
		 * */
		public function set jin(e:int):void{
			p_jin = e;
		}
		public function get jin():int{
			return p_jin;
		}
		/**
		 * 木
		 * */
		public function set mu(e:int):void{
			p_mu = e;
		}
		public function get mu():int{
			return p_mu;
		}
		/**
		 * 水
		 * */
		public function set shui(e:int):void{
			p_shui = e;
		}
		public function get shui():int{
			return p_shui;
		}
		/**
		 * 火
		 * */
		public function set huo(e:int):void{
			p_huo = e;
		}
		public function get huo():int{
			return p_huo;
		}
		/**
		 * 土
		 * */
		public function set tu(e:int):void{
			p_tu = e;
		}
		public function get tu():int{
			return p_tu;
		}
		/**
		 * 风
		 * */
		public function set feng(e:int):void{
			p_feng = e;
		}
		public function get feng():int{
			return p_feng;
		}
		/**
		 * 雷
		 * */
		public function set lei(e:int):void{
			p_lei = e;
		}
		public function get lei():int{
			return p_lei;
		}
		/**
		 * 毒
		 * */
		public function set du(e:int):void{
			p_du = e;
		}
		public function get du():int{
			return p_du;
		}
		/**
		 * 蛊
		 * */
		public function set gu(e:int):void{
			p_gu = e;
		}
		public function get gu():int{
			return p_gu;
		}
		/**
		 * 咒
		 * */
		public function set zhou(e:int):void{
			p_zhou = e;
		}
		public function get zhou():int{
			return p_zhou;
		}
		/**
		 * 灵力
		 * */
		public function set lingli(e:int):void{
			p_lingli = e;
		}
		public function get lingli():int{
			return p_lingli;
		}
		/**
		 * 体力
		 * */
		public function set tili(e:int):void{
			p_tili = e;
		}
		public function get tili():int{
			return p_tili;
		}
		/**
		 * 阵法
		 * */
		public function set zhenfa(e:int):void{
			p_zhenfa = e;
		}
		public function get zhenfa():int{
			return p_zhenfa;
		}
		/**
		 * 学识
		 * */
		public function set xueshi(e:int):void{
			p_xueshi = e;
		}
		public function get xueshi():int{
			return p_xueshi;
		}
		
	}
}