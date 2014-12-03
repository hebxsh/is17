package data
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import event.CommEvent;

	public class ChangeData extends Sprite
	{
		private var TABLENAME:String;
		public function ChangeData()
		{
		}
		/**
		 * 刷新数据
		 * */
		public function refreshData(str:String,sql:String,data:Object):void{
			TABLENAME = str;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderServerComplete);
			var res:URLRequest = new URLRequest(GameInit.getChangeDataUrl());
			res.method = URLRequestMethod.POST;
			var ver:URLVariables = new URLVariables();
			ver.tablename = str;
			ver.sqltype = sql;
			ver.sqldata = data;
			res.data = ver;
			loader.load(res);		
		}
		private function loaderServerComplete(e:Event):void{
			var userdata:Object = new Object();
			if(e.target.data){
				trace(e.target.data);
				userdata = JSON.parse(e.target.data);					
			}		
			var evt:CommEvent = new CommEvent(CommEvent.CHANGEDATA);
			evt.obj = userdata;
			dispatchEvent(evt);
		}
	}
}