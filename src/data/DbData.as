package data
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;


	public class DbData
	{
		private var sqlConnection:SQLConnection;
		private var sqlStatement:SQLStatement;
		private var d_selstr:String;
		private var d_insstr:String;
		private var d_status:String;
		public function DbData()
		{
			
		}
		//初始化
		public function init():void{
			for(var i:int = 0;i<GameInit.dataArr.length;i++){
				if (GameInit.dataArr[i]!="sel")
				loaddata(GameInit.dataArr[i]);
			}
		}
		
		public function loaddata(sstr:String,istr:String = "",sta:String = "load",selstr:String = ""):void{
			d_selstr = sstr;
			d_insstr = istr;
			d_status = sta;
			sqlConnection = new SQLConnection();			
			sqlConnection.addEventListener(SQLEvent.OPEN, openHandler);			
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);			
			
			sqlStatement = new SQLStatement();			
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = "SELECT * FROM "+sstr+" "+selstr;
			
			var dbFile:File = File.applicationDirectory.resolvePath("alone.db");
			sqlConnection.open(dbFile);
		}
		//保存数据
		public function savedata(str:String,edata:Object):void{
			sqlConnection = new SQLConnection();			
			sqlConnection.addEventListener(SQLEvent.OPEN, saveHandler);			
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);			
			
			sqlStatement = new SQLStatement();			
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = saveString(str,edata);
			
			var dbFile:File = File.applicationDirectory.resolvePath("alone.db");			
			sqlConnection.open(dbFile);
		}
		private function saveString(str:String,edata:Object):String{
			var tstr:String;
			switch(str){
				case "user":					
					tstr = "UPDATE "+ str + " SET "+edata.type+"='"+edata.show+"'";
					break;
				case "userskill":
					tstr = "UPDATE "+ str + " SET "+edata.type+"='"+edata.show+"'" + " WHERE " + edata.typeName+"='"+edata.nameShow+"'";
					break;
			}
			trace (tstr);
			return tstr;
		}
		//插入数据
		public function insertdata(str:String,edata:Object):void{
			sqlConnection = new SQLConnection();			
			sqlConnection.addEventListener(SQLEvent.OPEN, saveHandler);			
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);			
			
			sqlStatement = new SQLStatement();			
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = insertString(str,edata);
			
			var dbFile:File = File.applicationDirectory.resolvePath("alone.db");			
			sqlConnection.open(dbFile);
		}
		private function insertString(str:String,edata:Object):String{
			var tstr:String;
			switch(str){
				case "bag":
					tstr = "insert into "+str + " (id,num) values ("+edata.id+","+edata.num+");";
					break;
				case "userskill":
					tstr = "insert into "+str + " (id,level,exp,useing) values ("+edata.id+","+edata.level+","+edata.exp+","+edata.useing+");";
					break;
			}
			return tstr;
		}
		//删除数据
		public function deletedata(str:String,edata:Object):void{
			sqlConnection = new SQLConnection();			
			sqlConnection.addEventListener(SQLEvent.OPEN, saveHandler);			
			sqlConnection.addEventListener(SQLErrorEvent.ERROR, errorHandler);
			sqlStatement = new SQLStatement();			
			sqlStatement.sqlConnection = sqlConnection;
			sqlStatement.text = deleteString(str,edata);
			
			var dbFile:File = File.applicationDirectory.resolvePath("alone.db");			
			sqlConnection.open(dbFile);
		}
		private function deleteString(str:String,edata:Object):String{
			var tstr:String;
			switch(str){
				case "bag":
					tstr = "delete from "+str + " where mainid='"+edata.mainid+"';";
					break;
				case "userskill":
					tstr = "delete from "+str + " where mainid='"+edata.mainid+"';";
					break;
			}
			return tstr;
		}
		//保存
		private function saveHandler(event:SQLEvent):void			
		{	
			sqlStatement.addEventListener(SQLEvent.RESULT, saveresultHandler);
			sqlStatement.execute();	
		}
		private function saveresultHandler(event:SQLEvent):void			
		{	
		}

		//加载
		private function openHandler(event:SQLEvent):void			
		{	
			switch(d_status){
				case "load":
					sqlStatement.addEventListener(SQLEvent.RESULT, loadresultHandler);			
					sqlStatement.execute();	
					break;
				case "select":
					sqlStatement.addEventListener(SQLEvent.RESULT, selectresultHandler);			
					sqlStatement.execute();	
					break;
			}
		}
		private function errorHandler(event:SQLErrorEvent):void			
		{			
			trace ("加载失败");
		}
		//存储
		private function loadresultHandler(event:SQLEvent):void			
		{			
			var result:SQLResult = sqlStatement.getResult();
			if(result != null && result.data!=null)				
			{				
				DataPool.getArr(d_selstr).splice(0);
				for(var i:int = 0; i < result.data.length; i++){
					DataPool.getArr(d_selstr).push(result.data[i]);					
				}
			}			
		}
		//查询取出
		private function selectresultHandler(event:SQLEvent):void			
		{			
			var result:SQLResult = sqlStatement.getResult();			
			if(result != null&& result.data!=null)				
			{	
				if (d_insstr==""){
					DataPool.getArr(d_selstr).splice(0);
					for(var i:int = 0; i < result.data.length; i++)
					{					
						DataPool.getArr(d_selstr).push(result.data[i]);
					}		
				}
				else{
					DataPool.getArr(d_insstr).push(result.data[i]);
				}
			}			
		}
	}
}