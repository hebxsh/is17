package dialogs
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import UI.MyText;
	
	import data.PlayerInit;
	import data.ColorInit;

	public class UpUI extends Sprite
	{	
		private var nameStr:MyText = new MyText();
		private var powerNum:MyText = new MyText();
		private var knowledgeNum:MyText = new MyText();
		private var matrixNum:MyText = new MyText();
		public function UpUI()
		{
			init();
		}
		private function init():void{
			this.graphics.beginFill(ColorInit.uiUpColor);
			this.graphics.drawRect(0,0,480,40);			
	
			//var bloodTxt:TextField = new TextField();
			//createText(bloodTxt,0,5,"气血");
			var powerTxt:TextField = new TextField();
			createText(120,5,"体力");
			var knowledgeTxt:TextField = new TextField();
			createText(240,5,"学识");
			var matrixTxt:TextField = new TextField();
			createText(360,5,"阵法");
			
			createDynamicText(nameStr,10,5, PlayerInit.name.toString());
			createDynamicText(powerNum,160,5,PlayerInit.tili.toString());
			createDynamicText(knowledgeNum,280,5,PlayerInit.xueshi.toString());
			createDynamicText(matrixNum,400,5,PlayerInit.zhenfa.toString());
		}
		private function createText(x:int,y:int,str:String = ""):void{
			var tf:MyText = new MyText(str);
			tf.x = x;
			tf.y = y;
			this.addChild(tf);
		}
		//添加动态文本
		private function createDynamicText(tf:MyText,x:int,y:int,str:String = ""):void{
			tf.setText(str);
			tf.x = x;
			tf.y = y;
			this.addChild(tf);
		}
		public function Refresh():void{
			//bloodNum.htmlText = PlayerInit.p_hp.toString();
			powerNum.setText(PlayerInit.tili.toString());
			knowledgeNum.setText(PlayerInit.xueshi.toString());
			matrixNum.setText(PlayerInit.zhenfa.toString());
		}
	}
}