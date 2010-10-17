package {
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.MouseEvent;
	import com.bit101.components.PushButton;
	import com.soma.core.Soma;
	import com.soma.core.interfaces.ISoma;
	import com.soma.core.interfaces.ISomaPlugin;
	import com.soma.debugger.SomaDebugger;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.vo.SomaDebuggerVO;

	import flash.display.Sprite;
	
		private var _debugger:ISomaPlugin;

			initialize();
		}

		private function initialize():void {
			stage.frameRate = 31;
			SomaDebugger.WEAK_REFERENCE = false;
			var soma:ISoma = new Soma(stage);
			_debugger = soma.createPlugin(SomaDebugger, new SomaDebuggerVO(soma, SomaDebugger.NAME_DEFAULT, soma.getCommands(), true, true));
			createInterface();
		}
		
		private function debug(obj:Object):void {
			dispatchEvent(new SomaDebuggerEvent(SomaDebuggerEvent.PRINT, obj));
		}
		private function createInterface():void {
			
			new PushButton(this, 10, 10, "Int", buttonsHandler);
			new PushButton(this, 120, 10, "Number", buttonsHandler);
			new PushButton(this, 230, 10, "Uint", buttonsHandler);
			new PushButton(this, 340, 10, "String", buttonsHandler);
			new PushButton(this, 450, 10, "Class", buttonsHandler);
			new PushButton(this, 560, 10, "Array", buttonsHandler);
			
			new PushButton(this, 10, 40, "Vector", buttonsHandler);
			new PushButton(this, 120, 40, "Boolean", buttonsHandler);
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
					debug(d1);
					break;
					
			}
		}
		