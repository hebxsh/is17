package data
{
	public class SqlDb
	{
		/**
		 * 读取本地数据库类，
		 * 
		 * 弃用。
		 * */
		public function SqlDb()
		{
		}
		public static function load(str:String):void{
			
		}
		//保存数据
		public static function save(str:String,edata:Object):void{
			var getdata:DbData = new DbData();
			getdata.savedata(str,edata);
			getdata.loaddata(str);
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
		//删除数据
		public static function delet(str:String,edata:Object):void{
			var getdata:DbData = new DbData();
			getdata.deletedata(str,edata);
			getdata.loaddata(str);
		}
		
	}
}