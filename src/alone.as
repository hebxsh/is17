package
{
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import UI.ToolTip;
	
	import data.GameInit;
	import data.PlayerInit;
	
	import dialogs.BagDialog;
	import dialogs.BottomUI;
	import dialogs.CustomDialog;
	import dialogs.LoadData;
	import dialogs.MazeDialog;
	import dialogs.PlayerDialog;
	import dialogs.SkillDialog;
	import dialogs.UpUI;
	import dialogs.UserLogin;
	import dialogs.XiulianDialog;
	
	import event.CommEvent;
	
	import scene.FightLayer;
	import scene.MapLayer;
	
	[SWF(width="480", height="800", frameRate="60", backgroundColor="#777777")]	
	public class alone extends Sprite
	{	
		public static var upui:UpUI;
		private var bottomui:BottomUI;
		public static var userlogin:UserLogin;
		public static var loaddata:LoadData;
		public static var maplayer:MapLayer;
		public static var playerdialog:PlayerDialog;
		public static var bagdialog:BagDialog;
		public static var skilldialog:SkillDialog;
		public static var customdialog:CustomDialog;
		public static var mazedialog:MazeDialog;
		public static var fightlayer:FightLayer;
		public static var xiuliandialog:XiulianDialog;
		public static var alertSpr:Sprite;
		public static var topSpr:Sprite;
		
		private var win:NativeWindow;
			
		public function alone()
		{
			super();			
			// 支持 autoOrient
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_BORDER;
			//读取本地sqlite数据
			//var getdata:DbData = new DbData();
			//getdata.init();
			//setTimeout(init,1);
			//延时第二帧刷新场景大小，pc调试用
			setTimeout(login,1);	
			//init();
			//关闭窗口
			win = stage.nativeWindow;
			//win.addEventListener(Event.CLOSE,onClose);
		}
		private function onClose(e:Event):void{
			playerdialog.saveData();
		}
		//登录
		private function login():void{
			GameInit.m_stage = stage;
			if(!userlogin)
				userlogin = new UserLogin();
			userlogin.addEventListener(CommEvent.LOGIN,loaddataHandler);
			this.addChild(userlogin);
		}
		//加载数据
		private function loaddataHandler(e:CommEvent = null):void{			
			loaddata = new LoadData();
			loaddata.addEventListener(CommEvent.LOADCOMPLETE,init);
			this.addChild(loaddata);
		}
		private function init(e:CommEvent = null):void{	
			//GameInit.m_stage = stage;
			var bili:Number = stage.fullScreenWidth/480;
			
			PlayerInit.init();
			//背景场景地图界面
			if (!maplayer)
				maplayer = new MapLayer;			
			maplayer.addEventListener(CommEvent.GAMEOVER,gameOver);
			this.addChild(maplayer);
			//迷宫界面
			if (!mazedialog)
				mazedialog = new MazeDialog;
			this.addChild(mazedialog);
			//上下功能条
			if (!upui)
				upui = new UpUI;
			this.addChild(upui);
			if (!bottomui)
				bottomui = new BottomUI;
			bottomui.y = stage.fullScreenHeight/bili-bottomui.height;
			this.addChild(bottomui);	
			//玩家信息面板
			if (!playerdialog)
				playerdialog = new PlayerDialog;
			this.addChild(playerdialog);
			//修炼面板
			if (!xiuliandialog)
				xiuliandialog = new XiulianDialog;
			this.addChild(xiuliandialog);	
			//背包面板
			if (!bagdialog)
				bagdialog = new BagDialog;
			this.addChild(bagdialog);			
			//技能面板
			if (!skilldialog)
				skilldialog = new SkillDialog;
			this.addChild(skilldialog);				
			//关卡面板
			if (!customdialog)
				customdialog = new CustomDialog;
			this.addChild(customdialog);
			//战斗场景
			if (!fightlayer)
				fightlayer = new FightLayer;			
			//fightlayer.addEventListener(CommEvent.GAMEOVER,gameOver);
			this.addChild(fightlayer);
			//alert面板
			alertSpr = new Sprite();
			this.addChild(alertSpr);	
			//最顶端层，暂时放tooltip提示
			topSpr = new Sprite();
			this.addChild(topSpr);
			
		}
		public function gameOver(e:CommEvent):void{
			//this.removeChild(maplayer);
		}
	}
}