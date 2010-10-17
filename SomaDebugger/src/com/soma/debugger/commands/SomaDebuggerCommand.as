/**
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 * 
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and
 * limitations under the License.
 * 
 * The Original Code is SomaDebugger.
 * 
 * The Initial Developer of the Original Code is Romuald Quantin.
 * romu@soundstep.com (www.soundstep.com).
 * 
 * Portions created by
 * 
 * Initial Developer are Copyright (C) 2008-2010 Soundstep. All Rights Reserved.
 * All Rights Reserved.
 * 
 */
 
 package com.soma.debugger.commands {
	import com.soma.core.controller.Command;
	import com.soma.core.interfaces.ICommand;
	import com.soma.debugger.events.SomaDebuggerEvent;
	import com.soma.debugger.wires.SomaDebuggerWire;

	import flash.events.Event;

	/**
	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />
	 * <b>Class version:</b> v1.0.0<br />
	 * <b>Actionscript version:</b> 3.0<br />
	 * <b>Copyright:</b>
	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 
	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />
	 * <br />
	 * <b>Usage:</b><br />
	 * @example
	 * <listing version="3.0">
	 * </listing>
	 */
	
	public class SomaDebuggerCommand extends Command implements ICommand {

		//------------------------------------
		// private, protected properties
		//------------------------------------
		
		

		//------------------------------------
		// public properties
		//------------------------------------
		
		
		
		//------------------------------------
		// constructor
		//------------------------------------
		
		public function SomaDebuggerCommand() {
			
		}
		
		//
		// PRIVATE, PROTECTED
		//________________________________________________________________________________________________
		
		
		
		// PUBLIC
		//________________________________________________________________________________________________
		
		public function execute(event:Event):void {
			try {
				var debuggerEvent:SomaDebuggerEvent = event as SomaDebuggerEvent;
				var debuggerName:String = (debuggerEvent.debuggerName == null || debuggerEvent.debuggerName == "") ? "Soma::SomaDebugger" : debuggerEvent.debuggerName;
				var wire:SomaDebuggerWire = getWire(debuggerName) as SomaDebuggerWire;
				if (wire != null) {
					switch (event.type) {
						case SomaDebuggerEvent.SHOW_DEBUGGER:
							wire.show();
							break;
						case SomaDebuggerEvent.HIDE_DEBUGGER:
							wire.hide();
							break;
						case SomaDebuggerEvent.MOVE_TO_TOP:
							wire.moveToTop();
							break;
						case SomaDebuggerEvent.PRINT:
							wire.print(SomaDebuggerEvent(event).message, SomaDebuggerEvent(event).info);
							break;
						case SomaDebuggerEvent.CLEAR:
							wire.clear();
							break;
					}
				}
			} catch (err:Error) {
				trace("Error in ", this, " ", err.message);
			}
		}
		
	}
}