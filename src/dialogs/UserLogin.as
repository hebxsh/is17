package dialogs
{	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.Socket;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import UI.MyButton;
	import UI.MyText;
	
	import data.ColorInit;
	import data.DataPool;
	import data.GameInit;
	
	import event.CommEvent;


	public class UserLogin extends DialogObject
	{
		private var uinput:TextField;
		private var pinput:TextField;
		private var socket:Socket;

		public function UserLogin()
		{
			init();
		}
		private function init():void{
			this.visible = true;
			theTitle("登 陆");
			this.graphics.beginFill(ColorInit.dialogBgColor);
			this.graphics.drawRect(0,0,GameInit.m_stage.stageWidth,GameInit.m_stage.stageHeight);
			
			var spr:Sprite = new Sprite;
			spr.x = 80;
			spr.y = 200;
			this.addChild(spr);
			var utxt:MyText = new MyText("用户名：");
			var ptxt:MyText = new MyText("密　码：");
			ptxt.y = 60;
			spr.addChild(utxt);
			spr.addChild(ptxt);
			

			
			var my_fmt:TextFormat = new TextFormat();//常用样式
			my_fmt.size = 20;
			my_fmt.font = "微软雅黑";
			
			uinput = new TextField();
			uinput.type = TextFieldType.INPUT;
			uinput.x = utxt.width + utxt.x;
			uinput.width = 200;
			uinput.height = 28;
			uinput.text = "十七";
			uinput.defaultTextFormat = my_fmt;
			spr.addChild(uinput);
			pinput = new TextField();
			pinput.type = TextFieldType.INPUT;
			pinput.x = utxt.width + utxt.x;
			pinput.y = 60;
			pinput.width = 200;
			pinput.height = 28;
			pinput.text = "111";
			pinput.displayAsPassword = true;
			pinput.defaultTextFormat = my_fmt;
			spr.addChild(pinput);
			
			spr.graphics.lineStyle(1,0x000000);
			spr.graphics.beginFill(ColorInit.dialogBgColor);
			spr.graphics.drawRect(utxt.width + utxt.x ,0,200,uinput.height);
			spr.graphics.drawRect(utxt.width + utxt.x ,60,200,uinput.height);
			
			var login:MyButton = new MyButton("登 陆",0xccaa77,70);
			login.x = 140;
			login.y = 360;
			login.addEventListener(MouseEvent.CLICK,loginHandler);
			this.addChild(login);
			var regist:MyButton = new MyButton("注 册",0xccaa77,70);
			regist.x = 250;
			regist.y = 360;
			regist.addEventListener(MouseEvent.CLICK,loginHandler);
			this.addChild(regist);
		}
		private function loginHandler(e:MouseEvent):void{	
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderComplete);
			var res:URLRequest = new URLRequest(GameInit.LOGINURL);
			res.method = URLRequestMethod.POST;
			var ver:URLVariables = new URLVariables();
			ver.username = uinput.text;
			ver.password = pinput.text;
			res.data = ver;
			loader.load(res);			
		}
		private function loaderComplete(e:Event):void{
			var userdata:Object = JSON.parse(e.target.data);
			DataPool.getArr("user").push(userdata[0]);
			this.visible = false;
			var evt:CommEvent = new CommEvent(CommEvent.LOGIN);
			dispatchEvent(evt);
		}
	}
}