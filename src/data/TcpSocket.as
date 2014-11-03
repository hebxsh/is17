package data
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	public class TcpSocket extends Socket
	{
		
		private static var buffer:ByteArray = new ByteArray;
		private static var messageData:ByteArray = new ByteArray;
		private static var fun_obj:Object = new Object;
		
		protected static var _instance:TcpSocket;
		static public function getMe():TcpSocket
		{
			if(!_instance)
				_instance = new TcpSocket;
			return _instance;
		}
		
		public function TcpSocket(host:String=null, port:int=0)
		{
			super(host, port);
			addEventListener(Event.CLOSE, closeHandler);
			addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			addEventListener(Event.CONNECT, connectHandler);
		}
		
		private function dataHandler(e:Event):void
		{
			readBytes(buffer, buffer.length, bytesAvailable);
			
			buffer.position = 0;
			
			var messageLength:int;
			
			while(buffer.bytesAvailable >= 2)
			{
				messageLength = buffer.readShort();
				
				if (messageLength-1 <= buffer.bytesAvailable)
				{
					messageData.length = 0;
					buffer.readBytes(messageData, 0, messageLength-1);
					var head:int = messageData.readShort();
					messageData.position = 0;
					trace("head=============",head);
					fun_obj[head](messageData);
				}
				else
				{
					buffer.position -= 2;
					break;
				}
			}
			
			var restLength:int = buffer.bytesAvailable;
			buffer.readBytes(buffer, 0, restLength);
			buffer.length = restLength;
		}
		
		private function connectHandler(e:Event):void
		{
			trace("connect suc");
		}
		
		private function closeHandler(e:Event):void
		{
			this.close();
		}
		
		public function registerBackFun(head:int, backFun:Function):void
		{
			fun_obj[head] = backFun;
		}
		
		public function sendData(head:int,byte:ByteArray,backFun:Function):void
		{
			if(byte && byte.length && connected){
				fun_obj[head] = backFun;
//				this.writeInt(head);
				this.writeBytes(byte);
				this.flush();
			}
		}
		
		override public function connect(host:String, port:int):void
		{
			super.connect(host,port);
		}
		
		override public function close():void
		{
			super.close();
			fun_obj = new Object;
		}
		
	}
}