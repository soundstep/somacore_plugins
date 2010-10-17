package {
	import com.soma.debugger.tests.support.TestEvent;
	import com.bit101.components.PushButton;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.debugger.SomaDebugger;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.tests.support.TestCommand;
	import com.soma.debugger.vo.SomaDebuggerVO;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Date:</b> Oct 17, 2010<br />	 * @example	 * <listing version="3.0"></listing>	 */		public class Main extends Sprite {
		private var _debugger:ISomaPlugin;
		private var _soma:ISoma;
		//------------------------------------		// private, protected properties		//------------------------------------						//------------------------------------		// public properties		//------------------------------------								//------------------------------------		// constructor		//------------------------------------				public function Main() {
			initialize();
		}

		private function initialize():void {
			stage.frameRate = 31;			stage.align = StageAlign.TOP_LEFT;			stage.scaleMode = StageScaleMode.NO_SCALE;
			SomaDebugger.WEAK_REFERENCE = false;
			_soma = new Soma(stage);
			_soma.addCommand(TestEvent.TEST, TestCommand);
			_debugger = _soma.createPlugin(SomaDebugger, new SomaDebuggerVO(_soma, SomaDebugger.NAME_DEFAULT, _soma.getCommands(), true, true));
			createInterface();
		}
		
		private function debug(obj:Object, info:String = null):void {
			dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.PRINT, obj, info));
		}		
		private function createInterface():void {
			
			new PushButton(this, 10, 10, "Int", buttonsHandler);
			new PushButton(this, 120, 10, "Number", buttonsHandler);
			new PushButton(this, 230, 10, "Uint", buttonsHandler);
			new PushButton(this, 340, 10, "String", buttonsHandler);
			new PushButton(this, 450, 10, "Class", buttonsHandler);
			new PushButton(this, 560, 10, "Array", buttonsHandler);
			
			new PushButton(this, 10, 40, "Vector", buttonsHandler);
			new PushButton(this, 120, 40, "Boolean", buttonsHandler);			new PushButton(this, 230, 40, "Class built-in", buttonsHandler);			new PushButton(this, 340, 40, "Dictionary", buttonsHandler);			new PushButton(this, 450, 40, "Command", buttonsHandler);			new PushButton(this, 560, 40, "Info", buttonsHandler);
		}

		private function buttonsHandler(e:MouseEvent):void {
			switch (PushButton(e.currentTarget).label) {
				
				case "Int":
					debug(1);
					break;
				case "Number":
					debug(Math.PI);
					break;
				case "Uint":
					debug(0xFF00FF);
					break;
				case "String":
					debug("Print a String");
					break;
				case "Class":
					debug(_debugger);
					break;
				case "Array":
					debug([1, "string", this, 1.111, "data"]);
					break;
					
				case "Vector":
					var v1:Vector.<String> = new Vector.<String>();
					v1.push("First String");
					v1.push("Second String");
					v1.push("Third String");
					debug(v1);
					break;
				case "Boolean":
					debug(true);
					break;
				case "Class built-in":
					debug(new MovieClip());
					break;
				case "Dictionary":
					var d1:Dictionary = new Dictionary();
					d1["key string"] = "value string";
					d1[1] = 1;
					d1[this] = this;
					debug(d1);
					break;
				case "Command":
					dispatchEvent(new TestEvent(TestEvent.TEST, this));
					break;
				case "Info":
					debug("Info Value", "INFO DESCRIPTION");
					break;
					
			}
		}
				//		// PRIVATE, PROTECTED		//________________________________________________________________________________________________						//		// PUBLIC		//________________________________________________________________________________________________							}}