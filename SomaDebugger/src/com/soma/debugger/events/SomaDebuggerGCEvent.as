/** * The contents of this file are subject to the Mozilla Public License * Version 1.1 (the "License"); you may not use this file except in compliance * with the License. You may obtain a copy of the License at *  * http://www.mozilla.org/MPL/ *  * Software distributed under the License is distributed on an "AS IS" basis, * WITHOUT WARRANTY OF ANY KIND, either express or implied. * See the License for the specific language governing rights and * limitations under the License. *  * The Original Code is SomaDebugger. *  * The Initial Developer of the Original Code is Romuald Quantin. * romu@soundstep.com (www.soundstep.com). *  * Portions created by *  * Initial Developer are Copyright (C) 2008-2010 Soundstep. All Rights Reserved. * All Rights Reserved. *  */  package com.soma.debugger.events {	import flash.events.Event;	/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> v2.0.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Copyright:</b>	 * Mozilla Public License 1.1 (MPL 1.1)<br /> 	 * <a href="http://www.opensource.org/licenses/mozilla1.1.php" target="_blank">http://www.opensource.org/licenses/mozilla1.1.php</a><br />	 * <br />	 * <b>Usage:</b><br />	 * @example	 * <listing version="3.0">	 * </listing>	 */		public class SomaDebuggerGCEvent extends Event {		//------------------------------------		// private, protected properties		//------------------------------------				//------------------------------------		// public properties		//------------------------------------				public static const ADD_WATCHER:String = "Soma::SomaDebuggerGCEvent.ADD_WATCHER";		public static const REMOVE_WATCHER:String = "Soma::SomaDebuggerGCEvent.REMOVE_WATCHER";		public static const REMOVE_ALL_WATCHERS:String = "Soma::SomaDebuggerGCEvent.REMOVE_ALL_WATCHERS";		public static const FORCE_GC:String = "Soma::SomaDebuggerGCEvent.FORCE_GC";				public var debuggerName:String;		public var nameObjectToWatch:String;		public var objectToWatch:Object;		//------------------------------------		// constructor		//------------------------------------				public function SomaDebuggerGCEvent(type:String, nameObjectToWatch:String = null, objectToWatch:Object = null, debuggerName:String = null, bubbles:Boolean = true, cancelable:Boolean = false) {			this.nameObjectToWatch = nameObjectToWatch;			this.objectToWatch = objectToWatch;			this.debuggerName = debuggerName;			super(type, bubbles, cancelable);		}				//		// PRIVATE, PROTECTED		//________________________________________________________________________________________________				//		// PUBLIC		//________________________________________________________________________________________________				override public function clone():Event {			return new SomaDebuggerGCEvent(type, nameObjectToWatch, objectToWatch, debuggerName, bubbles, cancelable);		}				override public function toString():String {			return formatToString("SomaDebuggerGCEvent", "nameObjectToWatch", "objectToWatch", "debuggerName", "type", "bubbles", "cancelable", "eventPhase");		}			}}