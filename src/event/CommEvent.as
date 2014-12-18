package event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author oiht
	 */
	public class CommEvent extends Event
	{
		public static const GAMEOVER:String = "gameover";
		public static const LOGIN:String = "login";
		public static const LOADCOMPLETE:String = "loadcomplete";
		public static const CHANGEDATA:String = "changedata";
		public var data:Array = new Array;
		public var obj:Object = new Object;
		public var bol:Boolean = true;;
		public function CommEvent(type:String) 
		{
			super(type);
		}		
	}
}