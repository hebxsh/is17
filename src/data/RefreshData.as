package data
{
	import dialogs.LoadData;
	
	import event.CommEvent;

	public class RefreshData
	{
		/**
		 * 刷新数据
		 * */
		private static var r_tablestr:String;
		public function RefreshData()
		{
		}
		/**
		 * 更新某条数据
		 * */
		public static function updateData(tablestr:String,typestr:String,showstr:String,namestr:String = "",nameshowstr:String = ""):void{
			//SqlDb.save("userskill",{type:typestr,show:showstr,typeName:namestr,nameShow:nameshowstr});
			//var xx:Object = {type:typestr,show:showstr,typeName:namestr,nameShow:nameshowstr};
			r_tablestr = tablestr;
			var jsonstr:String = "[{\"type\":\""+typestr+"\",\"show\":\""+showstr+"\",\"typeName\":\""+namestr+"\",\"nameShow\":\""+nameshowstr+"\"}]";	
			var changeSkill:ChangeData = new ChangeData();
			changeSkill.refreshData(tablestr,"updat",jsonstr);
			changeSkill.addEventListener(CommEvent.CHANGEDATA,loaddataHandler);
		}
		/**
		 * 删除某条数据
		 * */
		public static function delet(tablestr:String,typemainid:String):void{
			r_tablestr = tablestr;	
			var changeSkill:ChangeData = new ChangeData();
			changeSkill.refreshData(tablestr,"delet",typemainid);
			changeSkill.addEventListener(CommEvent.CHANGEDATA,loaddataHandler);
		}
		/**
		 * 插入条数据
		 * */
		public static function inser(tablestr:String,typemainid:String):void{
			r_tablestr = tablestr;	
			var changeSkill:ChangeData = new ChangeData();
			changeSkill.refreshData(tablestr,"inser",typemainid);
			changeSkill.addEventListener(CommEvent.CHANGEDATA,loaddataHandler);
		}
		/**
		 * 取下装备或者技能
		 * */
		public static function unload(tablestr:String,typestr:String,showstr:String,namestr:String = "",nameshowstr:String = ""):void{
			r_tablestr = tablestr;	
			var jsonstr:String = "[{\"type\":\""+typestr+"\",\"show\":\""+showstr+"\",\"typeName\":\""+namestr+"\",\"nameShow\":\""+nameshowstr+"\"}]";	
			var changeSkill:ChangeData = new ChangeData();
			changeSkill.refreshData(tablestr,"unloa",jsonstr);
			changeSkill.addEventListener(CommEvent.CHANGEDATA,loaddataHandler);
		}
		/**
		 * 穿上装备或者技能
		 * */
		public static function puton(tablestr:String,typestr:String,showstr:String,namestr:String = "",nameshowstr:String = ""):void{
			r_tablestr = tablestr;	
			var jsonstr:String = "[{\"type\":\""+typestr+"\",\"show\":\""+showstr+"\",\"typeName\":\""+namestr+"\",\"nameShow\":\""+nameshowstr+"\"}]";	
			var changeSkill:ChangeData = new ChangeData();
			changeSkill.refreshData(tablestr,"puton",jsonstr);
			changeSkill.addEventListener(CommEvent.CHANGEDATA,loaddataHandler);
		}
		//刷新数据
		private static function loaddataHandler(e:CommEvent = null):void{
			//LoadData.RefreshData(r_tablestr);
			if (r_tablestr=="user"){
				LoadData.RefreshData("bag");
			}else if (r_tablestr=="userskill"){
				LoadData.RefreshData("userskill");
			}else if (r_tablestr=="skill"){
				LoadData.RefreshData("user");
			}else if (r_tablestr=="equip"){
				LoadData.RefreshData("bag");
			}
		}
		
		//查询数据
		public static function select(sstr:String,istr:String,selstr:String = ""):void{
			var getdata:DbData = new DbData();
			getdata.loaddata(sstr,istr,"select",selstr);
		}
		//插入数据
		public static function insert(str:String,edata:Object):void{
			var getdata:DbData = new DbData();
			getdata.insertdata(str,edata);
			getdata.loaddata(str);
		}
		
	}
}