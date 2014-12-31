package dialogs
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import UI.BloodBar;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	
	import event.CommEvent;

	public class LoadData extends DialogObject
	{
		private var localTypeNum:int = 0;
		private var serverTypeNum:int = GameInit.LOCALDATALEN+2;
		private var progressBar:BloodBar;
		private var allLoadCom:int = 0;
		public function LoadData()
		{
			this.visible = true;
			theTitle("加载中...");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			progressBar = new BloodBar(1,320,15);
			progressBar.x = 80;
			progressBar.y = 500;
			this.addChild(progressBar);				
		}
		/**
		 * 加载数据资源
		 * */
		public function loadJsonData():void{
			allLoadCom = 0;
			initLocal("equip");	
			initServer("userskill");
		}
		/**
		 * 加载图片资源
		 * */
		public function loadImageData():void{
			allLoadCom = 0;
			initLocalImg();
		}
		/**
		 * 加载本地资源
		 * */
		private function initLocal(str:String = null):void{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderLocalComplete);
			loader.addEventListener(ProgressEvent.PROGRESS,onprogress);
			var res:URLRequest = new URLRequest("assets/"+str+".json");
			loader.load(res);
		}
		//进度条
		private var fenduanNum:int = 0;
		private function onprogress(e:ProgressEvent):void{
			var nowbyte:int = e.bytesLoaded;
			var totalbyte:int = e.bytesTotal;
			if(totalbyte>0){
				progressBar.ReMax(totalbyte*(GameInit.dataArr.length-1));
				progressBar.ReNum(nowbyte+totalbyte*fenduanNum);	
			}
			fenduanNum++;
		}
		private function loaderLocalComplete(e:Event):void{
			var userdata:Object = new Object();
			if(e.target.data){
				userdata = JSON.parse(e.target.data);					
			}				
			DataPool.setData(GameInit.dataArr[localTypeNum], userdata);	
			++localTypeNum;
			if(localTypeNum<GameInit.LOCALDATALEN){
				initLocal(GameInit.dataArr[localTypeNum]);
			}else{
				allLoadCom++;
				loadComp();				
			}
		}
		/**
		 * 加载服务器资源
		 * */
		private function initServer(str:String = null):void{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderServerComplete);
			loader.addEventListener(ProgressEvent.PROGRESS,onprogress);
			var res:URLRequest = new URLRequest(GameInit.getLoadDataUrl());
			res.method = URLRequestMethod.POST;
			var ver:URLVariables = new URLVariables();
			ver.tablename = str;
			res.data = ver;
			loader.load(res);
		}
		
		private function loaderServerComplete(e:Event):void{
			var userdata:Object = new Object();
			if(e.target.data!="load filed!"){
				userdata = JSON.parse(e.target.data);					
			}	
			DataPool.setData(GameInit.dataArr[serverTypeNum], userdata);	
			++serverTypeNum;
			if(serverTypeNum<GameInit.dataArr.length){
				initServer(GameInit.dataArr[serverTypeNum]);
			}else{
				allLoadCom++;
				loadComp();
			}
		}
		//加载完毕开始游戏
		private function loadComp():void{
			if(allLoadCom<2)return;
			this.visible = false;
			var evt:CommEvent = new CommEvent(CommEvent.LOADCOMPLETE);
			dispatchEvent(evt);
		}
		/**
		* 加载本地图片资源
		* */
		private var imgnum:int;
		private var imglen:int;
		private function initLocalImg(str:String = null):void{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderCfgComplete);
			loader.addEventListener(ProgressEvent.PROGRESS,onprogress);
			var res:URLRequest = new URLRequest("assets/imageconfig.xml");
			loader.load(res);
		}
		private function loaderCfgComplete(e:Event):void{
			var tem:XML = XML(e.target.data) ;
			var nodes:XMLList = tem.child("item");
			imglen = nodes.length();
			for (var i:int = 0;i<imglen;i++){
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function(e:Event):void{ loaderLocalImgXmlComplete(e,nodes[i]); });
				loader.addEventListener(ProgressEvent.PROGRESS,onprogress);
				var res:URLRequest = new URLRequest("assets/"+nodes[i]+".xml");
				loader.load(res);
				var loader1:Loader = new Loader();
				loader1.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void{ loaderLocalImgComplete(e,nodes[i]); });
				loader1.addEventListener(ProgressEvent.PROGRESS,onprogress);
				var res1:URLRequest = new URLRequest("assets/"+nodes[i]+".png");
				loader1.load(res1);
			}
		}
		private function loaderLocalImgXmlComplete(e:Event,str:String):void{
			var imgdata:XML = XML(e.target.data); 			
			DataPool.setImgXml(str,imgdata);	
			++imgnum;
			if(imgnum>=imglen*2){
				allLoadCom = 2;
				loadComp();		
			}
		}
		private function loaderLocalImgComplete(e:Event,str:String):void{
			var imgdata:Bitmap = e.target.content ; 			
			DataPool.setImgData(str,imgdata);	
			++imgnum;
			if(imgnum>=imglen*2){
				allLoadCom = 2;
				loadComp();		
			}
		}
		/**
		 * 刷新显示资源
		 * */
		public static var dataStr:String;
		public static function RefreshData(str:String = null):void{
			dataStr = str;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderRefreshComplete);
			var res:URLRequest = new URLRequest(GameInit.getLoadDataUrl());
			res.method = URLRequestMethod.POST;
			var ver:URLVariables = new URLVariables();
			ver.tablename = str;
			res.data = ver;
			loader.load(res);
		}
		
		private static function loaderRefreshComplete(e:Event):void{
			var userdata:Object = new Object();
			if(e.target.data!="load filed!"){trace (e.target.data);
				userdata = JSON.parse(e.target.data);					
			}	
			DataPool.setData(dataStr, userdata);
			if(alone.skilldialog)alone.skilldialog.Refresh();
			if(alone.bagdialog)alone.bagdialog.Refresh();
			if(alone.xiuliandialog)alone.xiuliandialog.Refresh();
			if(alone.playerdialog)alone.playerdialog.Refresh();
		}
	}
}