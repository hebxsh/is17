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
		public var data:Array = new Array;
		public function CommEvent(type:String) 
		{
			super(type);
		}
		
	}

}